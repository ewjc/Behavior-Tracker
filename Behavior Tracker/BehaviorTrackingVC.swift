//
//  ViewController.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/24/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit
import AVFoundation

class BehaviorTrackingVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

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

    @IBAction func addVideoRecording(_ sender: UIButton) {
    }
    @IBAction func trackButtonPressed(_ sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<moodButtons.count {
            moodButtons[i].setTitle(moodArray[i], for: .normal)
            
        }
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("allowed!")
                    } else {
                    let alertMessage = UIAlertController(title: "Error", message: "Failed to record. Please try again later.", preferredStyle: .alert);
                        alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                        self.present(alertMessage, animated: true, completion: nil)
                    return
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    //MARK: RECORDING ASPECT OF APP

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func recordTapped() {
        if audioRecorder == nil {
            recordAudio()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func playTapped(_ sender: UIButton) {

    }
    
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            let alertMessage = UIAlertController(title: "Success", message: "Your audio recording has been successfully added!", preferredStyle: .alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alertMessage, animated: true, completion: nil)
            return
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func recordAudio() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}

