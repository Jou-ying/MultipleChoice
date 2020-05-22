//
//  ViewController.swift
//  MultipleChoice
//
//  Created by zoeli on 2020/5/21.
//  Copyright © 2020 zoeli. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var startView: UIView!

    @IBOutlet weak var startButton: UIButton!
    

    @IBOutlet var optionButtonList: [UIButton]!
       
    @IBOutlet var statusImageViewList: [UIImageView]!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var questions = [Questions]()
    
    var nowQuestions = [Questions]()
    
    // 目前的題目
    var currentIndex = 0
    
    //
    var questionQuantity = 10
    // 分數
    var score = 0
    
    // 是否完成答題
    var isFinished = false
    
    
    let descriptionList = ["請問下圖代表什麼星座？", "請問下列哪個不屬於水象星座？", "月球上的一天，是地球的幾天呢？", "在希臘神話中，愛神維納斯是下列哪個星座的守護神？" , "請問獅子座的守護神是誰？" , "請問在5月28日出生的人代表什麼星座？" , "北斗七星位於哪個星座上？" , "請問何者為下圖的星系？" , "請問在幾月份會有雙子座流星雨？" , "下列哪一個不是行星？" , "以下符號代表什麼星座？" , "請問摩羯座的英文為何？" , "請問最顧家的星座為何？" , "請問英文單字中Aquarius代表什麼星座？" , "太陽系中密度最大的行星是什麼？" , "地球上第一個登陸月球的太空人是誰？" , "請問射手座還可以稱作為什麼？" , "請問古希臘神話中的眾神之王是誰？" , "請問天秤座的守護星為下列何者？", "希臘神話中的蛇髮魔女為下列何人？"]

    let answerList = ["雙子座", "水瓶座", "約一個月", "金牛座", "太陽神阿波羅" , "雙子座" , "大熊座" , "仙女座星系" , "12" , "太陽" , "處女座" , "Capricorn" , "巨蟹座" , "水瓶座" , "地球" , "阿姆斯壯" , "人馬座" , "宙斯" , "金星" , "梅杜莎"]
    
    let imageNameList = ["雙子座", "", "", "" , "" , "" , "" , "仙女座星系" , "" , "" , "處女座" , "" , "" , "" , "" , "" , "" , "" , "" , ""]
    
    var optionList = [["雙子座","天秤座", "水瓶座", "摩羯座"],["巨蟹座","雙魚座", "水瓶座", "天蠍座"] ,["約一天","約一週", "約一個月", "約一年"] ,["摩羯座","牡羊座", "獅子座", "金牛座"] ,["太陽神阿波羅","海神涅普頓", "愛神丘比特", "地獄之神普爾德"] ,["巨蟹座","金牛座", "雙子座", "牡羊座"] ,["仙王座","天鵝座", "大熊座", "天龍座"] ,["仙女座星系","波德星系", "風車星系", "向日葵星系"] ,["11","5", "7", "12"] ,["太陽","火星", "地球", "木星"] ,["金牛座","處女座", "射手座", "水瓶座"],["Capricorn","Gemini", "Aries", "Scorpio"] ,["巨蟹座","牡羊座", "獅子座", "水瓶座"] ,["水瓶座","天蠍座", "射手座", "雙魚座"]  ,["天王星","木星", "地球", "火星"] ,["艾德林","阿姆斯壯", "柯林斯", "川普"] ,["劍魚座","人馬座", "小熊座", "鹿豹座"] ,["宙斯","阿波羅", "海克力斯", "塞勒涅"] ,["水星","金星", "太陽", "天王星"] ,["梅杜莎","維納斯", "忒彌絲", "狄俄涅"]]
           

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.startButton.layer.cornerRadius = self.startButton.frame.width / 2
        
        for button in self.optionButtonList {
                   
            button.layer.borderColor = UIColor(red: 68/255.0, green: 104/255.0, blue: 156/255.0, alpha: 1).cgColor
            
            button.layer.borderWidth = 3
        }
            
    }
    
    
    // MARK: - func
    func showQuestion() {
        
        self.descriptionLabel.text = self.nowQuestions[self.currentIndex].description
        
        // 判斷題目裡是否有圖片
        if self.nowQuestions[self.currentIndex].imageName != "" {
            
            self.imageView.image = UIImage(named: "\(self.nowQuestions[self.currentIndex].imageName)")
            
        }else {
            self.imageView.image = UIImage(named: "")
        }
        
        
        // 預設各選項的狀態照片為無
        for statusImageView in self.statusImageViewList {
            
            statusImageView.image = UIImage(named: "")
        }
        
        
        // 預設各選項button的狀態及顯示各選項文字
        for optionButton in self.optionButtonList {
                    
            optionButton.isEnabled = true
        optionButton.setTitle("\(self.nowQuestions[self.currentIndex].allOption[optionButton.tag])", for: .normal)
        
        }
        
        // 如果沒有下一題隱藏next按鈕
        if self.currentIndex == self.questionQuantity - 1 {
                
            self.nextButton.isHidden = true
        
        }
        
        self.questionNumberLabel.text = "題目\(currentIndex+1)"
        
    }
    
    
    
    
    // MARK: - IBAction
    @IBAction func didTapStartButton(_ sender: UIButton) {
        
        // 把題目陣列預設為空，重新塞題目進去
        self.questions = []
        self.nowQuestions = []
        
        // 每一次開始都重新寫入題目
        for i in 0..<descriptionList.count {
            
            let question = Questions()
            
            question.description = self.descriptionList[i]
            
            question.imageName = self.imageNameList[i]
            
            question.answer = self.answerList[i]
            
            // 調整四個選項的順序
            self.optionList[i].shuffle()
            
            question.allOption = self.optionList[i]
            
            questions.append(question)
        }
        
        // 調整題目的順序
        self.questions.shuffle()
        
        // 選擇此次題目
        for i in 0..<questionQuantity {
                   
            self.nowQuestions.append(self.questions[i])
                
        }
    
        
        self.score = 0
        self.scoreLabel.text = "\(self.score)"
        self.currentIndex = 0
        self.startView.isHidden = true
        self.nextButton.isHidden = false

    
        self.showQuestion()
        
    }
    

    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        // 確認完成此題
        if self.isFinished {
            
            if self.currentIndex == self.questionQuantity - 1 {
                    
                    self.nextButton.isHidden = true
            
                }else {
                    
                    self.currentIndex += 1
                    print(self.currentIndex)
                    
                }
                self.showQuestion()
            
        }else {
            
            let alert = UIAlertController(title: "", message: "請選擇任一答案，再前往下一題", preferredStyle: .alert)
                   
            let action = UIAlertAction(title: "確定", style: .default)
                  
            alert.addAction(action)
                   
            self.show(alert, sender: nil)
        }
    }
    
    
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        // 選擇的答案
        let selectAnswer = sender.titleLabel?.text
        
        // 正確答案
        let correctAnswer = self.nowQuestions[self.currentIndex].answer
        
        // 正確答案的Index
        var correctNumber = -1
        
        // 完成作答
        self.isFinished = true
        
        // 判斷對還是錯
        var isCorrect = false
        
       
        
        
        for button in self.optionButtonList {
                   
            // 把button狀態改為不能點選
            button.isEnabled = false

            //判斷哪個選項是正確答案
            if button.titleLabel!.text ==  correctAnswer {
                
                correctNumber = button.tag
            }
            
        }

        
        // 判斷所選擇項目是否為正確答案
        if selectAnswer == correctAnswer {
                   
            isCorrect = true
        
            self.score += 10
            
            self.scoreLabel.text = "\(self.score)"
        }
    
        
        
        // 在自己選擇的項目 & 正確答案 中添加是否正確的圖片
        for statusImageView in self.statusImageViewList {
        
            if statusImageView.tag == correctNumber {
                
                statusImageView.image = UIImage(named: "icon_v")

            }
            
            if statusImageView.tag == sender.tag {
                
                if !isCorrect {
                    
                    statusImageView.image = UIImage(named: "icon_x")
                }
            }
        }
    
    
        // 判斷是否為最後一題
        if self.currentIndex == self.questionQuantity - 1  {
            
            var best = 0
            
            if UserDefaults.standard.object(forKey: "BEST") != nil {
                
                best = UserDefaults.standard.object(forKey: "BEST") as! Int
                
            }
            
            var alert = UIAlertController()
            
            if best > 0 {
                
                // 判斷此次得分有沒有比最高紀錄多，並儲存最高的分數在手機
                if best > self.score {

                     alert = UIAlertController(title: "上次最高紀錄： \(best) \n 這回合總分：\(score) ", message: "", preferredStyle: .alert)
                    
                    UserDefaults.standard.set(best, forKey: "BEST")
                    UserDefaults.standard.synchronize()
                    
                }else {

                     alert = UIAlertController(title: "上次最高紀錄： \(best) \n 這回合總分：\(score) \n 恭喜你！成為最高紀錄者！ ", message: "", preferredStyle: .alert)
                    
                    UserDefaults.standard.set(self.score, forKey: "BEST")
                    UserDefaults.standard.synchronize()
                }
           
            }else {
                
                alert = UIAlertController(title: "這回合總分：\(score)", message: "", preferredStyle: .alert)

                // 儲存最高的分數在手機
                UserDefaults.standard.set(self.score, forKey: "BEST")
                UserDefaults.standard.synchronize()
            }
            
    
            let action = UIAlertAction(title: "再試一次", style: .default) { (_) in
            
            // 顯示開始的頁面
            self.startView.isHidden = false
            }
        
            alert.addAction(action)
        
            self.show(alert, sender: nil)
            
            
            
        }
    }
    
    
}



