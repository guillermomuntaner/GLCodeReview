//
//  User.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

public struct User: Codable {
    public let id: Int
    public let username: String
    public let name: String
    public let email: String?
    public let avatar_url: String?
    public let web_url: String
}
