//
//  APIService.swift
//  Sesi6FirstAPI
//
//  Created by Macbook Pro on 19/04/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    // diproteksi agar tidak di recreate
    private init() {}
    
    func fetchJokeService() async throws -> Joke {
        let urlString = URL(string: Constants.jokeAPI)
        guard let url = urlString else {
            print("😡 ERROR: Could not convert \(String(describing: urlString)) to URL")
            throw URLError(.badURL)
        }
        print("🕸️ We are accessing the url \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let joke = try JSONDecoder().decode(Joke.self, from: data)
        return joke
    }
}

// Kenapa pakai class ?
// 1. Untuk memastikan bahwa hanya ada satu objek (Instance) bersama (Shared)
// yang akan digunakan di seluruh aplikasi, Konsep ini disebut sebagai Singleton

//2. Jadi nanti setiap ada perubahan State di bagian lain dari aplikasi kita,
// state nya akan sama. Seperti konspe mobil yang diubah warna tadi

// 3. Cara pemanggilannya, APIService.shared
// 4. Cara mencegah agar si objek APIService tidak direcreate diluar kelas ini
