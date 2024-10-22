//
//  ViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/15/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }


}

