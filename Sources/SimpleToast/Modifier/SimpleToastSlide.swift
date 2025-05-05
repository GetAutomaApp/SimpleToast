//
//  SimpleToastSlide.swift
//
//  This file is part of the SimpleToast Swift library: https://github.com/sanzaru/SimpleToast
//  Created by Martin Albrecht on 04.10.21.
//  Licensed under Apache License v2.0
//

import SwiftUI

/// Modifier foe the slide animation
internal struct SimpleToastSlide: SimpleToastModifier {
    @Binding public var showToast: Bool
    public let options: SimpleToastOptions?

    private var transitionEdge: Edge {
        if let pos = options?.alignment{
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
        return content
            .transition(AnyTransition.move(edge: transitionEdge).combined(with: .opacity))
            .animation(options?.animation ?? .default)
            .zIndex(1)
    }
}
