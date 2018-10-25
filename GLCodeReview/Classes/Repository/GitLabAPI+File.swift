//
//  GitLabAPI+File.swift
//  Pods
//
//  Created by Guillermo Muntaner Perelló on 20/10/2018.
//

import Foundation

/// Repository files API
///
/// CRUD for repository files. Create, read, update and delete repository files using this API
/// [GitLab Docs](https://docs.gitlab.com/ee/api/repository_files.html)
extension GitLabAPI {
    
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
