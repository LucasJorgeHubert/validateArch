//
//  AddProductFormViewModel.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import Combine

enum errorAddProductForm: Error {
    case emptyForm
    case invalidCode
    case invalidQuantity
    case none
}

class AddProductFormViewModel: ObservableObject {
    
    // MARK: - Link to parent
    @Published var itemAdded: AddCartItemForm?
    @Published var isValid: Bool = false
    
    // MARK: - Link to view
    @Published var error: errorAddProductForm = .none
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
    }
    
    func validate(item: AddCartItemForm) {
        if item.code == "" && item.quantity == 0 {
            isValid = false
            self.error = .emptyForm
        } else if item.code == "" {
            isValid = false
            self.error = .invalidCode
        } else if item.quantity == 0 {
            isValid = false
            self.error = .invalidQuantity
        } else {
            isValid = true
            self.error = .none
        }
    }
    
    func addItem(item: AddCartItemForm)  {
        validate(item: item)
        
        if isValid {
            fakeRequest(item: item)
        }
    }
    
    func fakeRequest(item: AddCartItemForm)  {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.itemAdded = item
            self.isLoading = false
        }
    }
    
}
