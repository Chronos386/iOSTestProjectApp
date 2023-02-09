//
//  ContentView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 30.09.2022.
//

//Для подбора цвета
//var someColor = #colorLiteral(red: 0.4030735216, green: 0.8965372886, blue: 0.2284442718, alpha: 1)
import SwiftUI

struct ContentView: View {
    @State private var selectedView = 1
    @State private var log = UserDefaults.standard.integer(forKey: "LoginOrNo")
    var body: some View {
        if (log == 1) {
            TabView(selection: $selectedView) {
                NahidaView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        Text("Nahida")
                    }.tag(1)
                gradientView(log: $log)
                    .tabItem {
                        Image(systemName: "doc.text.image.fill")
                        Text("List Archon")
                    }.tag(2)
                GameView()
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                        Text("Nahida game")
                    }.tag(3)
                ApiView()
                    .tabItem {
                        Image(systemName: "tray.full.fill")
                        Text("Posts")
                    }.tag(4)
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Dev home")
                    }.tag(5)
            }
        }
        else {
            LoginView(log: $log)
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
