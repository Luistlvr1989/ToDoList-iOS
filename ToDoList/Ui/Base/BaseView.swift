//
//  BaseView.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/18/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation

protocol BaseView {
    associatedtype T
    
    func createPresenter() -> T
    func showProgress()
    func hideProgress()
    func showError(message: String)
}
