//
//  NetworkManagerProtocol.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 16/12/2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(url: String,handler: @escaping (T?, String?) -> Void)
    
    func postData<T: Decodable>(url: String, parameters: Parameters,handler: @escaping (T?, Int?) -> Void)
    
    func putData<T: Decodable>(url: String, parameters: Parameters, handler: @escaping (T?, Int?) -> Void)
    func deleteData(url: String, handler: @escaping (Bool, Int?) -> Void)
    
}
