//
//  recipeModel.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//

import Foundation

struct RecipeResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String

    var ingredients: [String: String] = [:]
    
    static var placeholder: MealDetail {
            MealDetail(
                idMeal: "0",
                strMeal: "Default Meal",
                strInstructions: "Default Instructions"
            )
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(idMeal: String, strMeal: String, strInstructions: String, ingredients: [String: String] = [:]) {
            self.idMeal = idMeal
            self.strMeal = strMeal
            self.strInstructions = strInstructions
            self.ingredients = ingredients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "idMeal")!)
        self.strMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal")!)
        self.strInstructions = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions")!)

        // Handling dynamic ingredients
        for index in 1...20 {
            let ingredientKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            if let ingredientKey = DynamicCodingKeys(stringValue: ingredientKey),
               let measureKey = DynamicCodingKeys(stringValue: measureKey),
               let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                
                ingredients[ingredient] = measure
            }
        }
    }
}



// DynamicKey to handle dynamic keys
struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
