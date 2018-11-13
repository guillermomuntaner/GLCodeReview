//
//  GitLabAPI+Markdown.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 06/11/2018.
//

import Foundation

fileprivate struct MarkdownResponse: Codable {
    fileprivate let html: String
}

fileprivate struct MarkdownRequest: Encodable {
    /// The markdown text to render
    fileprivate let text: String
    /// Render text using GitLab Flavored Markdown. Default is false
    fileprivate let gfm: Bool?
    /// Use project as a context when creating references using GitLab Flavored Markdown. Authentication is required if a project is not public.
    fileprivate let project: String
}

extension GitLabAPI {
    
    /// Render an arbitrary Markdown document
    ///
    /// [Wiki docs](https://docs.gitlab.com/ee/api/markdown.html)
    
    
    public static func getMarkdown(text: String, gfm: Bool?, project: String?) -> Endpoint<String> {
        var parameters: [String: Any] = ["text" : text]
        parameters["gfm"] = gfm
        parameters["project"] = project
        return Endpoint<String>(path: "api/v4/markdown", parameters: parameters) { (data) -> String in
            // Custom decoding to unwrap the html
            try GitLabAPI.decoder.decode(MarkdownResponse.self, from: data).html
        }
    }
}
