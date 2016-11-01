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
    var behaviorTracks: [BehaviorTrack] = []
    var selectedMood = 0
    
    let date = Date()
    let calendar = Calendar.current

    let formatter = DateFormatter()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var physicalActivityLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var additionalNotesField: UITextField!
    @IBOutlet weak var triggerTextField: UITextField!
    @IBOutlet weak var shareWith: UILabel!
    @IBOutlet weak var behaviorTherapistImage: UIImageView!
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var caregiverImage: UIImageView!
    @IBOutlet weak var caregiverTwoImage: UIImageView!
    @IBOutlet weak var triggerLabel: UILabel!
    
    @IBOutlet weak var resolutionTextField: UITextField!
    @IBOutlet weak var resolutionLabel: UILabel!
    var indexOfHighlightedButton = -1
    
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
    var behavior = BehaviorTrack(mood: selectedMood, stress: Int(stressSlider.value), activityLevel: Int(activityLevelSlider.value), selfHarm: Int(selfHarmSlider.value), location: "1547 Mission Street", date: dateLabel.text!, time: timeLabel.text!, notes: additionalNotesField.text!, trigger: triggerTextField.text!, resolution: resolutionTextField.text!)
        
        behaviorTracks.append(behavior)
        print(behavior.time)
        print(behaviorTracks.count)
        
        var msg = "Your behavior note has been recorded successfully!"
        let alert = UIAlertController(title: "Succes", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateLabel.text = ("Date: \(result)")

        var components = calendar.dateComponents([.hour, .minute], from: date)
        if components.hour! > 12 {
            components.hour = components.hour! - 12
        }
        timeLabel.text = ("Time: \(components.hour!):\(components.minute!)")
        
        for i in 0..<moodButtons.count {
            moodButtons[i].setTitle(moodArray[i], for: .normal)
            
        }
        progressView.tintColor = UIColor(red: 1.0, green: 0.02, blue: 0.00, alpha: 1.0)
        progressView.progress = progressCounter
        
        /*** DEBUG STATEMENT ***/
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths.first!)
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL: URL = urls.first!
        fileURL = documentsDirectoryURL.appendingPathComponent(selectedAudioFileName)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL!)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            
            /*** DEBUG STATEMENT ***/
            print("The audioPlayer is initialized with this URL:\n\(fileURL)")
            
        } catch let error as NSError {
            print("AUDIO PLAYER ERROR\n\(error.localizedDescription)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if audioPlayer.isPlaying {
            audioPlayer.stop() // Stop the sound that's playing
        }
    }
    
    //MARK: RECORDING ASPECT OF APP
    
    //MARK:  Properties
    var progressCounter: Float = 0.00
    var progressViewTimer: Timer!
    var soundFileName: String!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer = AVAudioPlayer()
    var selectedAudioFileName = String()
    var fileURL : URL?
    var timer:Timer!

    //MARK: IBOutlets
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: Functions
    func updateProgressView() {
        progressCounter += 0.01
        progressView.progress = progressCounter
        
        if progressCounter > 1.0 {
            progressViewTimer.invalidate()
        }
        
        /*** DEBUG STATEMENT ***/
        print("Progress: \(progressCounter)")
    }
    
    func updatePlayedTime() {
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        _ = currentTime - minutes * 60
    }
    
    func setupAudioRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            
            let fileManager = FileManager.default
            let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectoryURL: URL = urls.first!
            soundFileName = "recording-" + randomString() + ".caf"
            let audioFileURL = documentsDirectoryURL.appendingPathComponent(self.soundFileName)
            /*** DEBUG STATEMENT ***/
            print("Audio File Url\n\(audioFileURL)")
            
            let audioSettings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                 AVSampleRateKey: 12000.0,
                                 AVNumberOfChannelsKey: 1 as NSNumber,
                                 AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String : Any]
            
            do {
                audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: audioSettings)
                audioRecorder.delegate = self
                audioRecorder.prepareToRecord()
            } catch let error as NSError {
                
                // Recorder not initialized
                /*** DEBUG STATEMENT ***/
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print("Recording session failed: \(error.localizedDescription)")
        }
    }
    
    func randomString() -> String {
        let len: Int = 3 // String length
        let needle : NSString = "0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (needle.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", needle.character(at: Int(rand)))
        }
        
        return randomString as String
    }
    
    // MARK: - AVAudioRecorder delegates
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        let msg = "Your recording was saved!"
        let alert = UIAlertController(title: "Voice Notes", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        let alert = UIAlertController(title: "Voice Notes", message: error!.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: IBActions
    @IBAction func recordTapped() {
        progressCounter = 0.0
        setupAudioRecorder()
        audioRecorder.record()
        
        if progressViewTimer != nil {
            progressViewTimer.invalidate()
        }
        
        progressViewTimer = Timer.scheduledTimer(timeInterval: 0.5, target:self, selector:#selector(BehaviorTrackingVC.updateProgressView), userInfo:nil, repeats:true)
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
//        if audioPlayer.isPlaying {
//            audioPlayer.pause()
//        } else {}
//            audioPlayer.play()
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BehaviorTrackingVC.updatePlayedTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        if audioRecorder != nil {
            audioRecorder.stop()
            progressViewTimer.invalidate()
            progressView.progress = 0.0
        }
    }
}

