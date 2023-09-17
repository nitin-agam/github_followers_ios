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
        request.log()
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let self = self {
                response?.log(data: data, error: error, printJSON: true)
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

extension URLRequest {
    
    func log() {
        let body = self.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "Nil"
        let requestUrl = self.url?.absoluteString ?? "Nil"
        
        var headerPrint = ""
#if DEBUG
        headerPrint = "⚡️⚡️⚡️⚡️ HEADERS -> \(String(describing: self.allHTTPHeaderFields))"
#endif
        
        let networkRequest = """
            ⚡️⚡️⚡️⚡️ REQUEST ⚡️⚡️⚡️⚡️
            ⚡️⚡️⚡️⚡️ URL -> \(requestUrl)
            ⚡️⚡️⚡️⚡️ METHOD -> \(String(describing: self.httpMethod))
            ⚡️⚡️⚡️⚡️ BODY -> \(body)
            \(headerPrint)
            ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
        """
        print(networkRequest)
    }
}

extension URLResponse {
    
    func log(data: Data?, error: Error?, printJSON: Bool = false) {
        var statusCode = 0
        if let httpUrlResponse = self as? HTTPURLResponse {
            statusCode = httpUrlResponse.statusCode
        }
        
        let jsonToPrint = printJSON ? "⚡️⚡️⚡️⚡️ DATA JSON -> \(String(describing: data?.jsonObject))" : ""
        
        let networkResponse = """
        ⚡️⚡️⚡️⚡️ RESPONSE ⚡️⚡️⚡️⚡️
        ⚡️⚡️⚡️⚡️ URL -> \(self.url?.absoluteString ?? "nil")
        ⚡️⚡️⚡️⚡️ DATA -> \(String(describing: data))
        ⚡️⚡️⚡️⚡️ STATUS CODE -> \(statusCode)
        ⚡️⚡️⚡️⚡️ ERROR -> \(String(describing: error))
        \(jsonToPrint)
        ⚡️⚡️⚡️⚡️ ---------------------- ⚡️⚡️⚡️⚡️
    """
        print(networkResponse)
    }
}

extension Data {
    var jsonObject: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            return nil
        }
    }
}
