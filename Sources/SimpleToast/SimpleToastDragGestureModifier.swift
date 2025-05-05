// SimpleToastDragGestureModifier.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

internal struct SimpleToastDragGestureModifier: ViewModifier {
    @Binding public var offset: CGSize
    public let options: SimpleToastOptions
    public var onCompletion: () -> Void

    @State private var delta: CGFloat = 0

    #if !os(tvOS)
        private let maxGestureDelta: CGFloat = 20

        /// Dimiss the toast on drag
        private var dragGesture: some Gesture {
            DragGesture()
                .onChanged { [self] in
                    if options.disableDragGesture { return }

                    delta = 0

                    switch options.alignment {
                    case .top, .topLeading, .topTrailing:
                        if $0.translation.height <= offset.height {
                            offset.height = $0.translation.height
                        }
                        delta += abs(offset.height)

                    case .bottom, .bottomLeading, .bottomTrailing:
                        if $0.translation.height >= offset.height {
                            offset.height = $0.translation.height
                        }
                        delta += abs(offset.height)

                    case .leading:
                        if $0.translation.width <= offset.width {
                            offset.width = $0.translation.width
                        }
                        delta += abs(offset.width)

                    case .trailing:
                        if $0.translation.width >= offset.width {
                            offset.width = $0.translation.width
                        }
                        delta += abs(offset.width)

                    default:
                        if $0.translation.height < offset.height {
                            offset.height = $0.translation.height
                        }
                        delta += abs(offset.height)
                    }
                }
                .onEnded { [self] _ in
                    if options.disableDragGesture { return }

                    if delta >= maxGestureDelta {
                        return onCompletion()
                    }

                    offset = .zero
                }
        }
    #endif

    public func body(content: Content) -> some View {
        content
        #if !os(tvOS)
        .gesture(dragGesture)
        #endif
    }
}
