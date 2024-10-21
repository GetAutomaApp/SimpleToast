//
//  SimpleToast.swift
//
//  This file is part of the SimpleToast Swift library: https://github.com/sanzaru/SimpleToast
//  Created by Martin Albrecht on 12.07.20.
//  Licensed under Apache License v2.0
//

import SwiftUI
import Combine

struct SimpleToast<SimpleToastContent: View>: ViewModifier {
    @Binding var showToast: Bool

    let options: SimpleToastOptions
    let onDismiss: (() -> Void)?

    @State private var offset: CGSize = .zero
    @State private var isInit = false
    @State private var viewState = false
    @State private var cancelable: Cancellable?

    private let toastInnerContent: SimpleToastContent

    @ViewBuilder
    private var toastRenderContent: some View {
        if showToast {
            Group {
                switch options.modifierType {
                case .slide:
                    toastInnerContent
                        .modifier(SimpleToastSlide(showToast: $showToast, options: options))
                        .modifier(SimpleToastDragGestureModifier(offset: $offset, options: options, onCompletion: dismiss))

                case .scale:
                    toastInnerContent
                        .modifier(SimpleToastScale(showToast: $showToast, options: options))
                        .modifier(SimpleToastDragGestureModifier(offset: $offset, options: options, onCompletion: dismiss))

                case .skew:
                    toastInnerContent
                        .modifier(SimpleToastSkew(showToast: $showToast, options: options))
                        // .gesture(dragGesture)

//                case .curtain:
//                    toastInnerContent
//                        .modifier(SimpleToastCurtain(showToast: $showToast, options: options))
//                        .onTapGesture(perform: dismiss)

                default:
                    toastInnerContent
                        .modifier(SimpleToastFade(showToast: $showToast, options: options))
                        .modifier(SimpleToastDragGestureModifier(offset: $offset, options: options, onCompletion: dismiss))
                }
            }
            .onTapGesture(perform: dismissOnTap)
            .onAppear(perform: setup)
            .onDisappear { isInit = false }
            .onReceive(Just(showToast), perform: update)
            .offset(offset)
        }
    }

    init(
        showToast: Binding<Bool>,
        options: SimpleToastOptions,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SimpleToastContent
    ) {
        self._showToast = showToast
        self.options = options
        self.onDismiss = onDismiss
        self.toastInnerContent = content()
    }

    func body(content: Content) -> some View {
        // Main view content
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Backdrop
            .overlay(
                Group { EmptyView() }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(options.backdrop?.edgesIgnoringSafeArea(.all))
                    .opacity(options.backdrop != nil && showToast ? 1 : 0)
                    .onTapGesture(perform: dismiss)
            )

            // Toast content
            .overlay(toastRenderContent, alignment: options.alignment)
    }

    /// Initialize the dismiss timer and set init variable
    private func setup() {
        dismissAfterTimeout()
        isInit = true
    }

    /// Update the dismiss timer if state has changed.
    ///
    /// This function is required, because the onAppear will not be triggered again until a full dismissal of the view
    /// happened. Retriggering the toast resulted in unset timers and thus never disappearing toasts.
    ///
    /// See [the GitHub issue](https://github.com/sanzaru/SimpleToast/issues/24) for more information.
    private func update(state: Bool) {
        // We need to keep track of the current view state and only update on changing values. The onReceive modifier
        // will otherwise constantly trigger updates when the toast is initialized with an Identifiable instead of Bool
        if state != viewState {
            viewState = state

            if isInit, viewState {
                dismissAfterTimeout()
            }
        }
    }

    /// Dismiss the sheet after the timeout specified in the options
    private func dismissAfterTimeout() {
        if let timeout = options.hideAfter, showToast, options.hideAfter != nil {
            cancelable = Timer.publish(every: timeout, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    cancelable?.cancel()
                    dismiss()
                }
        }
    }

    /// Dismiss the toast and reset all nessasary parameters
    private func dismiss() {
        withAnimation(options.animation) {
            cancelable?.cancel()
            showToast = false
            viewState = false
            offset = .zero

            onDismiss?()
        }
    }
    /// Dismiss the toast Base on dismissOnTap
    private func dismissOnTap() {
        if options.dismissOnTap ?? true {
            self.dismiss()
        }
    }
}

// MARK: - View extensions
public extension View {
    /// Present the sheet based on the state of a given binding to a boolean.
    ///
    /// - NOTE: The toast will be attached to the view's frame it is attached to and not the general UIScreen.
    /// - Parameters:
    ///   - isPresented: Boolean binding as source of truth for presenting the toast
    ///   - options: Options for the toast
    ///   - onDismiss: Closure called when the toast is dismissed
    ///   - content: Inner content for the toast
    /// - Returns: The toast view
    func simpleToast<SimpleToastContent: View>(
        isPresented: Binding<Bool>, options: SimpleToastOptions,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SimpleToastContent) -> some View {
        self.modifier(
            SimpleToast(showToast: isPresented, options: options, onDismiss: onDismiss, content: content)
        )
    }

    /// Present the sheet based on the state of a given optional item.
    /// If the item is non-nil the toast will be shown, otherwise it is dimissed.
    ///
    /// - NOTE: The toast will be attached to the view's frame it is attached to and not the general UIScreen.
    /// - Parameters:
    ///   - item: Optional item as source of truth for presenting the toast
    ///   - options: Options for the toast
    ///   - onDismiss: Closure called when the toast is dismissed
    ///   - content: Inner content for the toast
    /// - Returns: The toast view
    func simpleToast<SimpleToastContent: View, Item: Identifiable>(
        item: Binding<Item?>?, options: SimpleToastOptions,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SimpleToastContent
    ) -> some View {
        let bindingProxy = Binding<Bool>(
            get: { item?.wrappedValue != nil },
            set: {
                if !$0 {
                    item?.wrappedValue = nil
                }
            }
        )

        return self.modifier(
            SimpleToast(showToast: bindingProxy, options: options, onDismiss: onDismiss, content: content)
        )
    }
}

// MARK: - Deprecated
public extension View {
    /// Present the sheet based on the state of a given binding to a boolean.
    ///
    /// - NOTE: The toast will be attached to the view's frame it is attached to and not the general UIScreen.
    /// - Parameters:
    ///   - isShowing: Boolean binding as source of truth for presenting the toast
    ///   - options: Options for the toast
    ///   - onDismiss: Closure called when the toast is dismissed
    ///   - content: Inner content for the toast
    /// - Returns: The toast view
    @available(*, deprecated, renamed: "simpleToast(isPresented:options:onDismiss:content:)")
    func simpleToast<SimpleToastContent: View>(
        isShowing: Binding<Bool>, options: SimpleToastOptions,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SimpleToastContent) -> some View {
        self.modifier(
            SimpleToast(showToast: isShowing, options: options, onDismiss: onDismiss, content: content)
        )
    }
}
