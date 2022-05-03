//
//  http_service.swift
//  fsocial
//
//  Created by halil yılmaz on 27.04.2022.
//

import Foundation

enum CustomError : Error {
    case invalidUrl
    case invalidData
}
enum HttpMethod : String{
    case get = "GET"
    case post = "POST"
}



class HttpService {
    
    // MARK: - Properties
    static let shared: HttpService = HttpService()
    var baseURL: String = "https://api.binance.com/api/v3"
}

extension HttpService{
    
    func getRequest<T:Codable>(url: URL?, httpMethod: String ,expecting: T.Type,completion:@escaping(Result<T,Error>)->Void){
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
    func getReq<T:Codable>(url: URL?, httpMethod: String ,expecting: T.Type,completion:@escaping(Result<T,Error>)->Void){
        
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(.failure(CustomError.invalidData))
            }else if let data = data {
                do{
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
