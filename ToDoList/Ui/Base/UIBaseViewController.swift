//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/17/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import TTGSnackbar

class UIBaseViewController<T>: UIViewController, BaseView {
    fileprivate var snackbar = TTGSnackbar(message: "", duration: .long)
    
    var presenter: T?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = createPresenter()
    }
    
    func createPresenter() -> T {
        preconditionFailure("This method must be overridden")
    }
    
    func showProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showError(message: String) {
        snackbar.message = message
        snackbar.show()
    }
}
