//
//  ViewController.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/24/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit

class BehaviorTrackingVC: UIViewController {
    
    @IBOutlet var moodButtons: [UIButton]!
    
    var moodArray = ["😀", "😘", "😞", "😔", "😨", "😭", "😖", "😡"]
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var StressLabel: UILabel!
    @IBOutlet weak var physicalActivityLabel: UILabel!
    @IBOutlet weak var dangerLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var additionalNotesField: UITextField!
    @IBOutlet weak var shareWith: UILabel!
    @IBOutlet weak var behaviorTherapistImage: UIImageView!
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var caregiverImage: UIImageView!
    @IBOutlet weak var caregiverTwoImage: UIImageView!
    
    var indexOfHighlightedButton = -1
    
    @IBAction func moodButtonPressed(_ sender: UIButton) {
        
        if indexOfHighlightedButton >= 0 {
            moodButtons[indexOfHighlightedButton].backgroundColor = .clear
        }
        
        for (i, button) in moodButtons.enumerated() {
            if button === sender {
                indexOfHighlightedButton = i
            }
        }
        sender.backgroundColor = .blue
    }
    
    @IBAction func addAudioRecording(_ sender: UIButton) {
    }
    @IBAction func addVideoRecording(_ sender: UIButton) {
    }
    @IBAction func trackButtonPressed(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<moodButtons.count {
            moodButtons[i].setTitle(moodArray[i], for: .normal)
            
        }
        
    }
    
    
    
}

