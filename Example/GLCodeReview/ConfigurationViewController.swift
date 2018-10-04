//
//  ConfigurationViewController.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner on 09/26/2018.
//  Copyright (c) 2018 Guillermo Muntaner. All rights reserved.
//

import UIKit
import GLCodeReview

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var baseUrlField: UITextField!
    @IBOutlet weak var personalAccessTokenField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseUrlField.text = "" // SET YOUR VALUE TO AVOID TYPING
        personalAccessTokenField.text = "" // SET YOUR VALUE TO AVOID TYPING
    }
    
    @IBAction func onStartTap(_ sender: Any) {
        validateAndPushProjectsController()
    }
    
    @IBAction func onTokenHelpTap(_ sender: Any) {
        openGitlabPersonalAccessTokenUrl()
    }
    
    func validateAndPushProjectsController() {

        guard
            let baseUrl = baseUrlField.text, !baseUrl.isEmpty,
            let personalAccessToken = personalAccessTokenField.text, !personalAccessToken.isEmpty
            else {
                let alert = UIAlertController(title: "Missing info", message: "Please fill in your gitlab repo base url and your personal access token", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "How do I get a token?", style: .default, handler: { (_) in
                    self.openGitlabPersonalAccessTokenUrl()
                }))
                present(alert, animated: true, completion: nil)
                return
        }
        
        guard let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ProjectsTableViewController")
            as? ProjectsTableViewController else { return }
        
        // Build the client
        let baseURL = URL(string: baseUrl)!
        let header = PersonalAccessToken(value: personalAccessToken)
        let client = Client(baseURL: baseURL, authenticationHttpHeader: header)
        
        // Set the client and push
        destination.client = client
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    func openGitlabPersonalAccessTokenUrl() {
        let gitlabUrl = URL(string: "https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(gitlabUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(gitlabUrl)
        }
    }
}

