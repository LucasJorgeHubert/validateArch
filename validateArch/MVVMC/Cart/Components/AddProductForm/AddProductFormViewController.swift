//
//  AddProductFormViewController.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import UIKit

class AddProductFormViewController: UIViewController {
    
    let mainView = AddProductFormView()
    
    let viemModel: AddProductFormViewModel
    
    init(vm: AddProductFormViewModel) {
        self.viemModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCombine()
        setupButtons()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func setupCombine() {
        self.viemModel.$error
            .sink { [weak self] error in
                switch error {
                case .none:
                    self?.mainView.productDescripionTextField.configure(state: .none, with: "")
                    self?.mainView.productQuantityTextField.configure(state: .none, with: "")
                case .emptyForm:
                    self?.mainView.productDescripionTextField.error = "Preencha o Código"
                    self?.mainView.productQuantityTextField.error = "Preencha a Quantidade"
                case .invalidCode:
                    self?.mainView.productDescripionTextField.error = "Código inválido"
                case .invalidQuantity:
                    self?.mainView.productQuantityTextField.error = "Quantidade inválida"
                }
            }.store(in: &self.viemModel.cancellables)
        
        self.viemModel.$isLoading.sink { [weak self] isLoading in
                self?.mainView.loading.isHidden = !isLoading
        }.store(in: &self.viemModel.cancellables)
    }
    
    func setupButtons() {
        mainView.addProductButton.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
    }
    
    @objc func close() {
        print("some")
    }
    
    @objc func addProduct() {
        self.viemModel.addItem(item: AddCartItemForm(
            code: mainView.productDescripionTextField.text ?? "",
            quantity: Int(mainView.productQuantityTextField.text ?? "0") ?? 0
        ))
    }

}
