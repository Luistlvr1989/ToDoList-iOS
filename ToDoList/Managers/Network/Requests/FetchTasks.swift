//
//  FetchTasks.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FetchTasks : Request<[TaskDto]> {
    override func execute(completion: @escaping (_ result: ApiResult<[TaskDto]>) -> Void) {
        let url = "\(baseUrl)/tasks"
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseArray { (response: DataResponse<[TaskDto]>) in
                switch response.result {
                case .success:
                    if let items = response.result.value {
                        completion(ApiResult.success(result: items))
                    } else {
                        completion(ApiResult.failure(error: .parsingError))
                    }
                    break
                case .failure(let error):
                    completion(ApiResult.failure(error: self.apiError(from: error)))
                    break
                }
        }
    }
}
