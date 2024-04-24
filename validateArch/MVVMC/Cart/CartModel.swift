//
//  CartModel.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation

struct CartModel: Codable, Equatable {
    var cicle: Int
    
    static func mockData() -> CartModel {
        return CartModel(cicle: 1)
    }
    
}

struct CartItem: Codable, Equatable {
    let name: String
    let price: Int
}
