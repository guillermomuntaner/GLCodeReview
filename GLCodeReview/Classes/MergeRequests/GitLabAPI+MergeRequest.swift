//
//  GitLabAPI+MergeRequest.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

extension GitLabAPI {
    
    // MARK: - Merge requests
    
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
    
    
    // MARK: - Changes
    
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
    
    
    // MARK: - Versions
    
    /// Get a list of merge request diff versions.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/merge_requests.html#get-mr-diff-versions)
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project owned by the authenticated user.
    ///   - mergeRequestIid: The internal ID of the merge request.
    /// - Returns: The configured endpoint instance.
    public static func getMergeRequestVersions(
        inProjectWithId projectId: Int,
        mergeRequestIid: Int) -> Endpoint<[Version]> {
        return Endpoint<[Version]>(
            path: "api/v4//projects/\(projectId)/merge_requests/\(mergeRequestIid)/versions")
    }
    
    /// Get a single MR diff version.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/merge_requests.html#get-a-single-mr-diff-version)
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project owned by the authenticated user.
    ///   - mergeRequestIid: The internal ID of the merge request.
    ///   - versionId: The ID of the merge request diff version.
    /// - Returns: The configured endpoint instance.
    public static func getMergeRequestVersion(
        inProjectWithId projectId: Int,
        mergeRequestIid: Int,
        versionId: Int) -> Endpoint<VersionDetails> {
        return Endpoint<VersionDetails>(
            path: "api/v4//projects/\(projectId)/merge_requests/\(mergeRequestIid)/versions/\(versionId)")
    }
    
    
    // MARK: - Commits
    
    /// Get a list of merge request commits.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/merge_requests.html#get-single-mr-commits)
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project owned by the authenticated user.
    ///   - mergeRequestIid: The internal ID of the merge request.
    /// - Returns: The configured endpoint instance.
    public static func getMergeRequestCommits(
        inProjectWithId projectId: Int,
        mergeRequestIid: Int) -> Endpoint<[Commit]> {
        return Endpoint<[Commit]>(
            path: "api/v4//projects/\(projectId)/merge_requests/\(mergeRequestIid)/commits")
    }
}
