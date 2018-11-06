//
//  MergeRequest.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

public struct DiffRefs: Codable {
    public let base_sha: String
    public let head_sha: String
    public let start_sha: String
}


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
    public let sha: String
}


/// Merge request model when retrieving an individual merge request (by id). Contains extra fields.
public struct MergeRequestDetails: Codable {
    
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
    public let sha: String
    
    // Extra fields
    
    public let diff_refs: DiffRefs
}


/// Merge request model when retrieving an individual merge request changes (by id). Contains extra fields.
public struct MergeRequestChanges: Codable {
    
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
    public let sha: String
    
    // Extra fields
    
    public let diff_refs: DiffRefs
    public let changes: [Change]
}



