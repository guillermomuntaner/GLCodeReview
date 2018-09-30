//
//  MergeRequest.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

public struct MergeRequest: Codable {
    
    /// Not required parameter to filter merge request lists.
    public enum State: String, Codable {
        case opened, closed, locked, merged
    }
    
    public enum MergeStatus: String, Codable {
        case canBeMerged = "can_be_merged"
    }
    
    public let id: Int
    public let iid: Int
    public let target_branch: String
    public let source_branch: String
    public let project_id: Int
    public let title: String
    public let state: State
    public let created_at: Date?
    public let updated_at: Date?
    public let upvotes: Int
    public let downvotes: Int
    public let author: User
    public let assignee: User?
    public let source_project_id: Int
    public let target_project_id: Int
    public let work_in_progress: Bool
    public let description: String
    public let squash: Bool
    public let web_url: String
    
}

public struct Change: Codable {
    public let old_path: String
    public let new_path: String
    public let a_mode: String
    public let b_mode: String
    public let diff: String // "--- a/VERSION\ +++ b/VERSION\ @@ -1 +1 @@\ -1.9.7\ +1.9.8",
    public let new_file: Bool
    public let renamed_file: Bool
    public let deleted_file: Bool
}

public struct MergeRequestChanges: Codable {
    // TODO: The MergeRequestChanges includes the whole merge request. We could decode this data here too.
    public let changes: [Change]
}



