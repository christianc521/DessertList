//
//  recipeViewModel.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//

import Foundation

class recipeViewModel: ObservableObject {
    func fetchRecipe(for mealName:String, completion:@escaping ([MealDetail]) -> ()) {
        // Replace whitespaces with underscores
        let formattedMealName = mealName.replacingOccurrences(of: " ", with: "_")
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(formattedMealName)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error making the request: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                print(recipeResponse.meals)
                DispatchQueue.main.async {
                    completion(recipeResponse.meals)
                }
            } catch {
                print("Error decoding the data: \(error)")
            }
        }
        .resume()
    }
}

