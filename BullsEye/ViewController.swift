//
//  ViewController.swift
//  BullsEye
//
//  Created by Fuzari on 11/03/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference: Int = abs(targetValue - currentValue)
        var points: Int = 100 - difference
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost did it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not even close..."
        }
        
        score += points
        let message = "You scored \(points) points!"
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound() })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}

