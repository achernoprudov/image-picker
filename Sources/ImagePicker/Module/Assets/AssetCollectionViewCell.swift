// The MIT License (MIT)
//
// Copyright (c) 2015 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    // MARK: - Instance variables

    var theme: Theme! {
        didSet { checkmarkView.theme = theme }
    }

    var isAssetSelected: Bool = false {
        didSet {
            checkmarkView.isSelected = isAssetSelected
        }
    }

    // MARK: - Widgets

    let imageView: UIImageView = UIImageView(frame: .zero)

    private let checkmarkView: CheckmarkView = CheckmarkView(frame: .zero)

    // MARK: - Public

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setup views
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(checkmarkView)

        // Add constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            checkmarkView.heightAnchor.constraint(equalToConstant: 25),
            checkmarkView.widthAnchor.constraint(equalToConstant: 25),
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            checkmarkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        ])

        checkmarkView.isSelected = isAssetSelected
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Private
}
