//
//  DoneButtonView.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

class DoneBarButtonView: UIButton {
    // MARK: - Widgets

    private lazy var badge: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "3"
        view.textColor = .white
        view.backgroundColor = tintColor
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Done"
        label.textColor = tintColor
        return label
    }()

    // MARK: - Instance variables

    var count: Int = 0 {
        didSet {
            isEnabled = count > 0
            badge.text = count > 0 ? count.description : ""
        }
    }

    // MARK: - Public

    init(presenter: ImagePickerPresetnerProtocol) {
        super.init(frame: .zero)
        buildView()
        observeCountChange()
        count = presenter.selected.count
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func buildView() {
        let stackView = UIStackView(arrangedSubviews: [badge, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func observeCountChange() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recieved(notification:)),
            name: Notifications.assetsSelectionChanged,
            object: nil
        )
    }

    @objc private func recieved(notification: Notification) {
        count = Notifications.extractCount(from: notification) ?? 0
    }
}
