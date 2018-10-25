//
//  FileMetadata.swift
//  GitDiff
//
//  Created by Guillermo Muntaner Perelló on 20/10/2018.
//

import Foundation

/// Repository file metadata
public struct FileMetadata: Codable {
    
    public let file_name: String // "key.rb",
    public let file_path: String // "app/models/key.rb",
    public let size: Int // 1476,
    public let encoding: String // "base64",
    public let content: String // "IyA9PSBTY2hlbWEgSW5mb3...",
    public let content_sha256: String // "4c294617b60715c1d218e61164a3abd4808a4284cbc30e6728a01ad9aada4481",
    public let ref: String // "master",
    public let blob_id: String // "79f7bbd25901e8334750839545a9bd021f0e4c83",
    public let commit_id: String // "d5a3ff139356ce33e37e73add446f16869741b50",
    public let last_commit_id: String // "570e7b2abdd848b95f2f578043fc23bd6f6fd24d"
}
