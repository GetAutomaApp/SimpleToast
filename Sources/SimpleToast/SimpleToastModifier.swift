// SimpleToastModifier.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

/// Protocol defining the structure of a SimpleToast view modifier
/// The basic building blocks are a boolean value determining whether to show
///  the toast or not and an instance of a SimpleToastOptions object, which is optional.
@MainActor
internal protocol SimpleToastModifier: ViewModifier {
    var showToast: Bool { get set }
    var options: SimpleToastOptions? { get }
}
