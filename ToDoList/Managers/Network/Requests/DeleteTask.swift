//
//  DeleteTask.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class DeleteTask : Request<Void> {
    fileprivate var id: Int32
    
    init(id: Int32) {
        self.id = id
    }
    
    override func execute(completion: @escaping (_ result: ApiResult<Void>) -> Void) {
        let url = "\(baseUrl)/tasks/\(id)"
        
        Alamofire.request(url, method: .delete)
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
