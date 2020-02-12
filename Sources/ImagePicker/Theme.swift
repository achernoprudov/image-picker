//
//  Theme.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import UIKit

/// Theme configuration
public struct Theme {
    public let font: Font
    public let color: Color

    public init(
        font: Font,
        color: Color
    ) {
        self.font = font
        self.color = color
    }

    public static let `default` = Theme(
        font: Theme.Font(
            body: UIFont.preferredFont(forTextStyle: .body),
            subheadline: UIFont.preferredFont(forTextStyle: .subheadline)
        ),
        color: Theme.Color(
            navigationBar: .systemGray,
            navigationBarTitle: .black,
            background: .white,
            foreground: .black,
            foregroundLight: .systemGray,
            accent: .systemBlue,
            selectionStroke: .white,
            selectionShadow: .black
        )
    )
}

// MARK: - Font

public extension Theme {
    struct Font {
        public let body: UIFont
        public let subheadline: UIFont

        public init(body: UIFont, subheadline: UIFont) {
            self.body = body
            self.subheadline = subheadline
        }
    }
}

// MARK: - Color

public extension Theme {
    struct Color {
        public let navigationBar: UIColor
        public let navigationBarTitle: UIColor
        public let background: UIColor
        public let foreground: UIColor
        public let foregroundLight: UIColor
        /// What color to fill the circle with, buttons tint color
        public let accent: UIColor
        /// Color for the actual checkmark
        public let selectionStroke: UIColor
        /// Shadow color for the circle
        public let selectionShadow: UIColor

        public init(
            navigationBar: UIColor,
            navigationBarTitle: UIColor,
            background: UIColor,
            foreground: UIColor,
            foregroundLight: UIColor,
            accent: UIColor,
            selectionStroke: UIColor,
            selectionShadow: UIColor
        ) {
            self.navigationBar = navigationBar
            self.navigationBarTitle = navigationBarTitle
            self.background = background
            self.foreground = foreground
            self.foregroundLight = foregroundLight
            self.accent = accent
            self.selectionStroke = selectionStroke
            self.selectionShadow = selectionShadow
        }
    }
}
