//
//  CartViewController.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import UIKit
import NatDS

class CartViewController: UIViewController {
    
    private var addProductFormVC: AddProductFormViewController?
    private var addProductButtonsVC: AddProductButtonsViewController?
    
    private var count = 0
    
    private lazy var mainView = CartView()
    
    private let viewModel: CartViewModel
    
    init(vm: CartViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        registerCell()
        linkCombine()
        setupForm()
        setupButtons()
        setupNavigationBar()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Novo pedido"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func linkCombine() {
        
        viewModel.$items
            .sink { [weak self] items in
                self?.count = items.count
                self?.mainView.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$cart
            .sink { [weak self] cart in
                self?.mainView.cicleLabel.text = "Ciclo:  \(cart?.cicle ?? 0)"
            }
            .store(in: &viewModel.cancellables)
    }
    
    func setupButtons() {
        if addProductButtonsVC == nil {
            addProductButtonsVC = AddProductButtonsViewController()
        }
        
        if let buttonsVC = addProductButtonsVC {
            self.mainView.buttonsView.addSubview(buttonsVC.view)
            
            buttonsVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonsVC.view.leadingAnchor.constraint(equalTo: mainView.buttonsView.leadingAnchor),
                buttonsVC.view.trailingAnchor.constraint(equalTo: mainView.buttonsView.trailingAnchor),
                buttonsVC.view.topAnchor.constraint(equalTo: mainView.buttonsView.topAnchor),
                buttonsVC.view.bottomAnchor.constraint(equalTo: mainView.buttonsView.bottomAnchor)
            ])
        }
    }
    
    func setupForm() {
        if addProductFormVC == nil {
            addProductFormVC = AddProductFormViewController(vm: viewModel.addProductFormViewModel)
        }
 
        if let formVC = addProductFormVC {
            self.mainView.formView.addSubview(formVC.view)
 
            formVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                formVC.view.leadingAnchor.constraint(equalTo: mainView.formView.leadingAnchor),
                formVC.view.trailingAnchor.constraint(equalTo: mainView.formView.trailingAnchor),
                formVC.view.topAnchor.constraint(equalTo: mainView.formView.topAnchor),
                formVC.view.bottomAnchor.constraint(equalTo: mainView.formView.bottomAnchor)
            ])
        }
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    func registerCell() {
        mainView.tableView.register(CartItemCell.self, forCellReuseIdentifier: "listItem")
    }
    
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! CartItemCell
        
        cell.configure(divider: .inset)
        cell.configure(feedbackStyle: .ripple)
        cell.configure(onClick: false)
        
        cell.setup(title: viewModel.getItemTitle(index: indexPath.row), price: viewModel.getItemPrice(index: indexPath.row))
        
        return cell
    }
    
}
