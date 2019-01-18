//
//  TableViewPresenter.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation

class TableViewPresenter {
    private weak var view: TableViewController?
    
    init(view: TableViewController) {
        self.view = view
    }
    
    func prepareData() {
        FetchTasks().execute() { result in
            switch result {
            case .success(let tasks):
                self.view?.refreshTasks(tasks: tasks)
                break
                
            case .failure(let error):
                self.view?.showError(message: error.userMessage())
                break
            }
        }
    }
    
    func deleteTask(id: Int32) {
        self.view?.showProgress()
        DeleteTask(id: id).execute() { result in
            switch result {
            case .success:
                self.view?.hideProgress()
                self.prepareData()
                break
                
            case .failure(let error):
                self.view?.hideProgress()
                self.view?.showError(message: error.userMessage())
                break
            }
        }
    }
}
