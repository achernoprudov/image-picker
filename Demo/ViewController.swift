//
//  ViewController.swift
//  Demo
//
//  Created by Andrey Chernoprudov on 28.01.2020.
//

import ImagePicker
import Photos
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presentImagePicker() {
        // TODO: move to ImagePickerController logic
        guard PHPhotoLibrary.authorizationStatus() == .authorized else {
            PHPhotoLibrary.requestAuthorization { [unowned self] status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.presentImagePicker()
                    }
                }
            }
            return
        }

        let imagePicker = ImagePickerController { selectedAssets in
            print("Selected assets: \(selectedAssets.debugDescription)")
        }
        present(imagePicker, animated: true, completion: nil)
    }
}
