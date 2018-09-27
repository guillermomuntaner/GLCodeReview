//
//  ViewController.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner on 09/26/2018.
//  Copyright (c) 2018 Guillermo Muntaner. All rights reserved.
//

import UIKit
import GLCodeReview

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let baseURL = URL(string: "***REMOVED***")!
        let header = PersonalAccessToken(value: "***REMOVED***")
        let client = Client(baseURL: baseURL, authenticationHttpHeader: header)
        client.request(GitLabAPI.getProjects()) { (result) in
            switch result {
            case .success(let notes):
                print("Received \(notes.count) notes")
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

