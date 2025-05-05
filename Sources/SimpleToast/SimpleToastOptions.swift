// SimpleToastOptions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

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
        /// fades
        case fade
        /// slides
        case slide
        /// scales
        case scale
        /// skews
        case skew
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
    public var backdropColor: Color = .white

    /// Creates a new instance of `SimpleToastOptions`.
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the toast (e.g., `.top` or `.bottom`).
    ///   - hideAfter: The time interval after which the toast will be hidden. Pass `nil` for no auto-hide.
    ///   - backdrop: The color of the backdrop. Pass `nil` for no backdrop.
    ///   - animation: The animation type for the toast. Defaults to `.linear`.
    ///   - modifierType: The type of modifier to apply to the toast (e.g., `.fade`, `.slide`).
    ///   - dismissOnTap: A flag indicating whether the toast should be dismissed when tapped. Defaults to `true`.
    ///   - disableDragGesture: A flag indicating whether drag gestures should be disabled. Defaults to `false`.
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

public extension SimpleToastOptions {
    /// Creates a new instance of `SimpleToastOptions` (deprecated).
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the toast (e.g., `.top` or `.bottom`).
    ///   - hideAfter: The time interval after which the toast will be hidden. Pass `nil` for no auto-hide.
    ///   - showBackdrop: A flag indicating whether a backdrop should be shown. Deprecated in favor of `backdrop`.
    ///   - backdropColor: The color of the backdrop. Deprecated in favor of `backdrop`.
    ///   - animation: The animation type for the toast. Pass `nil` for no animation.
    ///   - modifierType: The type of modifier to apply to the toast (e.g., `.fade`, `.slide`).
    ///   - dismissOnTap: A flag indicating whether the toast should be dismissed when tapped. Defaults to `true`.
    ///   - disableDragGesture: A flag indicating whether drag gestures should be disabled. Defaults to `false`.
    @available(
        *,
        deprecated,
        renamed: "init(alignment:hideAfter:backdrop:animation:modifierType:dismissOnTap:disableDragGesture:)"
    )
    init(
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
