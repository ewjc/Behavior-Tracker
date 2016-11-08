//
//  RealmHelper.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 11/1/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit
import RealmSwift


class RealmHelper {
    
    static func addBehaviorTrack(behavior: BehaviorTrack)
    {
        let realm = try! Realm()
        try! realm.write(){
            realm.add(behavior)
        }
    }
    static func deleteBehavior(behavior: BehaviorTrack)
    {
        let realm = try! Realm()
        try! realm.write(){
            realm.delete(behavior)
        }
    }
    static func updateBehavior(behaviorToBeUpdated: BehaviorTrack, newBehavior: BehaviorTrack)
    {
        let realm = try! Realm()
        try! realm.write(){
            behaviorToBeUpdated.activityLevel = newBehavior.activityLevel
            behaviorToBeUpdated.date = newBehavior.date
            behaviorToBeUpdated.location = newBehavior.location
            behaviorToBeUpdated.mood = newBehavior.mood
            behaviorToBeUpdated.notes = newBehavior.notes
            behaviorToBeUpdated.resolution = newBehavior.resolution
            behaviorToBeUpdated.selfHarm = newBehavior.selfHarm
            behaviorToBeUpdated.stress = newBehavior.stress
            behaviorToBeUpdated.time = newBehavior.time
            behaviorToBeUpdated.trigger = newBehavior.trigger
        }
    }
    static func retrieveBehavior() -> Results<BehaviorTrack>
    {
        let realm = try! Realm()
        return realm.objects(BehaviorTrack.self)
    }
}


