//
//  UpdateTask.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class UpdateTask : Request<Void> {
    fileprivate var taskDto: TaskDto
    
    init(taskDto: TaskDto) {
        self.taskDto = taskDto
    }
    
    override func execute(completion: @escaping (_ result: ApiResult<Void>) -> Void) {
        let url = "\(baseUrl)/tasks/\(taskDto.id!)"
        
        var parameters = [String:String]()
        parameters["title"] = taskDto.title
        parameters["detail"] = taskDto.detail
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                let error = response.error
                if error == nil {
                    completion(ApiResult.success(result: ()))
                } else {
                    completion(ApiResult.failure(error: self.apiError(from: error)))
                }
        }
    }
}
