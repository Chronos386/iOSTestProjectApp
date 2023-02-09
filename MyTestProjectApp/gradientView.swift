//
//  gradientView.swift
//  MyTestProjectApp
//
//  Created by Nikita Marton on 03.10.2022.
//

import SwiftUI

struct Archon: Identifiable {
    var id = UUID()
    var name: String
    var specName: String
    var age: Int
    var element: String
}

struct ArchonRow: View {
    var archon: Archon
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Имя: \(archon.name)")
                Text("Особое имя: \(archon.specName)")
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Возраст: \(archon.age)")
                Text("Элемент: \(archon.element)")
            }
        }
    }
}

struct gradientView: View {
    @Binding var log: Int
    var archonts = [Archon(name: "Nahida", specName: "Lesser Lord Kusanali", age: 500, element: "Dendro"), Archon(name: "Zhongli", specName: "Morax", age: 6500, element: "Geo"), Archon(name: "Venti", specName: "Barbatos", age: 2600, element: "Anemo"), Archon(name: "Ei", specName: "Beelzebul", age: 2000, element: "Electro")]
    @State var archonts2 = [Archon(name: "Nahida", specName: "Lesser Lord Kusanali", age: 500, element: "Dendro"), Archon(name: "Zhongli", specName: "Morax", age: 6500, element: "Geo"), Archon(name: "Venti", specName: "Barbatos", age: 2600, element: "Anemo"), Archon(name: "Ei", specName: "Beelzebul", age: 2000, element: "Electro")]
    let myGradient = RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 70, endRadius: 15)
    let myGradient2 = AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center)
    let myGradient3 = LinearGradient(gradient: Gradient(colors: [.green, .yellow, .green]), startPoint: .top, endPoint: .bottom)
    @ObservedObject var textHello = User()
    
    @State var gradientsName = ["Gradient 1", "Gradient 2", "Gradient 3"]
    @State var selectedGrad = 0
    @State var hideSmth = false
    @State var showAlers = false
    @State var showAlers2 = false
    @State var showAlers3 = false
    @State var showTable = false
    var body: some View {
        NavigationView {
            VStack() {
                Form {
                    Picker(selection: $selectedGrad, label: Text("Выберите градиент")) {
                        ForEach(0..<gradientsName.count) {
                            Text(self.gradientsName[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Toggle(isOn: $hideSmth) {
                        if !hideSmth {
                            Text("Показать список")
                        }
                        else {
                            Text("Скрыть список")
                        }
                    }
                    Button("Вернуть в исходное положение") {
                        archonts2 = archonts
                        selectedGrad = 0
                    }.disabled(!hideSmth)
                    Button("Покажи окно") {
                        self.showAlers.toggle()
                    }.sheet(isPresented: $showAlers) {
                        ObjectsView(user: self.textHello)
                    }/*.alert(isPresented: $showAlers) {
                        Alert(title: Text("Hello, Nahida lover"),
                              message: Text("Nahida is very very very cute! You agree?"), dismissButton: .default(Text("Ok")))
                    }*/
                    Button("Удаляем что-то") {
                        self.showAlers2 = true
                    }.alert(isPresented: $showAlers2) {
                        Alert(title: Text("You want delete Nahida???"),
                              message: Text("It's a crime!!!"), primaryButton: .destructive(Text("Delete")) {
                            print("lol")
                        }, secondaryButton: .cancel())
                    }
                    Button("Таблица действий") {
                        self.showTable = true
                    }.actionSheet(isPresented: $showTable) {
                        ActionSheet(title: Text("Nahida Actions"),
                                    message: Text("It's Nahida's actions!!!"), buttons: [.default(Text("Walk")), .default(Text("Play")), .cancel(), .destructive(Text("Удалить всё живое"))])
                    }
                }
                NavigationLink(destination: ObjectsView(user: self.textHello)) {
                    let textNahidaHello = Text("Hello \(textHello.fullName.firstName) \(textHello.fullName.lastName)")
                        .padding()
                        .bold()
                        .foregroundColor(.white)
                    switch(selectedGrad) {
                    case 0:
                        textNahidaHello.background(myGradient)
                    case 1:
                        textNahidaHello.background(myGradient2)
                    case 2:
                        textNahidaHello.background(myGradient3)
                    default:
                        textNahidaHello.background(Color.blue)
                    }
                }
                /*let nahidaImg = Image("flushed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                if hideSmth {
                    nahidaImg.accessibilityShowsLargeContentViewer()
                }
                else {
                    nahidaImg.hidden()
                }*/
                let lisArchons = List {
                    ForEach(archonts2) { archont in
                        ArchonRow(archon: archont)
                    }.onDelete(perform: deleteArchon)
                        .onMove(perform: moveArchon)
                }.listStyle(GroupedListStyle())
                
                if hideSmth {
                    lisArchons.accessibilityShowsLargeContentViewer()
                    .navigationBarItems(trailing: EditButton())
                }
                else {
                    lisArchons.hidden()
                }
            }
            .navigationBarTitle("Тестовое окно")
            .navigationBarItems(trailing: Button("Выйти") {
                self.showAlers3 = true
            }.alert(isPresented: $showAlers3) {
                Alert(title: Text("Вы уверены?"),
                      message: Text("Вы точно хотите выйти из аккаунта?"), primaryButton: .destructive(Text("Выйти")) {
                    UserDefaults.standard.set(0, forKey: "LoginOrNo")
                    log = 0
                }, secondaryButton: .cancel())
            })
                /*List {
                    Section(header: Text("Music")) {
                        ArchonRow(archon: archonts[0])
                        ArchonRow(archon: archonts[2])
                    }
                    Section(header: Text("Non music")) {
                        ArchonRow(archon: archonts[1])
                        ArchonRow(archon: archonts[3])
                    }.listRowBackground(Color.blue)
                }.listStyle(GroupedListStyle())*/
        }
    }
    
    func deleteArchon(at offsets: IndexSet) {
        archonts2.remove(atOffsets: offsets)
    }
    
    func moveArchon(from source: IndexSet, to destination: Int) {
        archonts2.move(fromOffsets: source, toOffset: destination)
    }
}

struct secondView_Previews: PreviewProvider {
    static var previews: some View {
        //gradientView()
        Text("")
    }
}
