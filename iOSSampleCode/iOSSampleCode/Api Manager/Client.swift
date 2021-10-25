

import Alamofire
import PromiseKit

struct MultiPart{
    let data: Data
    let fileNameWithExt: String
    let serverKey: String
    let mimeType: MediaFileType
}
enum MediaFileType: String {
    case image = "image/png"
    case video = "video/mov"
}

enum Result<T> {
    case success(T)
    case failure(Error?)
    case noNetwork(Error)
    case progress(Float)
    case noDataFound(String)
    case pageNotFound
}

 final class Client {
    
    let session:  Session!
    let decoder = JSONDecoder()
    init() {
        let logger = Logger()
        session = Session(eventMonitors: [logger])
        //decoder.keyDecodingStrategy = .convertFromSnakeCase

    }
    
    func requestWithParams<T: Decodable>(_ router: Router) -> Promise <T> {
        return Promise { seal in
            session.request(router).validate(statusCode: 200..<500).responseDecodable(of: T.self, decoder: decoder) { (response) in
                switch response.result{
                case .success(let data):
                    print(data)
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(self.actualError(error: error, data: response.data, statusCode: response.response?.statusCode))
                }
            }
        }
    }

    func actualError(error: AFError, data: Data?, statusCode: Int?) -> Error{
        if statusCode == 401{
            kAppDelegate.logoutUser()
        }
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    return NSError(domain:"com.hyred.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
                case .networkConnectionLost:
                    return NSError(domain:"com.hyred.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
                default:
                    
                    return error
                }
            }
        }
        return error
        
    }
   class func getModel<T: Decodable>(object: Any) -> T?{
        do{
            let data = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
            return  try JSONDecoder().decode(T.self, from: data)
        }catch{
            print("\(error)")
        }
        return nil
    }
    
  class  func getModel<T: Decodable>(data: Data) -> T?{
          do{
              return  try JSONDecoder().decode(T.self, from: data)
          }catch{
              print("\(error)")
          }
          return nil
      }
    class func getDirectoryPath()-> URL?{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    class func getDocumentDirectoryFilePath(string: String) -> URL?{
        let pathUrl = getDirectoryPath()
        return pathUrl?.appendingPathComponent(string)
    }
    class func requestMultipartApiServer(methodName:String, parameters: [String:Any]?, methodType: HTTPMethod, showLoader: Bool = true, result: @escaping (Result<Any>) -> () , _ onProgress: @escaping (Double)-> ())  {
        
        let serviceUrlPathString = ServerURL.baseURL+methodName
        var headers = [String: String]()
        headers = ["Accept": "application/json"]
        if let token =  kUserDefaults.value(forKey: AppKeys.token) as? String{
            headers = [
                "token": token,
                "Accept": "application/json",
                "Authorization": "Bearer \(token)",
       
            ]
        }
        AF.upload(multipartFormData: { multiPart in
                  guard let params = parameters else{return}
                  for (key, value) in params {
                      if let allMedia = value as? [MultiPart]{
                          let allkeys = allMedia.map({$0.serverKey})
                          let unique = Array(Set(allkeys))
                          for serverKey in unique{
                              let uploadFile = allMedia.filter({$0.serverKey == serverKey})
                              if uploadFile.count > 1 {
                                  for media in uploadFile{
                                      multiPart.append(media.data, withName: "\(media.serverKey)", fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                                  }
                              }else{
                                  if let media = uploadFile.first{
                                      multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                                  }
                              }
                          }
                      }else if let media = value as? MultiPart{
                          multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                      }else if let data = "\(value)".data(using: .utf8) {
                          multiPart.append(data, withName: key)
                      }
                      
                  }
              },to: serviceUrlPathString, method: methodType, headers: HTTPHeaders(headers))
              .uploadProgress(queue: .main, closure: { progress in
                  onProgress(progress.fractionCompleted)
              })
              .responseJSON(completionHandler:  { (response) in
                  switch response.result{
                  case .success(let data):
                    result(Result.success(data))
                  case .failure(let error):
                    result(Result.failure(error))
                  }
                Logger.prettyPrintDict(with: response.value ?? ["test": "test"])
            }
      )}
}



