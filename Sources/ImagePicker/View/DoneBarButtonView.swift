//
//  DoneBarButtonView.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

class DoneBarButtonView: UIBarButtonItem {
    // MARK: - Widgets

    private lazy var badge: UILabel = {
        let view = UILabel(frame: .zero)
//        view.backgroundColor = tintColor
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let bundle = Bundle(for: UIButton.self)
        let doneTitle = bundle.localizedString(forKey: "Done", value: nil, table: nil)
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            button.setTitle(doneTitle, for: state)
        }
        return button
    }()

    // MARK: - Public

    init(presenter: ImagePickerPresetnerProtocol) {
        super.init()

        let stackView = UIStackView(arrangedSubviews: [badge, button])
        stackView.spacing = 2
        stackView.axis = .horizontal
        customView = stackView
        observeCountChange()
        button.addTarget(presenter, action: #selector(ImagePickerPresetnerProtocol.complete), for: .touchUpInside)

        updateState(with: presenter.selected.count)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func observeCountChange() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recieved(notification:)),
            name: Notifications.assetsSelectionChanged,
            object: nil
        )
    }

    @objc private func recieved(notification: Notification) {
        let count = Notifications.extractCount(from: notification) ?? 0
        updateState(with: count)
    }

    private func updateState(with count: Int) {
        button.isEnabled = count > 0
        badge.text = count > 0 ? count.description : ""
    }
}
