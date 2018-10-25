//
//  Commit.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 21/10/2018.
//

import Foundation

/// A git commit
public struct Commit: Codable {
    
    public let id: String // "33e2ee8579fda5bc36accc9c6fbd0b4fefda9e30",
    public let short_id: String // "33e2ee85",
    public let title: String // "Change year to 2018",
    public let author_name: String // "Administrator",
    public let author_email: String // "admin@example.com",
    public let created_at: Date // "2016-07-26T17:44:29.000+03:00",
    public let message: String // "Change year to 2018"
}
