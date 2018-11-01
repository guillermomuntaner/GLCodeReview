//
//  GitLabAPI+Change.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 31/10/2018.
//

import Foundation

/// Repository files API
///
/// CRUD for repository files. Create, read, update and delete repository files using this API
/// [GitLab Docs](https://docs.gitlab.com/ee/api/repository_files.html)
extension GitLabAPI {
    
    // MARK: - Commits
    
    /// Get the diff of a commit in a project.
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/commits.html#get-the-diff-of-a-commit)
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project owned by the authenticated user.
    ///   - commitSHA: The commit hash or name of a repository branch or tag.
    /// - Returns: The configured endpoint instance.
    public static func getCommitDiff(
        inProjectWithId projectId: Int,
        commitSHA: String) -> Endpoint<[Change]> {
        return Endpoint<[Change]>(
            path: "api/v4/projects/\(projectId)/repository/commits/\(commitSHA)/diff")
    }
    
    
    // MARK: - Compare
    
    /// Compare branches, tags or commits.
    ///
    /// This endpoint can be accessed without authentication if the repository is publicly accessible.
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - from: the commit SHA or branch name
    ///   - to: the commit SHA or branch name
    ///   - straight: comparison method, true for direct comparison between from and to (from..to), false to compare
    ///         using merge base (from...to)'. Default is false.
    ///
    /// [GitLab Docs](https://docs.gitlab.com/ee/api/repositories.html#compare-branches-tags-or-commits)
    public static func compare(
        projectId: Int,
        from: String,
        to: String,
        straight: Bool = false) -> Endpoint<Comparission> {
        // URL encode - Url encoded full path to new file. Ex. lib%2Fclass%2Erb
        let encodedFrom: String = from.urlQueryParamEncoded ?? from
        let encodedTo: String = to.urlQueryParamEncoded ?? to
        // Instantiate and return the endpoint
        return Endpoint<Comparission>(
            method: .get,
            path: "api/v4/projects/\(projectId)/repository/compare?from=\(encodedFrom)&to=\(encodedTo)&straight=\(straight)")
    }
    
    
    // MARK: - Files
    
    /// Get raw file from repository.
    ///
    /// Allows you to receive information about file in repository like name, size, content. Note that file content is
    /// Base64 encoded. This endpoint can be accessed without authentication if the repository is publicly accessible.
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - file_path: Path to the file. E.g. lib/core/Model.swift (will be url encoded internally)
    ///   - ref: The name of branch, tag or commit
    ///
    /// [GitLab Docs](https://docs.gitlab.com/ee/api/repository_files.html#get-file-from-repository)
    public static func getFile(
        projectId: Int,
        file_path: String,
        ref: String) -> Endpoint<FileMetadata> {
        // URL encode - Url encoded full path to new file. Ex. lib%2Fclass%2Erb
        let urlEncodedPath: String = file_path.urlHostEncoded ?? file_path
        let urlEncodedRef: String = ref.urlQueryParamEncoded ?? ref
        // Instantiate and return the endpoint
        return Endpoint<FileMetadata>(
            method: .get,
            path: "api/v4/projects/\(projectId)/repository/files/\(urlEncodedPath)?ref=\(urlEncodedRef)")
    }
    
    /// Get raw file from repository.
    ///
    /// - Parameters:
    ///   - projectId: The ID of the project
    ///   - file_path: Path to the file. E.g. lib/core/Model.swift (will be url encoded internally)
    ///   - ref: The name of branch, tag or commit
    ///
    /// [GitLab Docs](https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository)
    public static func getRawFile(
        projectId: Int,
        file_path: String,
        ref: String) -> Endpoint<String> {
        // URL encode - Url encoded full path to new file. Ex. lib%2Fclass%2Erb
        let urlEncodedPath: String = file_path.urlHostEncoded ?? file_path
        let urlEncodedRef: String = ref.urlQueryParamEncoded ?? ref
        // Instantiate and return the endpoint
        return Endpoint<String>(
            method: .get,
            path: "api/v4/projects/\(projectId)/repository/files/\(urlEncodedPath)/raw?ref=\(urlEncodedRef)") {
                return String(data: $0, encoding: String.Encoding.utf8)!
        }
    }
}
