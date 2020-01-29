//
//  Notifications.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

enum Notifications {
    // MARK: - Names

    static let assetsSelectionChanged = Notification.Name(rawValue: "AssetsSelectionChanged")

    // MARK: - Private constants

    private static let newCount = "newCount"

    // MARK: - Public

    static func postAssetsSelectionChanged(to count: Int) {
        let notification = Notification(
            name: assetsSelectionChanged,
            object: nil,
            userInfo: [newCount: count]
        )
        NotificationCenter.default.post(notification)
    }

    static func extractCount(from notification: Notification) -> Int? {
        guard notification.name == assetsSelectionChanged else {
            return nil
        }
        return notification.userInfo?[newCount] as? Int
    }
}
