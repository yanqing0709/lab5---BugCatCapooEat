//
//  Snake.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/11.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

// import Foundation

import UIKit

// 完整的定義蛇
class Snake {
    let head = SnakeHead()
    let body = SnakeBody()
    
    //保存弱引用，避免互相引用引起的内存泄露
    weak var mainView: UIView!
    
    // 增加Direction屬性
    var direction = Direction.RIGHT
    
    
    init(view: UIView) {
        mainView = view
        head.nextItem = body.bodys[0]
        
        view.addSubview(head)
        view.addSubview(body.bodys[0])
    }
    
    func walk() {
        // 臨時用，後續更改
        //head.frame.origin.x += 30.0
        
        direction.walk(point: &head.frame.origin)
        head.touchEdge()
    }
    
    func changeDirection(point: CGPoint) {
        direction.changeDirection(current: head.frame.origin, target: point)
    }
    
    func eat() {
        body.addOne(view: mainView)
    }
}

extension Direction {
    // 传入的参数为当前蛇头的坐标，我们根据当前的方向，修改坐标
    func walk(point: inout CGPoint) {
        switch self {
        case .UP:
            point.y -= CGFloat(30)
        case .DOWN:
            point.y += CGFloat(30)
        case .LEFT:
            point.x -= CGFloat(30)
        case .RIGHT:
            point.x += CGFloat(30)
        }
    }
    // 传入参数有两个，分别为蛇头的当前坐标和用户的点击坐标(根据点击坐标决定蛇的新方向)
    mutating func changeDirection(current: CGPoint, target: CGPoint){
        switch self {
        case .UP: self = current.x > target.x ? .LEFT : .RIGHT
        case .DOWN: self = current.x > target.x ? .LEFT : .RIGHT
        case .LEFT: self = current.y > target.y ? .UP : .DOWN
        case .RIGHT: self = current.y > target.y ? .UP : .DOWN
        }
    }
}
