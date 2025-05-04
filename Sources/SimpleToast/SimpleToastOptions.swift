//
//  SimpleToastOptions.swift
//
//  This file is part of the SimpleToast Swift library: https://github.com/sanzaru/SimpleToast
//  Created by Martin Albrecht on 24.04.21.
//  Licensed under Apache License v2.0
//

import SwiftUI

/// Object for customizing the SimpleToast toast message
public struct SimpleToastOptions {
    /// Alignment of the toast (e.g. .top)
    public var alignment: Alignment

    /// `TimeInterval` defining the time after which the toast will be hidden.
    /// nil is default, which is equivalent to no hiding
    public var hideAfter: TimeInterval?

    /// The Backdrop Color
    public var backdrop: Color?

    /// Custom animation type
    public var animation: Animation?

    /// Flag dismiss on tap
    public var dismissOnTap: Bool? = false

    /// All available modifier types
    public enum ModifierType {
        case fade, slide, scale, skew
    }

    /// The type of SimpleToast modifier to apply
    public var modifierType: ModifierType

    /// Optional drag gesture handling
    public var disableDragGesture: Bool = false

    // Deprecated

    /// Flag determining if the backsdrop is shown
    @available(swift, deprecated: 0.5.1, renamed: "backdrop")
    public var showBackdrop: Bool? = false

    /// Color of the backdrop. Will be ignoroed when no backdrop is shown
    @available(swift, deprecated: 0.5.1, renamed: "backdrop")
    public var backdropColor: Color = Color.white

    public init(
        alignment: Alignment = .top,
        hideAfter: TimeInterval? = nil,
        backdrop: Color? = nil,
        animation: Animation = .linear,
        modifierType: ModifierType = .fade,
        dismissOnTap: Bool? = true,
        disableDragGesture: Bool = false
    ) {
        self.alignment = alignment
        self.hideAfter = hideAfter
        self.backdrop = backdrop
        self.animation = animation
        self.modifierType = modifierType
        self.dismissOnTap = dismissOnTap
        self.disableDragGesture = disableDragGesture
    }
}

// MARK: - Deprecated
extension SimpleToastOptions {
    @available(*, deprecated, renamed: "init(alignment:hideAfter:backdrop:animation:modifierType:dismissOnTap:disableDragGesture:)")
    public init(
        alignment: Alignment = .top,
        hideAfter: TimeInterval? = nil,
        showBackdrop: Bool? = true,
        backdropColor: Color = Color.white.opacity(0.9),
        animation: Animation? = nil,
        modifierType: ModifierType = .fade,
        dismissOnTap: Bool? = true,
        disableDragGesture: Bool = false
    ) {
        self.alignment = alignment
        self.hideAfter = hideAfter
        self.showBackdrop = showBackdrop
        self.backdropColor = backdropColor
        self.animation = animation
        self.modifierType = modifierType
        self.dismissOnTap = dismissOnTap
        self.disableDragGesture = disableDragGesture
    }
}
