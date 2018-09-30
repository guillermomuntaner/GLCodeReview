//
//  Project.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

public struct Project: Codable {
    public let id: Int
    public let description: String?
    public let default_branch: String?
    public let web_url: String
    public let name: String
    public let name_with_namespace: String
    public let path: String
    public let path_with_namespace: String
    public let forks_count: Int
    public let avatar_url: String?
    public let star_count: Int
}
