//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Thomas Radford on 31/01/2023.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?  // This needs to be an optional to handle last page
        var results: [Creature]
    }
    
    @Published var count = 0
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var creaturesArray: [Creature] = []
    @Published var isLoading = false
    
    func getData() async {
        print("   🕸 We are accessing the url \(urlString)")
        isLoading = true
        // Create a URL
        
        // convert urlString to a specialk URL type
        guard let url = URL(string: urlString) else {
            print ("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
        // Try to decode  JSON data into our own data structures
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                
                print("😡 ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.creaturesArray += returned.results
            isLoading = false
        } catch {
            print("😡 ERROR: could not use URL at \(urlString) to get data and response")
            isLoading = false
        }
    }
    
    func loadNextifNeeded(creature: Creature)  async {
        guard let lastCreature = creaturesArray.last else {
            return
        }
        if creature.id == lastCreature.id && urlString.hasPrefix("http"){
            Task {
                await getData()
            }
            
        }
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else {return}
        
        await getData()  // get mext [age pf data
        await loadAll()  // call loadAll recursively
    }
}
