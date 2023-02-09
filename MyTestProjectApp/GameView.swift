//
//  GameView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 06.10.2022.
//

import SwiftUI

struct nahidaName {
    let imgName: String
    let userName: String
}

struct GameView: View {
    @State private var nahidaNames = [nahidaName(imgName: "angry", userName: "Злая"), nahidaName(imgName: "drooling", userName: "Слюнявая"), nahidaName(imgName: "embarrassed", userName: "Смущённая"), nahidaName(imgName: "flushed", userName: "Покрасневшая"), nahidaName(imgName: "indignant", userName: "Возмущённая"), nahidaName(imgName: "justCute", userName: "Просто милая"), nahidaName(imgName: "neko", userName: "Неко"), nahidaName(imgName: "onionGod", userName: "Луковы Бог"), nahidaName(imgName: "underdeveloped", userName: "Недоразвитая"), nahidaName(imgName: "withButterfly", userName: "С бабочкой")].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = UserDefaults.standard.integer(forKey: "score")
    @State private var showScore = false
    @State private var alertTitle = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .yellow, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.top)
            VStack(spacing: 10) {
                VStack(alignment: .center) {
                    Text("Выбери Нахиду")
                        .bold()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text(nahidaNames[correctAnswer].userName)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        nahidaPressed(number)
                        showScore = true
                    }) {
                        Image(self.nahidaNames[number].imgName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius:10))
                            .shadow(color: .black, radius: 3)
                            .padding(5)
                    }
                }
                Text("Общий счёт: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                Spacer()
            }
        }.alert(isPresented: $showScore) {
            Alert(title: Text(alertTitle), message: Text("Общий счёт: \(score)"), dismissButton: .default(Text("Ok")) {
                UserDefaults.standard.set(score, forKey: "score")
                nextRound()
            })
        }
    }
    
    func nextRound() {
        nahidaNames.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func nahidaPressed(_ numb: Int) {
        if numb == correctAnswer {
            score += 1
            alertTitle = "Ответ верный!"
        }
        else {
            score -= 1
            alertTitle = "Ответ неверный! Верный ответ это Нахида №\(correctAnswer + 1)"
        }
    }
}




struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
