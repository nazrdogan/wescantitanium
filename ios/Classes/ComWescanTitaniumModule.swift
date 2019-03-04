//
//  ComWescanTitaniumModule.swift
//  wescantitanium
//
//  Created by Nazir Dogan
//  Copyright (c) 2019 Your Company. All rights reserved.
//

import UIKit
import TitaniumKit
import WeScan

/**
 
 Titanium Swift Module Requirements
 ---
 
 1. Use the @objc annotation to expose your class to Objective-C (used by the Titanium core)
 2. Use the @objc annotation to expose your method to Objective-C as well.
 3. Method arguments always have the "[Any]" type, specifying a various number of arguments.
 Unwrap them like you would do in Swift, e.g. "guard let arguments = arguments, let message = arguments.first"
 4. You can use any public Titanium API like before, e.g. TiUtils. Remember the type safety of Swift, like Int vs Int32
 and NSString vs. String.
 
 */

@objc(ComWescanTitaniumModule)
class ComWescanTitaniumModule: TiModule,ImageScannerControllerDelegate {
    var scannerViewController: ImageScannerController
    override init() {
        scannerViewController = ImageScannerController()
        super.init()
    }
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        let enhancedImage = ["image": TiBlob.init(image: results.enhancedImage)]
         scannerViewController.dismiss(animated: true, completion: nil)
         self.fireEvent("success", with: enhancedImage)
    }
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scannerViewController.dismiss(animated: true, completion: nil)
        self.fireEvent("cancelled")
    }
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
         scannerViewController.dismiss(animated: true, completion: nil)
    
    }
    
  func moduleGUID() -> String {
    return "80b26ad6-d6bb-41bf-8fa6-f97133d2f2b2"
  }
  
  override func moduleId() -> String! {
    return "com.wescan.titanium"
  }
  override func startup() {
    super.startup()
    debugPrint("[DEBUG] \(self) loaded")
  }

  @objc(scan:)
 public func scan(args: Array<Any>?) {
    scannerViewController.imageScannerDelegate = self
    TiApp.controller()?.topContainerController()?.present(scannerViewController, animated: true)
    
  }
}
