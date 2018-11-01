//
//  Comparission.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 01/11/2018.
//

import Foundation

public struct Comparission: Codable {
    public let commit: Commit
    public let commits: [Commit]
    public let diffs: [Change]
    public let compare_timeout: Bool
    public let compare_same_ref: Bool
}
