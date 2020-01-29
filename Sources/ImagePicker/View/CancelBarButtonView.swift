//
//  CancelBarButtonView.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

class CancelBarButtonView: UIBarButtonItem {
    // MARK: - Instance variables

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let bundle = Bundle(for: UIButton.self)
        let doneTitle = bundle.localizedString(forKey: "Close", value: nil, table: nil)
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            button.setTitle(doneTitle, for: state)
        }
        return button
    }()

    // MARK: - Public

    init(presenter: ImagePickerPresetnerProtocol) {
        super.init()
        customView = button
        button.addTarget(presenter, action: #selector(ImagePickerPresetnerProtocol.close), for: .touchUpInside)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
}
