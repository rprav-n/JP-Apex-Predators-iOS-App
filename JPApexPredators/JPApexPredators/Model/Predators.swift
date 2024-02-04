//
//  Predators.swift
//  JPApexPredators
//
//  Created by Praveen R on 04/02/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    var originalPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                originalPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = originalPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        }
        return apexPredators.filter { predator in
            predator.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predatorOne, predatorTwo in
            if alphabetical {
                return predatorOne.name < predatorTwo.name
            }
            return predatorOne.id < predatorTwo.id
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = originalPredators
        } else {
           apexPredators = originalPredators.filter { predator in
                return predator.type == type
            }
        }
    }
}
