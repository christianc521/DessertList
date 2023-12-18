//
//  MealDetailView.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//
import SwiftUI

struct MealDetailView: View {
    let meal: MealDetail  // Assuming MealDetail is your detailed meal model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(meal.strMeal)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Ingredients")
                    .font(.headline)
                ForEach(meal.ingredients.keys.sorted(), id: \.self) { key in
                    if let value = meal.ingredients[key] {
                        Text("\(key): \(value)")
                    }
                }

                Text("Instructions")
                    .font(.headline)
                Text(meal.strInstructions)

                
            }
            .padding()
        }
    }
}

