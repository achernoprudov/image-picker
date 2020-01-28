//
//  ImagePickerController.swift
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import UIKit
import Photos

public class ImagePickerController: UINavigationController {
    
    // MARK: - Aliases
    
    public typealias SelectionHandler = (_ selectedAssets: [PHAsset]?) -> Void
    
    // MARK: - Instance variables
    
    private let selectionHanlder: SelectionHandler
    
    // MARK: - Public
    
    public init(handler: @escaping SelectionHandler) {
        self.selectionHanlder = handler
        
        
        super.init(rootViewController: <#T##UIViewController#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
}
