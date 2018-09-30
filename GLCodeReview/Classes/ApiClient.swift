//
//  GitLabApiClient.swift
//  GLCodeReview
//
//  Created by Guillermo Muntaner Perelló on 26/09/2018.
//

import Foundation

// MARK: - Endpoint model

typealias Parameters = [String: Any]

typealias Path = String

public enum Method {
    case get, post
}

/// Representation of an API endpoint.
public final class Endpoint<Response> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let decode: (Data) throws -> Response
    
    internal init(method: Method = .get,
         path: Path,
         parameters: Parameters? = nil,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }
}

// MARK: Convenience

extension Endpoint where Response == Void {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            decode: { _ in () }
        )
    }
}

// MARK: - API Client

public enum Result<T> {
    case success(T)
    case failure(Error)
}

/// A representation of an HTTP header.
public protocol HTTPHeader {
    var field: String { get }
    var value: String { get }
}

protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>, dispatchQueue: DispatchQueue, completion: @escaping (Result<Response>) -> Void)
}

public final class Client: ClientProtocol {
    
    private let baseURL: URL
    private let authenticationHttpHeader: HTTPHeader
    private let session: URLSession
    
    public init(baseURL: URL, authenticationHttpHeader: HTTPHeader, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.authenticationHttpHeader = authenticationHttpHeader
        self.session = session
    }
    
    public func request<Response>(_ endpoint: Endpoint<Response>, dispatchQueue: DispatchQueue = .main, completion: @escaping (Result<Response>) -> Void) {
        let request = NSMutableURLRequest(url: URL(string: endpoint.path, relativeTo: baseURL)!)
        switch endpoint.method {
        case .get: request.httpMethod = "GET"
        case .post: request.httpMethod = "POST"
        }
        request.addValue(authenticationHttpHeader.value, forHTTPHeaderField: authenticationHttpHeader.field)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, urlResponse, error) in
            if let error = error {
                dispatchQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    let response = try endpoint.decode(data)
                    dispatchQueue.async {
                        completion(.success(response))
                    }
                } catch {
                    dispatchQueue.async {
                        completion(.failure(error))
                    }
                }
            } else {
                fatalError("URLSession.dataTask completition handler called with nil data and error")
            }
        }
        dataTask.resume()
    }
}
