//
//  ContentView.swift
//  Sesi6FirstAPI
//
//  Created by Hidayat Abisena on 28/01/24.
//

import SwiftUI

struct CardView: View {
    @State private var fadeIn: Bool = false
    @State private var moveDownward: Bool = false
    @State private var moveUpward: Bool = false
    
    @State private var showPunchline: Bool = false
    
    @State private var soundNumber = 7
    @State private var hiddenPunchline: Bool = false
    
    @StateObject private var jokeVM = JokeVM()
    
    let totalSounds = 25
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text(Constants.setupText)
                        .foregroundStyle(.white)
                        .font(.custom("PermanentMarker-Regular", size: 30))
                        .padding(.horizontal)
                    
                    Text(jokeVM.joke?.setup ?? Constants.noJokes)
                        .foregroundStyle(.white)
                        .fontWeight(.light)
                        .italic()
                }
                .offset(y: moveDownward ? -218 : -300)
                if showPunchline {
                    Text(jokeVM.joke?.punchline ?? Constants.noJokes)
                        .foregroundStyle(.white)
                        .font(.custom("PermanentMarker-Regular", size: 35))
                        .multilineTextAlignment(.center)
                }
                
                // MARK: - BUTTON PUNCHLINE

                Button {
                    if hiddenPunchline == false {
                        performPunchlineAction()
                        hiddenPunchline = true
                    }
                    
                } label: {
                    HStack {
                        if !showPunchline {
                            Text("Punchline".uppercased())
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                        } else {
                            Text("Click".uppercased())
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                        }
                        if !showPunchline {
                            Image(systemName: "arrow.right.circle")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 24)
                    .background( !showPunchline ?
                                 LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.primary, .mint]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color("ColorShadow"), radius: 6, x: 0, y: 3)
                }
                .offset(y: moveUpward ? 210 : 300)
                .disabled(showPunchline)
                
            }
            .task {
                await jokeVM.fetchJoke()
            }
            // MARK: - REFRESH SETUP

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await jokeVM.fetchJoke()
                            showPunchline.toggle()
                            hiddenPunchline = false
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            )
                            .clipShape(Circle())
                    }
                }
            }
            .frame(width: 335, height: 545)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .top, endPoint: .bottom)
            )
            .opacity(fadeIn ? 1.0 : 0.0)
            .onAppear() {
              withAnimation(.linear(duration: 1.2)) {
                self.fadeIn.toggle()
              }
                
              withAnimation(.linear(duration: 0.6)) {
                self.moveDownward.toggle()
                self.moveUpward.toggle()
              }
            }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    CardView()
}

extension CardView {
    func performPunchlineAction() {
        playSound(soundName: "\(soundNumber)")
        soundNumber += 1
        if soundNumber > totalSounds {
            soundNumber = 0
        }
        showPunchline.toggle()
    }
 }
