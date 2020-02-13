//
//  DoneBarButtonView.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 29.01.2020.
//

import UIKit

class DoneBarButtonView: UIBarButtonItem {
    // MARK: - Instance variables

    private let theme: Theme

    // MARK: - Widgets

    private lazy var countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)

        return label
    }()

    private lazy var countBadge: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let view = UIView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = theme.color.accent
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = theme.color.accent
        button.setTitle(L10N.done, for: .normal)
        button.titleLabel?.font = theme.font.body
        return button
    }()

    // MARK: - Public

    init(presenter: ImagePickerPresetnerProtocol, theme: Theme) {
        self.theme = theme
        super.init()

        countBadge.addSubview(countLabel)

        NSLayoutConstraint.activate([
            countBadge.leadingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -3),
            countBadge.trailingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 3),

            countBadge.heightAnchor.constraint(equalToConstant: 20),
            countBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),

            countLabel.centerYAnchor.constraint(equalTo: countBadge.centerYAnchor),
        ])

        let stackView = UIStackView(arrangedSubviews: [countBadge, button])
        stackView.spacing = 4
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
        countBadge.isHidden = count == 0
        countLabel.text = count > 99 ? "99+" : count.description
    }
}
