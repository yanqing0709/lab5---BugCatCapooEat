//
//  BodyItem.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/10.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

// import Foundation

import UIKit

// 蛇的一段身體(frame)
class BodyItem: UIButton {
    
    // ? : 可能有值，可能無值（包裝盒）; ! : 強制打開取出包裝盒內的值（建議用if let避免nil的狀況）
    var nextItem: BodyItem?
    
    // 當某段身體的位置更新，也要更新自己的下一個身體
    override var frame: CGRect {
        set {
            if let next = nextItem {
                next.frame.origin = frame.origin
            }
            super.frame.origin = newValue.origin
        }
        get {
            return super.frame
        }
    }
    
    // 初始化蛇的一段身體
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 蛇的頭: 為了方向和吃食物的事件觸發
class SnakeHead: BodyItem {
    init() {
        super.init(frame: CGRect(x: 90, y: 90, width: 30, height: 30))
        // 增加頭的圖片
        setImage(UIImage(named: "capooHead"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchEdge(){
        if (frame.origin.x < 0) {
            frame.origin.x = 375
        } else if (frame.origin.x > 375) {//330
            frame.origin.x = 0
        } else if (frame.origin.y < 60) {
            frame.origin.y = 812
        } else if (frame.origin.y > 812) {//630
            frame.origin.y = 60
        }
    }
}

// 蛇的完整身體: 身體由多個BodyItem組成
class SnakeBody {
    
    // 創建陣列
    var bodys = [BodyItem]()
    
    // 創造一個bodyItem
    func constructBody(frame: CGRect) -> BodyItem {
        let body = BodyItem(frame: frame)
        body.setImage(UIImage(named: "capooBody"), for: .normal)
        return body
    }
    
    // 初始化身體時只有一段
    init() {
        bodys.append(constructBody(frame: CGRect(x: 60, y: 90, width: 30, height: 30)))
    }
    
    // 吃掉一個food就長一截身體
    func addOne(view: UIView) {
        let currentLast = bodys.last
        
        bodys.append(constructBody(frame: currentLast!.frame))
        currentLast?.nextItem = bodys.last
        
        view.addSubview(bodys.last!)
    }
}
