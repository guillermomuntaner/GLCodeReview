//
//  Change.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 21/10/2018.
//

import Foundation

// The git diff of a commit, version or merge request.
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
