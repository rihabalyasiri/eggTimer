//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    let eggTimes = ["Soft": 5 * 60, "Medium":7 * 60, "Hard": 12 * 60]
    var timer = Timer()
    var totalTime = 0
    var passedSeconds = 0
   
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        titel.text = sender.currentTitle
        self.progressBar.progress = 0.0
        passedSeconds = 0
       
        let hardness = sender.currentTitle
        let totalTime = eggTimes[hardness!]!
      
        // timer to count the time of cooking eggs
         timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.passedSeconds < totalTime {
                self.passedSeconds += 1
                let percentageProgress = Float(self.passedSeconds) / Float(totalTime)
                self.progressBar.progress = percentageProgress
               
            }else {
                self.playSound(sound: "alarm_sound")
                self.titel.text = "Done!"
                //Stops the timer from ever firing again and requests its removal from its run loop.
                timer.invalidate()
               
               
            }
            
        })
        
    }
    
    // function to let App play sound from IOS Hardware
    func playSound(sound: String?) {
           let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
           player.play()
                   
       }
  
    
}
