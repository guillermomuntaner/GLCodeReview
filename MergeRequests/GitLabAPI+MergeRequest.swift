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
            path: "api/v4/merge_requests?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)",
            decode: { (data) -> [MergeRequest] in try decoder.decode([MergeRequest].self, from: data) })
    }
    
    public static func getMergeRequests(
        inProjectWithId projectId: Int,
        state: MergeRequest.State? = nil,
        sort: Sort = .descending,
        orderBy: OrderBy = .updatedAt) -> Endpoint<[MergeRequest]> {
        return Endpoint<[MergeRequest]>(
            path: "api/v4/projects/\(projectId)/merge_requests?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)",
            decode: { (data) -> [MergeRequest] in try decoder.decode([MergeRequest].self, from: data) })
    }
}
