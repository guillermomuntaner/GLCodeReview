//
//  GitLabAPI.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

/// The GitLab API.
///
/// This type contains static factories for GitLab API `Endpoint`s.
/// Endpoints instantiated via `GitLabAPI` can be executed using the `ApiClient`.
public enum GitLabAPI {
    // Note:
    // This file is internded to hold very basic functionality and helpers.
    // Gitlab endpoints are organized in groups and this project follows same organization
    // by splitting them into directories. A GitLabAPI extension can be found in each
    // endpoint directory.
}

// MARK: Decoding via Swift Decodable with a JSONDecoder with custom date decoding strategy

extension Endpoint where Response: Swift.Decodable {
    
    /// Constructor with automatic decoding implementation using Swift Decodable with a custom date decoding strategy.
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(method: method, path: path, parameters: parameters) {
            try GitLabAPI.decoder.decode(Response.self, from: $0)
        }
    }
}

extension GitLabAPI {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        return decoder
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    
    static let customISO8601 = custom { decoder throws -> Date in
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601.date(from: string) ?? Formatter.iso8601noFS.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

extension Formatter {
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    static let iso8601noFS: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
}

extension String {
    var urlQueryParamEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var urlHostEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
