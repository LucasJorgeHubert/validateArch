//
//  AddProductButtonsViewController.swift
//  validateArch
//
//  Created by Lucas Hubert on 23/04/24.
//

import UIKit

class AddProductButtonsViewController: UIViewController {

    let mainView = AddProductButtonsView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }

}
