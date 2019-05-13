//
//  Food.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/10.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

//import Foundation
import UIKit

class Food: UIButton {
    let foodX = 30
    let foodY = 30
    let screenX = 375//345
    let screenY = 812//570
    
    init(view: UIView) {
        // 初始化在螢幕中央
        super.init(frame: CGRect(x: 180, y: 330, width: foodX, height: foodY)) //180,330
        setImage(UIImage(named: "chicken"), for: .normal)
        // 設置食物的颜色為藍色
        //backgroundColor = UIColor.blue
        // 將Food添加到主要的view中顯示
        view.addSubview(self)
        // 當點擊food按鈕則觸發事件
        //addTarget(self, action: #selector(Food.changeFood), for: .touchDown)
        
    }
    // 编译器自動生成
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeFood(button: UIButton) {
        button.frame.origin = randomPostition()
    }
    
    // 點擊Food時，隨機改變Food座標
    func randomNum(num: Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    // 生成隨機座標
    func randomPostition() -> CGPoint {
        // 对产生的随机数按食物大小取整，方便后面蛇的吃食操作
        func round(value: Int) -> Int {
            return (value/foodX) * foodX
        }
        let currentX = round(value: randomNum(num: screenX))
        let currentY = round(value: (60 + randomNum(num: screenY))) //nav bar的欄位
        return CGPoint(x: currentX, y: currentY)
    }
    
}

