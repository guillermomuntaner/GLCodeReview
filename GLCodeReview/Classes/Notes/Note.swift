//
//  Note.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 26/09/2018.
//

import Foundation

public struct NotePosition: Codable {
    public let base_sha: String // e.g. "190f6867fc1a29227be25df79f49383b5a894755",
    public let start_sha: String // e.g. "190f6867fc1a29227be25df79f49383b5a894755",
    public let head_sha: String // e.g. "9aafb998bcee9fe1a1e8bea1222b39b024711ad9",
    public let old_path: String // e.g. "Shared/Print/PageElementManager.swift",
    public let new_path: String // e.g. "Shared/Print/PageElementManager.swift",
    public let position_type: String // e.g. "text",
    public let old_line: Int? // e.g. null,
    public let new_line: Int? // e.g. 150
}

/// A Note is a comment on snippets, issues, merge requests or epics.
///
/// [GitLab docs](https://docs.gitlab.com/ee/api/notes.html)
public struct Note: Codable {
    
    public let id: Int
    
    /// The note type.
    ///
    /// TODO: Type safe decoding: DiffNote.
    /// Possible values are:
    /// - null: A comment in the merge request.
    /// - DiffNote: A comment in the diff.
    public let type: String?
    
    public let body: String
    
    public let projectId: Int?
    
    public let author: User
    
    public let created_at: Date
    
    public let updated_at: Date
    
    public let system: Bool
    
    public let noteable_id: Int
    
    public let noteable_type: String // TODO: Type safe decoding
    
    /// The position of the note when type is DiffNote.
    public let position: NotePosition?
    
    /// Wether this is a resolvable comment or not.
    public let resolvable: Bool
    
    /// The resolved status, only available if resolvable is true (type is DiffNote).
    public let resolved: Bool?
    
    /// Who resolved this, only available if resolvable and resolved are true.
    public let resolved_by: Int?
    
    public let noteable_iid: Int
}
