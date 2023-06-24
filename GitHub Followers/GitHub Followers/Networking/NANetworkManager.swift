//
//  NANetworkManager.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

var Networking: NANetworkManager {
    return NANetworkManager.shared
}

class NANetworkManager {
    
    // MARK: - Properties
    static let shared: NANetworkManager = NANetworkManager()
    typealias Handler = ((Result<Data, NAError>) -> ())?
    
    
    // MARK: - Public Methods
    func sendRequest(_ endpoint: NAEndpoint, completion: Handler) {
        guard let request = endpoint.urlRequest else { return }
        executeRequest(request: request, completion: completion)
    }
    
    
    // MARK: - Private Method
    private func executeRequest(request: URLRequest, completion: Handler) {
        logStartRequest(request)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let self = self {
                self.logEndRequest(response, data: data, error: error)
                self.result(from: data, response: response, request: request, completion)
            } else {
                completion?(.failure(NAError(title: "No internet connection.")))
            }
        }
        dataTask.resume()
    }
}

// MARK: - Utility Methods
extension NANetworkManager {
    
    class func convertToData(_ value: Any) -> Data {
        if let str =  value as? String {
            return str.data(using: String.Encoding.utf8)!
        } else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
            return jsonData
        } else {
            return Data()
        }
    }
    
    func result(from data: Data?, response: URLResponse?, request: URLRequest, _ completion: Handler) {
        guard let data = data else {
            completion?(.failure(NAError(title: "Something is wrong with the response.")))
            return
        }
        completion?(.success(data))
    }
}

extension NANetworkManager {
    
    func logStartRequest(_ request: URLRequest) {
        let body = request.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "Nil"
        let requestUrl = request.url?.absoluteString ?? "Nil"
        
        var headerPrint = ""
        #if DEBUG
        headerPrint = "⚡️⚡️⚡️⚡️ HEADERS -> \(String(describing: request.allHTTPHeaderFields))"
        #endif
        
        let networkRequest = """
            ⚡️⚡️⚡️⚡️ REQUEST ⚡️⚡️⚡️⚡️
            ⚡️⚡️⚡️⚡️ URL -> \(requestUrl)
            ⚡️⚡️⚡️⚡️ METHOD -> \(String(describing: request.httpMethod))
            ⚡️⚡️⚡️⚡️ BODY -> \(body)
            \(headerPrint)
            ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
        """
        print(networkRequest)
    }
    
    func logEndRequest(_ response: URLResponse?, data: Data?, error: Error?) {
        var statusCode = 0
        if let httpUrlResponse = response as? HTTPURLResponse {
            statusCode = httpUrlResponse.statusCode
        }
        
        let networkResponse = """
        ⚡️⚡️⚡️⚡️ RESPONSE ⚡️⚡️⚡️⚡️
        ⚡️⚡️⚡️⚡️ URL -> \(response?.url?.absoluteString ?? "NIL")
        ⚡️⚡️⚡️⚡️ STATUS CODE -> \(statusCode)
        ⚡️⚡️⚡️⚡️ ERROR -> \(String(describing: error))
        ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
    """
        print(networkResponse)
    }
}

