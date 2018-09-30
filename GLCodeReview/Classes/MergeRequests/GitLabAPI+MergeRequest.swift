//
//  GitLabAPI+MergeRequest.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

extension GitLabAPI {
    
    public static func getMergeRequests(
        state: MergeRequest.State? = nil,
        sort: Sort = .descending,
        orderBy: OrderBy = .updatedAt) -> Endpoint<[MergeRequest]> {
        return Endpoint<[MergeRequest]>(
            path: "api/v4/merge_requests?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)")
    }
    
    public static func getMergeRequests(
        inProjectWithId projectId: Int,
        state: MergeRequest.State? = nil,
        sort: Sort = .descending,
        orderBy: OrderBy = .updatedAt) -> Endpoint<[MergeRequest]> {
        return Endpoint<[MergeRequest]>(
            path: "api/v4/projects/\(projectId)/merge_requests?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)")
    }
    
    
    /// Shows information about the merge request including its files and changes.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/merge_requests.html#get-single-mr-changes)
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project owned by the authenticated user.
    ///   - mergeRequestIid: The internal ID of the merge request
    /// - Returns: The merge request information with a list of changes.
    public static func getMergeRequestChanges(
        inProjectWithId projectId: Int,
        mergeRequestIid: Int) -> Endpoint<MergeRequestChanges> {
        return Endpoint<MergeRequestChanges>(
            path: "api/v4//projects/\(projectId)/merge_requests/\(mergeRequestIid)/changes")
    }
}
