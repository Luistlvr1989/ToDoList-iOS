//
//  Request.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import Alamofire

class Request<T> {
    let baseUrl: String = "http://169.254.51.163:3000/api/v1"
    
    func execute(completion: @escaping (_ result: ApiResult<T>) -> Void) {
        preconditionFailure("This method must be overridden") 
    }
    
    func apiError(from error: Error?) -> ApiError {
        if let error = error as? ApiError {
            return error
        } else if let error = error as? URLError, error.code == .notConnectedToInternet {
            return .noInternetConnection
        } else if let error = error as? AFError, let responseCode = error.responseCode {
            switch responseCode {
            case 400, 404, 500..<600:
                return .internalServerError
            default:
                return .serverUnreachable
            }
        } else {
            return .internalServerError
        }
    }
}

enum ApiResult<T> {
    case success(result: T)
    case failure(error: ApiError)
}

public enum ApiError: Error {
    case internalServerError
    case serverUnreachable
    case noInternetConnection
    case parsingError
    
    func userMessage() -> String {
        switch self {
        case .internalServerError:
            return "El servidor respondió de forma inesperada. Por favor intente nuevamente más tarde"
        case .serverUnreachable:
            return "El servidor esta tomando mucho tiempo en responder. Por favor intente nuevamente más tarde"
        case .noInternetConnection:
            return "Su conexión a internet no se encuentra activa y es necesaria para procesar su orden"
        case .parsingError:
            return "Hubo un problema al procesar la respuesta"
        }
    }
}
