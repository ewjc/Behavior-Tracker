//
//  BehaviorTrackingVC.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/25/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import Foundation
import UIKit

class BehaviorTrack {
    var mood: Int!
    var stress: Int!
    var activityLevel: Int!
    var selfHarm: Int!
    var location: String!
    var date: Date!
    var time: Date!
    var notes: String?
    var trigger: String?
    var resolution: String?
    
    init(mood: Int, stress: Int, activityLevel: Int, selfHarm: Int, location: String, date: Date, time: Date, notes: String, trigger: String, resolution: String) {
        self.mood = mood
        self.stress = stress
        self.activityLevel = activityLevel
        self.selfHarm = selfHarm
        self.location = location
        self.date = date
        self.time = time
        self.notes = notes
        self.trigger = trigger
        self.resolution = resolution
    }
    
//Add video recording and camera recording
    
}
