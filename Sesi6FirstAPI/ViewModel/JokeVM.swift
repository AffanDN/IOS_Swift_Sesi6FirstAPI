//
//  JokeVM.swift
//  Sesi6FirstAPI
//
//  Created by Macbook Pro on 19/04/24.
//

import Foundation

// waktu dijalankan ke simulator mendapat warning
// membalikan proses yang terjadi dibalik layar segera ke tampilan UI
@MainActor
class JokeVM: ObservableObject {
    @Published var joke: Joke?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchJoke() async {
        isLoading = true
        errorMessage = nil
        
        do {
            joke = try await APIService.shared.fetchJokeService()
            print("Setup: \(joke?.setup ?? "No Setup")")
            print("Punchline: \(joke?.punchline ?? "No Punchline")")
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            print("ERROR: Could not get data from UR: \(Constants.jokeAPI).\(error.localizedDescription)")
        }
    }
}
