//
//  Config.swift
//  ImagePicker
//
//  Created by Andrey Chernoprudov on 12.02.2020.
//

import Photos

public struct Config {
    public static let `default` = Config()

    public let albumsTitle: String
    public let mediaTypes: [PHAssetMediaType]

    public init(
        albumsTitle: String = "Albums",
        mediaTypes: [PHAssetMediaType] = [.image, .video]
    ) {
        self.albumsTitle = albumsTitle
        self.mediaTypes = mediaTypes
    }
}
