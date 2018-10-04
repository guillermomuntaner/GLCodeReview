//
//  MergeRequestsTableViewController.swift
//  GLCodeReview_Example
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GLCodeReview

class MergeRequestsTableViewController: UITableViewController {

    public var client: Client!
    
    public var projectId: Int!
    
    var mergeRequests: [MergeRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client.request(GitLabAPI.getMergeRequests(inProjectWithId: projectId)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let mergeRequests):
                print("Received \(mergeRequests.count) mergeRequests")
                strongSelf.mergeRequests = mergeRequests
                let insertedIndexPaths = (0..<mergeRequests.count).map { IndexPath(row: $0, section: 0)}
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
        return mergeRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let mergeRequest = mergeRequests[indexPath.row]
        cell.textLabel?.text = mergeRequest.title
        cell.detailTextLabel?.text = mergeRequest.description
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "NotesTableViewController")
            as? NotesTableViewController else { return }
        
        let mergeRequest = mergeRequests[indexPath.row]
        destination.client = client
        destination.projectId = projectId
        destination.mergeRequestIid = mergeRequest.iid
        navigationController?.pushViewController(destination, animated: true)
    }
}
