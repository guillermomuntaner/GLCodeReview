//
//  GitLabAPI+Note.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

public enum Sort: String {
    case ascending = "asc"
    case descending = "desc" // Default
}

public enum OrderBy: String {
    case createdAt = "created_at"
    case updatedAt = "updated_at" // Default
}

extension GitLabAPI {
    
    /// Gets a list of all notes for a single merge request.
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - mergeRequestId: The IID of a project merge request
    ///   - sort: Return merge request notes sorted in asc or desc order. Default is desc
    ///   - orderBy: Return merge request notes ordered by created_at or updated_at fields. Default is created_at
    ///
    /// [GitLab Docs](https://docs.gitlab.com/ee/api/notes.html#list-all-merge-request-notes)
    public static func getMergeRequestNotes(
        projectId: Int,
        mergeRequestIid: Int,
        sort: Sort = .descending,
        orderBy: OrderBy = .updatedAt) -> Endpoint<[Note]> {
        return Endpoint<[Note]>(
            method: .get,
            path: "api/v4/projects/\(projectId)/merge_requests/\(mergeRequestIid)/notes?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)")
    }
}
