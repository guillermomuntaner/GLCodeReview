//
//  Version.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 21/10/2018.
//

import Foundation

/// Merge request diff version
public struct Version: Codable {
    
    public let id: Int // 110,
    public let head_commit_sha: String // "33e2ee8579fda5bc36accc9c6fbd0b4fefda9e30",
    public let base_commit_sha: String // "eeb57dffe83deb686a60a71c16c32f71046868fd",
    public let start_commit_sha: String // "eeb57dffe83deb686a60a71c16c32f71046868fd",
    public let created_at: Date // "2016-07-26T14:44:48.926Z",
    public let merge_request_id: Int // 105,
    public let state: String // "collected",
    public let real_size: String // "1"
}

/// Merge request diff version with commits & diff.
///
/// This model is only returned when accessing a single version by id.
public struct VersionDetails: Codable {
    
    public let id: Int // 110,
    public let head_commit_sha: String // "33e2ee8579fda5bc36accc9c6fbd0b4fefda9e30",
    public let base_commit_sha: String // "eeb57dffe83deb686a60a71c16c32f71046868fd",
    public let start_commit_sha: String // "eeb57dffe83deb686a60a71c16c32f71046868fd",
    public let created_at: Date // "2016-07-26T14:44:48.926Z",
    public let merge_request_id: Int // 105,
    public let state: String // "collected",
    public let real_size: String // "1"
    public let commits: [Commit]
    public let diffs: [Change]
}
