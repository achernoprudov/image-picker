//
//  CancelBarButtonView.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

class CancelBarButtonView: UIBarButtonItem {
    // MARK: - Instance variables

    private let theme: Theme

    // MARK: - Widgets

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = theme.color.accent
        button.setTitle(L10N.cancel, for: .normal)
        button.titleLabel?.font = theme.font.body
        return button
    }()

    // MARK: - Public

    init(presenter: ImagePickerPresetnerProtocol, theme: Theme) {
        self.theme = theme
        super.init()
        customView = button
        button.addTarget(presenter, action: #selector(ImagePickerPresetnerProtocol.close), for: .touchUpInside)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
