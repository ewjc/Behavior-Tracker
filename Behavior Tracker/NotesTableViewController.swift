//
//  NotesTableViewController.swift
//  Behavior Tracker
//
//  Created by Eric Wong on 11/6/16.
//  Copyright © 2016 Eric Wong. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class NotesTableViewController: UITableViewController {
    
//    var behaviors: Results<BehaviorTrack>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) 
        

        return cell
    }



}
