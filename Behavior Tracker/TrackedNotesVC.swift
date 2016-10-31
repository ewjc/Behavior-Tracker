//
//  TrackedVC.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/31/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit
import AVFoundation


class TrackedNotesVC: UIViewController, AVAudioPlayerDelegate {
    
    //MARK:  Properties
    var selectedAudioFileName = String()
    var fileURL : URL?
    var timer:Timer!
    var audioPlayer = AVAudioPlayer()
    
    
    //MARK:  IBOutlet Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    
    
    //MARK: Functions
    func updatePlayedTime() {
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        playedTime.text = NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let msg = "The voice note has finished playing."
        let alert = UIAlertController(title: "Voice Note", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        let alert = UIAlertController(title: "Voice Note", message: "Decoding Error: \(error?.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: IBActions
    @IBAction func playButtonTapped(_ sender: AnyObject) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TrackedNotesVC.updatePlayedTime), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
    }
    

    //MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if audioPlayer.isPlaying {
                audioPlayer.stop() // Stop the sound that's playing
            }
    }

}
