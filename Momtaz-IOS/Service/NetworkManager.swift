//
//  NetworkManager.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 16/12/2024.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    
    static let shared : NetworkManagerProtocol = NetworkManager()
    private init(){}
    
    private func getHeader() -> HTTPHeaders? {
        var headers : HTTPHeaders =
        [
            "Content-Type": "application/json"
        ]
        if let token = UserDefaultsManager.shared.getAccessToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
               
        return headers
    }
    
    func getData<T: Decodable>(url: String, handler: @escaping (T?) -> Void) {
        AF.request(url,parameters: nil, headers: nil).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    handler(result)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
//                    handler(nil)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func postData<T: Decodable>(url: String, parameters: Parameters, handler: @escaping (T?, Int?) -> Void) {
        AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: getHeader()).validate(statusCode: 200 ..< 299).responseData{ response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    handler(result,response.response?.statusCode)
                } catch {
                    print(error.localizedDescription)
                    return
                }
            case .failure(let error):
                print(error)
                handler(nil,error.responseCode)
            }
        }
    }
    
    func putData<T: Decodable>(url: String, parameters: Parameters, handler: @escaping (T?, Int?) -> Void) {
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: getHeader()).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    handler(result, response.response?.statusCode)
                } catch {
                    print(error.localizedDescription)
                    return
                }
            case .failure(let error):
                print(error)
                handler(nil, error.responseCode)
            }
        }
    }
    
    func deleteData(url: String, handler: @escaping (Bool, Int?) -> Void) {
        AF.request(url, method: .delete, headers: getHeader()).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success:
                handler(true, response.response?.statusCode)
                print("suceed in network")
            case .failure(let error):
                print(error)
                print("error in network")

                handler(false, error.responseCode)
            }
        }
    }
    
}
