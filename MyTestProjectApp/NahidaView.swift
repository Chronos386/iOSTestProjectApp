//
//  NahidaView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 04.10.2022.
//

import SwiftUI

struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(nil)
            //Расстояние между символами (тут с доп пробелом в конце)
            //.kerning(5)
            //А тут то же самое, но без пробела
            .tracking(5)
            .truncationMode(.middle)
            .multilineTextAlignment(.center)
        //Расстояние между строками
            .lineSpacing(5)
    }
}

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .bold()
            .lineLimit(1)
            .padding(10)
            .background(Rectangle()
                .fill(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10)))
            .padding(3)
    }
}

extension View {
    func customM() -> some View {
        self.modifier(CustomModifier())
    }
    func customB() -> some View {
        self.modifier(CustomButton())
    }
}

struct NahidaView: View {
    @State private var showNSFW = false
    @State private var showSmth = false
    @State private var archonName = ""
    @State private var specArchName = ""
    @State private var yearus: Double = 0
    @State private var selectedElement = 0
    
    private let elements = ["Pyro", "Geo", "Dendro", "Cryo", "Electro", "Anemo", "Hydro"]
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Toggle(isOn: $showNSFW.animation()) {
                    if showNSFW {
                        Text("Скрыть архонта")
                    }
                    else {
                        Text("Показать архонта")
                    }
                }
                let nahidaImg = Image("drooling")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .contextMenu {
                        VStack {
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "doc.on.doc")
                                    Text("Копировать")
                                }
                            }
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Поделиться")
                                }
                            }
                        }
                    }
                /*let susTxt = Text("Nahida is SUS")
                    .font(.largeTitle)
                    .bold()
                    .padding(5)
                    .background(Color(#colorLiteral(red: 0.2113984534, green: 0.5200697706, blue: 0.209939931, alpha: 1)))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))*/
                if showNSFW {
                    nahidaImg.accessibilityShowsLargeContentViewer()
                    //susTxt.accessibilityShowsLargeContentViewer()
                }
                else {
                    nahidaImg.hidden()
                    //susTxt.hidden()
                }
                Text("My archon is very small and very cute.")
                    .customM()
                Spacer()
                TextField("Введи имя архонта", text: $archonName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Введи \"особое\" имя архонта", text: $specArchName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Slider(value: $yearus, in: 0...1500, step: 1)
                Stepper("Возраст архонта", value: $yearus, in: 0...1500)
            }
            VStack (alignment: .leading) {
                Text("Archon age: \(Int(yearus))")
                Text("Archon element: \(elements[selectedElement])")
            }
            HStack {
                Picker(selection: $selectedElement, label: Text("Выбери элемент")) {
                    ForEach(0..<elements.count) {
                        Text(self.elements[$0])
                            .foregroundColor(.blue)
                    }
                }
                Button("My archon!!!") {
                    self.showSmth.toggle()
                }.foregroundColor(.black)
                    .bold()
                    .lineLimit(1)
                    .padding(10)
                    .background(
                        Rectangle()
                            .fill(showSmth ? Color.red : Color.green)
                            .animation(.spring(), value: showSmth)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                if showSmth {
                    Spacer()
                    Text("Тут будем переходить на другое окно")
                        .padding(.leading, 5)
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

struct NahidaView_Previews: PreviewProvider {
    static var previews: some View {
        NahidaView()
    }
}
