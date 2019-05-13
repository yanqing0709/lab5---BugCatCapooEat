//
//  ScreenTop.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/13.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

//import Foundation

import UIKit
import SafariServices

class ScreenTop: UIViewController, SFSafariViewControllerDelegate  {

    @IBAction func webButton(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/capoocat/")
        {
            let safari = SFSafariViewController(url: url)
            safari.delegate = self
            present(safari, animated: true, completion: nil)
        }
    }
    
}
