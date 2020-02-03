//
//  L10N.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 03.02.2020.
//

import UIKit

enum L10N {
    static var done: String {
        let bundle = Bundle(for: UIButton.self)
        return bundle.localizedString(forKey: "Done", value: nil, table: nil)
    }

    static var close: String {
        let bundle = Bundle(for: UIButton.self)
        return bundle.localizedString(forKey: "Close", value: nil, table: nil)
    }
}
