// SimpleToastFade.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

/// Modifier for the fade animation
internal struct SimpleToastFade: SimpleToastModifier {
    @Binding public var showToast: Bool
    public let options: SimpleToastOptions?

    public func body(content: Content) -> some View {
        content
            .transition(AnyTransition.opacity.animation(options?.animation ?? .linear))
            .opacity(showToast ? 1 : 0)
            .zIndex(1)
    }
}
