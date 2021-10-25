
import PromiseKit
var service: ApiInterface?

struct Console{
    static func log(_ message: Any?){
        print(message ?? "Nothing to log")
        
    }
}
 protocol ApiInterface {
    func register<T: Decodable>(params: [String: Any]) -> Promise<T>
    func login<T: Decodable>(params: [String: Any]) -> Promise<T>
    func socialLogin<T: Decodable>(params: [String: Any]) -> Promise<T>
    func verifyEmail<T: Decodable>(params: [String: Any]) -> Promise<T>
    func forgotPassword<T: Decodable>(params: [String: Any]) -> Promise<T>
     func logout<T: Decodable>(params: [String: Any]) -> Promise<T>



}

final class Services: NSObject, ApiInterface {
    func logout<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.logout(params: params))
        
    }
    
    func forgotPassword<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.forgotPassword(params: params))
        
    }
    
    func verifyEmail<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.verifyEmail(params: params))
        
    }
    
    func login<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.login(params: params))
    }
    
    func socialLogin<T>(params: [String : Any]) -> Promise<T> where T : Decodable {
        client.requestWithParams(.socialLogin(params: params))
    }
    
    func register<T: Decodable>(params: [String : Any]) -> Promise<T>  {
        client.requestWithParams(.register(params: params))
    }
    
}

    private let client = Client()

    
}
