//
//  AlbumTableCell.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import UIKit

class AlbumTableCell: UITableViewCell {
    static let cellId = "albumTableCell"

    // MARK: - Aliases

    // MARK: - Instance variables

    private(set) lazy var albumImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private(set) lazy var albumTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var albumCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Public

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
        albumTitle.text = nil
        albumCount.text = nil
    }

    // MARK: - Private

    private func buildView() {
        addSubview(albumImageView)
        addSubview(albumTitle)
        addSubview(albumCount)

        let imageViewHeightConstraint = albumImageView.heightAnchor.constraint(equalToConstant: 84)
        imageViewHeightConstraint.priority = UILayoutPriority.defaultHigh

        NSLayoutConstraint.activate([
            imageViewHeightConstraint,
            albumImageView.widthAnchor.constraint(equalToConstant: 84),

            albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            albumImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumImageView.trailingAnchor.constraint(equalTo: albumTitle.leadingAnchor, constant: -16),
            albumImageView.trailingAnchor.constraint(equalTo: albumCount.leadingAnchor, constant: -16),
            albumTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            albumCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),

            albumTitle.bottomAnchor.constraint(equalTo: albumImageView.centerYAnchor),
            albumCount.topAnchor.constraint(equalTo: albumImageView.centerYAnchor),
        ])
    }
}
