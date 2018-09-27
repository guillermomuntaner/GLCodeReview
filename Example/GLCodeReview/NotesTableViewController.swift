//
//  NotesTableViewController.swift
//  GLCodeReview_Example
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GLCodeReview

class NotesTableViewController: UITableViewController {

    public var projectId: Int!
    public var mergeRequestIid: Int!
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = URL(string: "***REMOVED***")!
        let header = PersonalAccessToken(value: "***REMOVED***")
        let client = Client(baseURL: baseURL, authenticationHttpHeader: header)
        client.request(GitLabAPI.getMergeRequestNotes(projectId: projectId, mergeRequestIid: mergeRequestIid)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let notes):
                print("Received \(notes.count) notes")
                strongSelf.notes = notes
                let insertedIndexPaths = (0..<notes.count).map { IndexPath(row: $0, section: 0)}
                strongSelf.tableView.insertRows(at: insertedIndexPaths, with: .automatic)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.author.username
        cell.detailTextLabel?.text = note.body
    }
}
