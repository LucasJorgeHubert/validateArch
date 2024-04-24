//
//  CartViewModel.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import Combine

class CartViewModel: ObservableObject {
    
    let coordinator: MainCoordinator
    
    var addProductFormViewModel = AddProductFormViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        getCart()
        
        addProductFormViewModel.$itemAdded
            .sink { item in
                guard let item = item else { return }
                self.addItemFromForm(item: item)
            }
            .store(in: &cancellables)
    }
    
    @Published var items: [CartItem] = []
    @Published var cart: CartModel?
    
    func getCart() {
        self.cart = CartModel.mockData()
    }
    
    func addItemFromForm(item: AddCartItemForm) {
        self.items.append(CartItem(name: item.code, price: 10))
    }
    
    func removeItem(item: CartItem) {
        self.items.removeAll { $0 == item }
    }
    
    func removeAll() {
        self.items.removeAll()
    }
    
    func getItem(index: Int) -> CartItem {
        return self.items[index]
    }
    
    func getItemTitle(index: Int) -> String {
        return self.items[index].name
    }
    
    func getItemPrice(index: Int) -> String {
        return String(self.items[index].price)
    }
    
    func getItemsCount() -> Int {
        return self.items.count
    }
    
    func getTotal() -> Int {
        var total = 0
        for item in self.items {
            total += item.price
        }
        return total
    }
    
    
}

