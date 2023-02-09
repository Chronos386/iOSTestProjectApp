//
//  ObjectsView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 10.10.2022.
//

import SwiftUI

struct UserSaved: Codable {
    var firstName: String
    var lastName: String
}

class User: ObservableObject {
    @Published var fullName: UserSaved = UserSaved(firstName: "", lastName: ""){
        didSet {
            let encoder = JSONEncoder()
            if let encodet = try? encoder.encode(fullName) {
                UserDefaults.standard.set(encodet, forKey: "UserData")
            }
        }
    }
    init() {
        if let fullName = UserDefaults.standard.data(forKey: "UserData") {
            let decoder = JSONDecoder()
            if let decodet = try? decoder.decode(UserSaved.self, from: fullName) {
                self.fullName = decodet
                return
            }
        }
    }
}

struct ObjectsView: View {
    @ObservedObject var user: User
    @State private var showAlers = false
    @State private var firstName = ""
    @State private var lastName = ""
    @Environment(\.presentationMode) var presMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(firstName) \(lastName)")
                TextField("First name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Last name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Сохранить изменения") {
                    self.showAlers = true
                    user.fullName = UserSaved(firstName: firstName, lastName: lastName)
                }.customB().alert(isPresented: $showAlers) {
                    Alert(title: Text("Hello, Nahida lover"),
                          message: Text("Изменения сохранены"), dismissButton: .default(Text("Ok")))
                }
            }
            .padding()
            .navigationBarItems(trailing: Button("Back") {
                self.presMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ObjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectsView(user: User())
    }
}
