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

    

    //MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
