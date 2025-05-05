// SimpleToastSkew.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

private struct RotationModifier: ViewModifier {
    let amount: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle(degrees: amount),
                axis: (x: 1.0, y: 0.01, z: 0.01),
                anchor: .top,
                perspective: 1.0
            )
    }
}

public extension AnyTransition {
    /// skew transition
    static var skew: AnyTransition {
        .modifier(
            active: RotationModifier(amount: 90),
            identity: RotationModifier(amount: 0)
        )
    }
}

/// Modifier for the skewing animation
internal struct SimpleToastSkew: SimpleToastModifier {
    @Binding public var showToast: Bool
    public let options: SimpleToastOptions?

    public func body(content: Content) -> some View {
        content
            .transition(
                AnyTransition.skew
                    .combined(with: .scale(scale: 0.01, anchor: .top))
                    .animation(options?.animation ?? .linear)
            )
            .zIndex(1)
    }
}
