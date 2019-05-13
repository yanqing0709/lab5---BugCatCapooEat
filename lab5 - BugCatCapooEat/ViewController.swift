//
//  ViewController.swift
//  lab5 - BugCatCapooEat
//
//  Created by 陳嬿晴 on 2019/5/10.
//  Copyright © 2019 陳嬿晴. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // 增加Food属性
    var food: Food!
    // 為了讓蛇能動，增加定時器
    var timer = Timer()
    // 增加Snake屬性
    var snake: Snake!
    // 記錄分數
    var score = 0
    // 是否暫停
    var isPause = false
    
    // 定時器觸發時會執行的函數
    @objc func walk() {
        if food.frame.origin == snake.head.frame.origin {
            food.changeFood(button: food)
            snake.eat()
            score += 10
            navigationItem.title = String(score)
        }
        //print("定時器開始跑囉")
        snake.walk()
    }
    
    @IBAction func pause(_ sender: UIBarButtonItem) {
        isPause = !isPause
        
        if (isPause) {
            sender.title = "開始"
            timer.fireDate = NSDate.distantFuture
        } else {
            sender.title = "暫停"
            timer.fireDate = NSDate.distantPast
        }
    }
    
    @IBAction func changeDirection(_ sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self.view)
        
        snake.changeDirection(point: tapPoint)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let content = UNMutableNotificationContent()
        content.title = "BugCat Capoo-Eat"
        content.subtitle = "喵喵喵"
        content.body = "飯飯飯飯！咖波肚子餓了！！"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let imageURL = Bundle.main.url(forResource: "rice", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options: nil)
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        scoreView.isHidden = true
        scoreLabel.isHidden = true
        /*
        var sec = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        { (_) in
            self.timeLabel.text = String(sec)
            if sec > 0{
                sec = sec - 1
            }
            else
            {
                self.timer.invalidate()
                self.scoreView.isHidden = false
                self.scoreLabel.isHidden = false
                self.scoreLabel.text = String(self.score)
                
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3.5, delay: 0, animations: {
                    self.scoreView.center = CGPoint(x: self.scoreView.center.x, y: 500)
                })
            }
        }
         */
        
        delay(interval: 60) {
            self.timer.invalidate()
            print("時間到!")
            
            self.scoreView.isHidden = false
            self.scoreLabel.isHidden = false
            self.scoreLabel.text = String(self.score)
            
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3.5, delay: 0, animations: {
                self.scoreView.center = CGPoint(x: self.scoreView.center.x, y: 500)
            })
        }
        
        
        // 增加背景圖片
        let backgroundImage = UIImage(named: "top6")!
        view.backgroundColor = UIColor(patternImage: backgroundImage)
        
        // 初始化food
        food = Food(view: view)
        // 初始化snake
        snake = Snake(view: view)
        
        // 初始化定時器，每幾秒鐘去執行某件事情
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(walk), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            closure()
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? Score
        
        controller?.boardScore = scoreLabel
    }
     */
}

