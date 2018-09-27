//
//  PersonalAccessToken.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 26/09/2018.
//

import Foundation

/// A Gitlab personal access token.
///
/// See [Gitlab tutorial to create a token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html).
public struct PersonalAccessToken {
    public let value: String
    
    public init(value: String) {
        self.value = value
    }
}

/// Conformance to HTTPHeader
extension PersonalAccessToken: HTTPHeader {
    public var field: String { return "PRIVATE-TOKEN" }
}
