//
//  GitLabAPI+Version.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 06/11/2018.
//

import Foundation

public struct GitLabVersion: Codable {
    public let version: String // "8.13.0-pre"
    public let revision: String // "4e963fe"
}

extension GitLabAPI {
    
    /// Retrieve version information for this GitLab instance. Responds 200 OK for authenticated users.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/version.html)
    public static func getVersion() -> Endpoint<GitLabVersion> {
        return Endpoint<GitLabVersion>(path: "api/v4/version")
    }
}
