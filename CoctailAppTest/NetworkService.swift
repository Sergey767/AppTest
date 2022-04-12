//
//  NetworkService.swift
//  CoctailAppTest
//
//  Created by Сергей Горячев on 08.04.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    func getDrinks(completion: @escaping (Drink) -> Void) {
        
        AF.request("https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic").responseData {
            response in

            guard let data = response.value else { return }

            do {
                let drinks = try JSONDecoder().decode(Drink.self, from: data)
                completion(drinks)
            } catch {
                print(error)
            }
        }
    }
}
