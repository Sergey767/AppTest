//
//  Drink.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 08.04.2022.
//

import Foundation

struct Drink: Codable {
    let drinks: [Drinks]?
    
    init() {
        self.drinks = nil
    }
}

struct Drinks: Codable {

    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
