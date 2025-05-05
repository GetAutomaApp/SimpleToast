// SimpleToastSlide.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

/// Modifier foe the slide animation
internal struct SimpleToastSlide: SimpleToastModifier {
    @Binding public var showToast: Bool
    public let options: SimpleToastOptions?

    private var transitionEdge: Edge {
        if let pos = options?.alignment {
            switch pos {
            case .top, .topLeading, .topTrailing:
                return .top

            case .bottom, .bottomLeading, .bottomTrailing:
                return .bottom

            default:
                return .top
            }
        }

        return .top
    }

    public func body(content: Content) -> some View {
        content
            .transition(AnyTransition.move(edge: transitionEdge).combined(with: .opacity))
            .animation(options?.animation ?? .default)
            .zIndex(1)
    }
}
