//
//  Repository.swift
//  Recipe
//
//  Created by Bartosz Klimek on 20/09/2023.
//

import Foundation

struct Repository {
    
    static func getEquipment(id: Int, completion: @escaping ([Equipment]?) -> Void) {
        if let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/equipmentWidget.json?apiKey=\(Constants.apiKey)") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    completion(nil)
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode)  else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let equipmentResponse = try decoder.decode(EquipmentResponse.self, from: data)
                    completion(equipmentResponse.equipment)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    }
    
    static func getIngredients(id: Int, completion: @escaping ([APIIngredient]?) -> Void) {
        if let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json?apiKey=\(Constants.apiKey)") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    completion(nil)
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode)  else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let ingredientsResponse = try decoder.decode(IngredientsResponse.self, from: data)
                    completion(ingredientsResponse.ingredients)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    }
    
    static func searchProduct(query: String, completion: @escaping ([Product]?) -> Void) {
        if let url = URL(string: "https://api.spoonacular.com/food/products/search?apiKey=\(Constants.apiKey)&query=\(query)") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    completion(nil)
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode)  else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let searchProductResponse = try decoder.decode(SearchProductResponse.self, from: data)
                    completion(searchProductResponse.products)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    }
}
