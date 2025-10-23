//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by needsomevibe on 22/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var questionNumber = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black, .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                        
                    }
                }
                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            

        } message: {
            Text("Question: \(questionNumber)/8 \nYour score is \(score)")
            
        }
    }
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
            }
            
            showingScore = true
        }
    
        func askQuestion() {
            questionNumber += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
        }
        func restart() {
            score = 0
            questionNumber = 0
            askQuestion()
    }
    func getResults(_ number: Int) {
        if questionNumber > 9 {
            scoreTitle = "Game Over"
            showingScore = true
        }
    }
    
    }
    
        
#Preview {
        ContentView()
}

