

import Alamofire
import UIKit
public enum Router {
    public typealias Params = [String: Any]
    case register(params: Params)
    case login(params: Params)
    case socialLogin(params: Params)
    case verifyEmail(params: Params)
    case forgotPassword(params: Params)
    case logout(params: Params)


}
extension Router:  Alamofire.URLRequestConvertible {
    
    public func asURLRequest () throws -> URLRequest {
        let config = self.requestConfig
        var baseURL: URL {
            switch self {
            case .register, .login, .socialLogin:
                return URL(string: ServerURL.authURL)!
            default:
                return URL(string: ServerURL.baseURL)!
            }
        }
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(config.endPoint))
        urlRequest.httpMethod = config.method.rawValue
        
        if let token =  kUserDefaults.value(forKey: AppKeys.token) as? String{
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let params = config.params, params.count > 0 {
            switch config.method {
            case .get:
                var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponents.url!
                return urlRequest
            default:
                return try JSONEncoding.default.encode(urlRequest, with: params)
            }
        } else {
            return try JSONEncoding.default.encode(urlRequest)
        }
    }
 
}

extension Router {
    var requestConfig: (endPoint: String, params: Params?, method: Alamofire.HTTPMethod) {
        switch self {
        case .register(let params):
            return ("user/registration", params, .post)
        case .login(let params):
            return ("user/login", params, .post)
        case .socialLogin(let params):
            return ("user/social-login", params, .post)
        case .verifyEmail(let params):
            return ("user/verifyEmail", params, .post)
        case .forgotPassword(let params):
            return ("user/forget-password", params, .post)
        case .logout(let params):
            return("user/logout", params, .post)

        }
            
    }
}

struct ServerURL {
    static let baseURL = "http://server/api/"
    static let authURL = "http://server/auth/api/"

}

