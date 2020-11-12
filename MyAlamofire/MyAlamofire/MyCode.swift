//
//  MyCode.swift
//  MyAlamofire
//
//  Created by 刘菁楷 on 2020/11/11.
//

import Foundation

public enum HTTPMethod: String {
//    case options = "OPTIONS"
    case get     = "GET"
//    case head    = "HEAD"
    case post    = "POST"
//    case put     = "PUT"
//    case patch   = "PATCH"
//    case delete  = "DELETE"
//    case trace   = "TRACE"
//    case connect = "CONNECT"
}

extension URLRequest {
    public init(url: URLConvertible, method: HTTPMethod, headers: [String: String]? = nil) {
        let url = url.asURL()
        self.init(url: url)
        self.httpMethod = method.rawValue
        if let headers = headers {
            for (key, value) in headers {
                self.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}

public protocol URLConvertible {
    func asURL() -> URL
}

extension String: URLConvertible {
    public func asURL() -> URL {
        return URL(string: self)!
    }
}

extension URL: URLConvertible {
    public func asURL() -> URL {
        return self
    }
}

public class MyAlamofire {
    
    @discardableResult
    public static func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: [String: Any]? = nil, encoding: String.Encoding = .utf8, headers: [String: String]? = nil) -> DataRequest {
        
        return DataRequest(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}

public class DataRequest {
    
    var url: URLConvertible
    var method: HTTPMethod
    var parameters: [String: Any]?
    var encoding: String.Encoding
    var headers: [String: String]?
    var request: URLRequest?
    
    public init(_ url: URLConvertible, method: HTTPMethod = .get, parameters: [String: Any]? = nil, encoding: String.Encoding = .utf8, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        
        getRequest()
    }
    
    private func getRequest() {
        
        switch method {
        case .get:
            if var urlStr = url as? String {
                if let parameters = parameters {
                    let dataString = parameters.compactMap({ (key, value) in
                        return "\(key)=\(value)"
                    }).joined(separator: "&")
                    urlStr += "?" + dataString
                }
                request = URLRequest(url: urlStr, method: method, headers: headers)
            } else {
                request = URLRequest(url: url, method: method, headers: headers)
            }
        case .post:
            request = URLRequest(url: url, method: method, headers: headers)
            if let parameters = parameters {
                let dataString = parameters.compactMap({ (key, value) in
                    return "\(key)=\(value)"
                }).joined(separator: "&")
                request?.httpBody = dataString.data(using: encoding)
            }
        }
    }
    
    public class Response<T> {
        enum Result {
            case success(T)
            case failure(Error)
        }
        var result: Result
        init(_ result: Result) {
            self.result = result
        }
    }
    
    @discardableResult
    public func responseJSON(completionHandler: @escaping (Response<Any>) -> Void) -> Self {
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            var res: Response<Any>?
            if let error = error {
                res = Response(.failure(error))
            } else {
                do {
                    // 转换为JSON格式
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                    res = Response(.success(json))
                } catch(let e) {
                    res = Response(.failure(e))
                }
            }
            completionHandler(res!)
        }
        dataTask.resume()
        
        return self
    }
    
    @discardableResult
    public func responseString(completionHandler: @escaping (Response<String>) -> Void) -> Self {
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            var res: Response<String>?
            if let error = error {
                res = Response(.failure(error))
            } else {
                // 转换为String格式
                let str = String(data: data!, encoding: self.encoding)
                res = Response(.success(str!))
            }
            completionHandler(res!)
        }
        dataTask.resume()
        
        return self
    }
    
    @discardableResult
    public func responseData(completionHandler: @escaping (Response<Data>) -> Void) -> Self {
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            var res: Response<Data>?
            if let error = error {
                res = Response(.failure(error))
            } else {
                res = Response(.success(data!))
            }
            completionHandler(res!)
        }
        dataTask.resume()
        
        return self
    }
}
