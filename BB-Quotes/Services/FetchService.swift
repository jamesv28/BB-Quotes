//
//  FetchService.swift
//  BB-Quotes
//
//  Created by James Volmert on 10/8/24.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case BadResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // "https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad"
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteUrl = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteUrl.appending(queryItems:   [URLQueryItem(name: "production", value: show)])
        
        // data is the actual body, response is the url code "200", "404"
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.BadResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        
        let characterUrl = baseURL.appending(path: "characters")
        let fetchURL = characterUrl.appending(queryItems:   [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.BadResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeaths(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.BadResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        
        let episodeUrl = baseURL.appending(path: "episodes")
        let fetchURL = episodeUrl.appending(queryItems:   [URLQueryItem(name: "production", value: show)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.BadResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}
