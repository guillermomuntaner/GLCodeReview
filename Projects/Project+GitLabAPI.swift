//
//  Project+GitLabAPI.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 27/09/2018.
//

import Foundation

extension GitLabAPI {
    
    public static func getProjects(
        sort: Sort = .descending,
        orderBy: OrderBy = .updatedAt) -> Endpoint<[Project]> {
        return Endpoint<[Project]>(
            method: .get,
            path: "api/v4/projects?sort=\(sort.rawValue)&order_by=\(orderBy.rawValue)")
    }
}
