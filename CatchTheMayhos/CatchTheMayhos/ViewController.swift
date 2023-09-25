//
//  ViewController.swift
//  CatchTheMayhos
//
//  Created by Samet Baltacıoğlu on 6.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var mayhosArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var mayhos1: UIImageView!
    @IBOutlet weak var mayhos2: UIImageView!
    @IBOutlet weak var mayhos3: UIImageView!
    @IBOutlet weak var mayhos4: UIImageView!
    @IBOutlet weak var mayhos5: UIImageView!
    @IBOutlet weak var mayhos6: UIImageView!
    @IBOutlet weak var mayhos7: UIImageView!
    @IBOutlet weak var mayhos8: UIImageView!
    @IBOutlet weak var mayhos9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Skor: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Yüksek skor: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Yüksek skor: \(highScore)"
        }
        
        
        //Images
        
        mayhos1.isUserInteractionEnabled = true
        mayhos2.isUserInteractionEnabled = true
        mayhos3.isUserInteractionEnabled = true
        mayhos4.isUserInteractionEnabled = true
        mayhos5.isUserInteractionEnabled = true
        mayhos6.isUserInteractionEnabled = true
        mayhos7.isUserInteractionEnabled = true
        mayhos8.isUserInteractionEnabled = true
        mayhos9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore2))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore2))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore2))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore2))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        mayhos1.addGestureRecognizer(recognizer1)
        mayhos2.addGestureRecognizer(recognizer2)
        mayhos3.addGestureRecognizer(recognizer3)
        mayhos4.addGestureRecognizer(recognizer4)
        mayhos5.addGestureRecognizer(recognizer5)
        mayhos6.addGestureRecognizer(recognizer6)
        mayhos7.addGestureRecognizer(recognizer7)
        mayhos8.addGestureRecognizer(recognizer8)
        mayhos9.addGestureRecognizer(recognizer9)
        
        mayhosArray = [mayhos1, mayhos2, mayhos3, mayhos4, mayhos5, mayhos6, mayhos7, mayhos8, mayhos9]
        
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMayhos), userInfo: nil, repeats: true)
        
        hideMayhos()
        
        
    }
    
    
    @objc func hideMayhos(){
        
        for maya in mayhosArray {
            maya.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(mayhosArray.count - 1)))
        let random2 = Int(arc4random_uniform(UInt32(mayhosArray.count - 1)))
        if random == random2 && random == 0 {
            mayhosArray[random].isHidden = false
            mayhosArray[random + 3].isHidden = false
        } else if random == random2 && random == mayhosArray.count - 1 {
            mayhosArray[random].isHidden = false
            mayhosArray[random - 3].isHidden = false
        } else {
            mayhosArray[random].isHidden = false
            mayhosArray[random2].isHidden = false
        }
    
        
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Skor: \(score)"
    }
    
    @objc func increaseScore2(){
        score -= 1
        scoreLabel.text = "Skor: \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for maya in mayhosArray {
                maya.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Yüksek skor: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Süre Doldu", message: "Bir daha oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Tekrarla", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Skor: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMayhos), userInfo: nil, repeats: true)
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
        }
        
    }
    
    
    
}

