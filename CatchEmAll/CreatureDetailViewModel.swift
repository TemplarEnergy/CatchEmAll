//
//  CreatureDetailViewModel.swift
//  CatchEmAll
//
//  Created by Thomas Radford on 31/01/2023.
//

import Foundation

@MainActor
class CreatureDetailViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
        
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other:  Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys:String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""
    
    
    var urlString = ""
    
    
    func getData() async {
        
     
        print("   🕸 We are accessing the url \(urlString)")
        // Create a URL
        
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print ("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
        // Try to decode  JSON data into our own data structures
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 ERROR: Could not decode returned JSON data")
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.other.officialArtwork.front_default ??  ""
            
        } catch {
            print("😡 ERROR: could not use URL at \(urlString) to get data and response")
        }
    }
}
