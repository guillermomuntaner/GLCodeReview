//
//  MergeRequestChangesTableViewController.swift
//  GLCodeReview_Example
//
//  Created by Guillermo Muntaner Perelló on 30/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GLCodeReview

class MergeRequestChangesTableViewController: UITableViewController {

    public var projectId: Int!
    public var mergeRequestIid: Int!
    
    var mergeRequestsChanges: MergeRequestChanges? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = URL(string: "***REMOVED***")!
        let header = PersonalAccessToken(value: "***REMOVED***")
        let client = Client(baseURL: baseURL, authenticationHttpHeader: header)
        client.request(GitLabAPI.getMergeRequestChanges(inProjectWithId: projectId, mergeRequestIid: mergeRequestIid)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let mergeRequestsChanges):
                print("Received \(mergeRequestsChanges.changes.count) mergeRequests changes")
                strongSelf.mergeRequestsChanges = mergeRequestsChanges
                let insertedIndexPaths = (0..<mergeRequestsChanges.changes.count).map { IndexPath(row: $0, section: 0)}
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
        return mergeRequestsChanges?.changes.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let change = mergeRequestsChanges!.changes[indexPath.row]
        cell.textLabel?.text = change.new_path
        cell.detailTextLabel?.text = change.diff
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DiffViewController")
            as? DiffViewController else { return }
        
        let change = mergeRequestsChanges!.changes[indexPath.row]
        destination.mergeRequestChange = change
        navigationController?.pushViewController(destination, animated: true)
    }
}
