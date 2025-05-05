// SimpleToastNotificationPublisher.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import SwiftUI

/// Publishes a toast notification using NotificationCenter.
public enum SimpleToastNotificationPublisher {
    /// Publishes a toast notification using NotificationCenter.
    public static func publish(notification: some Identifiable) {
        NotificationCenter.default.post(name: .toastNotification, object: notification)
    }
}

private extension Notification.Name {
    /// Name for published `NotificationCenter.Publisher` notifications
    static let toastNotification = Notification.Name("SimpleToastNotification")
}

public extension View {
    /// Handle NotificationCenter events for SimpleToast
    /// - Parameter action: The action to perform when a notification is received
    /// - Returns: The view the function is attached to
    func onToastNotification<ToastNotification: Identifiable>(
        perform action: @escaping (ToastNotification?) -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(for: .toastNotification)) {
            action($0.object as? ToastNotification)
        }
    }
}
