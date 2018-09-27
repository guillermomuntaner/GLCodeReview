//
//  ProjectsTableViewController.swift
//  GLCodeReview_Example
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GLCodeReview

class ProjectsTableViewController: UITableViewController {

    var projects: [Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL = URL(string: "***REMOVED***")!
        let header = PersonalAccessToken(value: "***REMOVED***")
        let client = Client(baseURL: baseURL, authenticationHttpHeader: header)
        client.request(GitLabAPI.getProjects()) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let projects):
                print("Received \(projects.count) projects")
                strongSelf.projects = projects
                let insertedIndexPaths = (0..<projects.count).map { IndexPath(row: $0, section: 0)}
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
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.name
        cell.detailTextLabel?.text = project.description
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MergeRequestsTableViewController")
            as? MergeRequestsTableViewController else { return }
        
        let project = projects[indexPath.row]
        destination.projectId = project.id
        navigationController?.pushViewController(destination, animated: true)
    }
}
