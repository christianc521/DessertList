//
//  ContentView.swift
//  RecipeFinder
//
//  Created by Christian Cruz on 12/7/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel = mealViewModel()
    @State private var selectedMeal: Meal?
    @State var isTapped = false
    @State private var isDetailViewActive = false
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink(
                    destination: MealDetailView(meal: viewModel.selectedMealDetail ?? MealDetail.placeholder),
                       isActive: Binding<Bool>(get: { isTapped },
                                               set: { isTapped = $0; print("clicked on: \(meal.strMeal)");
                                                   viewModel.fetchRecipe(for: meal.strMeal);
                                                   selectedMeal = meal;
                                                   isDetailViewActive = true}),
                       label: { HStack {
                           AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                               image.resizable() // Make the image resizable
                           }
                           placeholder: {
                               ProgressView() // Show a progress view while loading the image
                           }
                           .frame(width: 50, height: 50) // Set the frame for the image
                           .clipShape(Circle()) // Clip the image to a circle
                           .padding(.trailing, 8) // Add some padding to the right of the image
                           
                           Text(meal.strMeal)
                        }
                           
                       }
                )
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMeals()
            }
        } detail: {
            Text("Select a dessert")
        }
    }
}


//NavigationStack {
//            List(viewModel.meals, id: \.idMeal) { meal in
//                Button(meal.strMeal) {
//                    viewModel.fetchRecipe(for: meal.strMeal)
//                    isDetailViewActive = true
//                }
//            }
//            .navigationTitle("Desserts")
//
//            // Conditional NavigationLink
//            NavigationLink(
//                destination: MealDetailView(meal: viewModel.selectedMealDetail ?? MealDetail.placeholder),
//                isActive: $isDetailViewActive
//            ) { EmptyView() }
//        }
//        .onAppear {
//            viewModel.fetchMeals()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
