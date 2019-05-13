//
//  gameRule.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/13.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

//import Foundation

import UIKit

class gameRule: UIViewController {
    
    @IBAction func knowButton(_ sender: Any) {
        let controller = UIAlertController(title: "喵喵喵", message: "咖波最喜歡吃的東西是？", preferredStyle: .actionSheet)
        let names = ["小雞", "肉肉", "亞拉"]
        for name in names {
            let action = UIAlertAction(title: name, style: .default) { (action) in
                print(action.title!)
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
}
