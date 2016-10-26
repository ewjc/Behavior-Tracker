//
//  GoalClass.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/25/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import Foundation

struct Goal {
    var user: String
    var important: Bool
    var title: String
    var actionSteps: String
    var timeDue: Timer
    var notes: String
    
}
