//
//  BehaviorTrackingVC.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/25/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm


class BehaviorTrack: Object {
//    dynamic var owner: User? = nil
    
    dynamic var mood: Int = 0
    dynamic var stress: Int = 0
    dynamic var activityLevel: Int = 0
    dynamic var selfHarm: Int = 0
    dynamic var location: String = ""
    dynamic var date: String = ""
    dynamic var time: String = ""
    dynamic var notes: String? = nil
    dynamic var trigger: String? = nil
    dynamic var resolution: String? = nil
    
    required init(mood: Int, stress: Int, activityLevel: Int, selfHarm: Int, location: String, date: String, time: String, notes: String, trigger: String, resolution: String) {
        super.init()
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
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
//Add video recording and camera recording
    
}
