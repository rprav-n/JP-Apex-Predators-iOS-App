//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Praveen R on 04/02/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    
    let predators = Predators()
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        // Dinosaur image
                        Image("\(predator.image)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .bold()
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    }, label: {
                        Image(systemName: alphabetical ? "film" :"textformat.size")
                            .symbolEffect(.bounce, value: alphabetical)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection) {
                            ForEach(PredatorType.allCases) { predatorType in
                                Label(
                                    title: { Text(predatorType.rawValue.capitalized) },
                                    icon: { Image(systemName: predatorType.icon) }
                                )
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }

                }
            }
            .animation(.default, value: currentSelection)
            .foregroundStyle(.white)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
