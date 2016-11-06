//
//  UserClass.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 10/25/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import Foundation

class User {
    var name: String
    var email: String
    var image: String
    var role: String
    var adminPower: String
    
    init (name: String, email: String, image: String, role: String, adminPower: String) {
        self.name = name
        self.email = email
        self.image = image
        self.role = role
        self.adminPower = adminPower
    }
    
}
