//
//  recipeModel.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//

import Foundation
import SwiftUI

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String

}
