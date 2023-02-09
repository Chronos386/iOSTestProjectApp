//
//  LoginView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 12.10.2022.
//

import SwiftUI

struct MailPasswSaved: Codable {
    var email: String
    var password: String
}

class MailPassw: ObservableObject {
    @Published var data: MailPasswSaved = MailPasswSaved(email: "", password: ""){
        didSet {
            let encoder = JSONEncoder()
            if let encodet = try? encoder.encode(data) {
                UserDefaults.standard.set(encodet, forKey: "EmailPassData")
            }
        }
    }
    init() {
        if let fullName = UserDefaults.standard.data(forKey: "EmailPassData") {
            let decoder = JSONDecoder()
            if let decodet = try? decoder.decode(MailPasswSaved.self, from: fullName) {
                self.data = decodet
                return
            }
        }
    }
}

struct LoginView: View {
    var someColor = #colorLiteral(red: 0.03171011452, green: 0.07072153724, blue: 0.08265544459, alpha: 1)
    var lineColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    @Binding var log: Int
    @State var mailPassw = MailPassw()
    @State private var indexView = 0
    var body: some View {
        GeometryReader { _ in
            VStack {
                Image("dendroLogo")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                ZStack {
                    if (self.indexView == 0) {
                        Login(indexView: self.$indexView, log: $log, mailPassw: mailPassw)
                    }
                    else {
                        SignUp(indexView: self.$indexView, log: $log, mailPassw: mailPassw)
                    }
                }
                
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color(lineColor))
                        .frame(height: 1)
                    Text("OR")
                        .lineLimit(1)
                    Rectangle()
                        .fill(Color(lineColor))
                        .frame(height: 1)
                        
                }.padding(.top, 30)
                
                HStack(spacing: 25) {
                    Button(action: {}) {
                        Image("appleLogo")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Image("vkLogo")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Image("twitterLogo")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }.padding(.top, 30)
            }.padding()
        }.background(Color(someColor))
            .preferredColorScheme(.dark)
    }
}


struct Login: View {
    @State var email = ""
    @State var password = ""
    @Binding var indexView: Int
    var lineColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var backColor = #colorLiteral(red: 0.1438688136, green: 0.2767245565, blue: 0.6344322028, alpha: 1)
    @Binding var log: Int
    @State private var error = ""
    @State private var showAlers = false
    @ObservedObject var mailPassw: MailPassw
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("Вход")
                            .foregroundColor(self.indexView == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(self.indexView == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer()
                }.padding(.top, 30)
                
                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color(lineColor))
                        TextField("Почта", text: self.$email)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 40)
                
                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color(lineColor))
                        SecureField("Пароль", text: self.$password)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 20)
                
                HStack {
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Text("Забыли пароль?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }.padding(.horizontal)
                    .padding(.top, 20)
                HStack {
                    Spacer(minLength: 0)
                    Button(action: {
                        indexView = 1
                    }) {
                        Text("Зарегестрироваться")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }.padding(.horizontal)
                    .padding(.top, 5)
            }.padding()
                .padding(.bottom, 30)
                .background(Color(backColor))
                .clipShape(CShape())
                .contentShape(CShape())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .cornerRadius(35)
                .padding(.horizontal, 20)
            
            Button(action: {
                if (email != "") {
                    if (password != "") {
                        if(mailPassw.data.email == email && mailPassw.data.password == password) {
                            UserDefaults.standard.set(1, forKey: "LoginOrNo")
                            log = 1
                        }
                        else {
                            self.showAlers = true
                            error = "Неверный пароль или почта"
                        }
                    }
                    else {
                        self.showAlers = true
                        error = "Введите пароль"
                    }
                }
                else {
                    self.showAlers = true
                    error = "Введите почту"
                }
            }) {
                Text("Войти")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color(lineColor))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }.offset(y: 35)
                .opacity(self.indexView == 0 ? 1 : 0)
                .alert(isPresented: $showAlers) {
                    Alert(title: Text("Ошибка"),
                          message: Text(error), dismissButton: .default(Text("Ok")))
                }
        }
    }
}



struct SignUp: View {
    @State var email = ""
    @State var password = ""
    @State var passwordTwo = ""
    @Binding var indexView: Int
    var lineColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var backColor = #colorLiteral(red: 0.1438688136, green: 0.2767245565, blue: 0.6344322028, alpha: 1)
    @Binding var log: Int
    @State private var error = ""
    @State private var showAlers = false
    @ObservedObject var mailPassw: MailPassw
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 10) {
                        Text("Регистрация")
                            .foregroundColor(self.indexView == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(self.indexView == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                }.padding(.top, 30)
                
                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color(lineColor))
                        TextField("Почта", text: self.$email)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 40)
                
                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color(lineColor))
                        SecureField("Пароль", text: self.$password)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 20)
                
                VStack {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color(lineColor))
                        SecureField("Пароль", text: self.$passwordTwo)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 20)
                
                HStack {
                    Spacer(minLength: 0)
                    Button(action: {
                        indexView = 0
                    }) {
                        Text("Войти")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }.padding(.horizontal)
                    .padding(.top, 20)
            }.padding()
                .padding(.bottom, 30)
                .background(Color(backColor))
                .clipShape(CShape2())
                .contentShape(CShape2())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .cornerRadius(35)
            
            Button(action: {
                if (email != "") {
                    if (password != "" && passwordTwo != "") {
                        if(password == passwordTwo) {
                            UserDefaults.standard.set(1, forKey: "LoginOrNo")
                            log = 1
                            mailPassw.data = MailPasswSaved(email: email, password: password)
                            UserDefaults.standard.set(0, forKey: "score")
                            var user = User()
                            user.fullName = UserSaved(firstName: "", lastName: "")
                        }
                        else {
                            self.showAlers = true
                            error = "Пароли должны совпадать"
                        }
                    }
                    else {
                        self.showAlers = true
                        error = "Введите пароли"
                    }
                }
                else {
                    self.showAlers = true
                    error = "Введите почту"
                }
            }) {
                Text("Зарегестрироваться")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color(lineColor))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }.offset(y: 25)
                .opacity(self.indexView == 1 ? 1 : 0)
                .alert(isPresented: $showAlers) {
                    Alert(title: Text("Ошибка"),
                          message: Text(error), dismissButton: .default(Text("Ok")))
                }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        //LoginView(log: $log)
        Text("")
    }
}
