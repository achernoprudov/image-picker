//
//  ImagePickerContext.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

/// Shared context for photo selection process
class ImagePickerContext {
    // MARK: - Instance variables

    let theme: Theme
    let config: Config

    // MARK: - Public

    init(theme: Theme, config: Config) {
        self.theme = theme
        self.config = config
    }

    // MARK: - Private
}
