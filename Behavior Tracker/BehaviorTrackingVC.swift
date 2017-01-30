//
//  ViewController.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/24/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift


class BehaviorTrackingVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    // MARK: Properties
    var moodArray = ["😀", "😘", "😞", "😔", "😨", "😭", "😖", "😡"]
    var behaviorTracks = List<BehaviorTrack>()
    var selectedMood = 0
    var indexOfHighlightedButton = -1
    let date = Date()
    let calendar = Calendar.current
    let formatter = DateFormatter()

    @IBOutlet var moodButtons: [UIButton]!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var physicalActivityLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var additionalNotesField: UITextField?
    @IBOutlet weak var triggerTextField: UITextField?
    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var resolutionTextField: UITextField?
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var activityLevelSlider: UISlider!
    @IBOutlet weak var selfHarmSlider: UISlider!
    @IBOutlet weak var stressSlider: UISlider!
    
    
    @IBAction func moodButtonPressed(_ sender: UIButton) {
        
        if indexOfHighlightedButton >= 0 {
            moodButtons[indexOfHighlightedButton].backgroundColor = .clear
        }
        
        for (i, button) in moodButtons.enumerated() {
            if button === sender {
                indexOfHighlightedButton = i
                
            }
        }
        print(sender)
        selectedMood = indexOfHighlightedButton
        sender.backgroundColor = .blue
    }
    
    @IBAction func addVideoRecording(_ sender: UIButton) {
    }
    @IBAction func trackButtonPressed(_ sender: AnyObject) {
    let behavior = BehaviorTrack(mood: selectedMood, stress: Int(stressSlider.value), activityLevel: Int(activityLevelSlider.value), selfHarm: Int(selfHarmSlider.value), location: locationTextField.text!, date: dateLabel.text!, time: timeLabel.text!, notes: (additionalNotesField?.text!)!, trigger: (triggerTextField?.text!)!, resolution: (resolutionTextField?.text!)!)
        
        RealmHelper.addBehaviorTrack(behavior: behavior)
        behaviorTracks.append(behavior)
        
        
        let msg = "Your behavior note has been recorded successfully!"
        let alert = UIAlertController(title: "Succes", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieve from database
        let realmBehaviors = RealmHelper.retrieveBehavior()
        

        
        //MARK: DATE
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateLabel.text = ("Date: \(result)")

        var components = calendar.dateComponents([.hour, .minute], from: date)
        if components.hour! > 12 {
            components.hour = components.hour! - 12
        }
        timeLabel.text = ("Time: \(components.hour!):\(components.minute!)")
        
        //MARK: MOODS
        for i in 0..<moodButtons.count {
            moodButtons[i].setTitle(moodArray[i], for: .normal)
            
        }
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let realmBehaviors = RealmHelper.retrieveBehavior()
        print(realmBehaviors)
//        if audioPlayer.isPlaying {
//            audioPlayer.stop() // Stop the sound that's playing
//        }
    }

}



