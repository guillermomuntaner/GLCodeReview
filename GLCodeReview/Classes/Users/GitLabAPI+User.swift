//
//  GitLabAPI+User.swift
//  GitDiff
//
//  Created by Guillermo Muntaner Perelló on 06/11/2018.
//

import Foundation

extension GitLabAPI {
    
    /// Gets currently authenticated user.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/users.html#for-normal-users-1)
    public static func getCurrentUser() -> Endpoint<User> {
        return Endpoint<User>(path: "api/v4/user")
    }
}
