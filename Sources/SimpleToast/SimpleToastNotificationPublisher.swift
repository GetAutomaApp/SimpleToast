//
//  SimpleToastNotificationPublisher.swift
//  SimpleToast
//
//  This file is part of the SimpleToast Swift library: https://github.com/sanzaru/SimpleToast
//  Created by Martin Albrecht on 25.09.24.
//  Licensed under Apache License v2.0
//

import SwiftUI

/// Publishes a toast notification using NotificationCenter.
public struct SimpleToastNotificationPublisher {
    /// Publishes a toast notification using NotificationCenter.
    public static func publish<ToastNotification: Identifiable>(notification: ToastNotification) {
        NotificationCenter.default.post(name: .toastNotification, object: notification)
    }
}

private extension Notification.Name {
    /// Name for published `NotificationCenter.Publisher` notifications
    static let toastNotification = Notification.Name("SimpleToastNotification")
}

extension View {
    /// Handle NotificationCenter events for SimpleToast
    /// - Parameter action: The action to perform when a notification is received
    /// - Returns: The view the function is attached to
    public func onToastNotification<ToastNotification: Identifiable>(
        perform action: @escaping (ToastNotification?) -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(for: .toastNotification)) {
            action($0.object as? ToastNotification)
        }
    }
}
