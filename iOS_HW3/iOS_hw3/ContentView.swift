//
//  ContentView.swift
//  iOS_HW3
//
//  Created by user06 on 2023/10/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    private var sex = ["", "男", "女", "雙性", "無性", "直升機"]
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var gender = ""
    @State private var sexIndex = 10
    @State private var height = 0.0
    @State private var isExpanded = false
    @State private var bornDate = Date()
    @State private var showResult = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var showResultView = false
    @State private var color: Color = Color.red
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("姓", text: $lastName)
                    TextField("名", text: $firstName)
                } header: {
                    Text("姓名")
                }
                
                Section {
                    DisclosureGroup("身高：\(height, specifier: "%.1f")", isExpanded: $isExpanded) {
                        HStack {
                            Slider(value:$height, in: 0...210, step: 0.1)
                            Stepper("微調身高", value: $height, in:0...210, step: 0.1)
                                .labelsHidden()
                        }
                    }
                    Picker("選擇性別：\(gender)", selection: $sexIndex) {
                        ForEach(sex.indices, id: \.self) { index in
                            Text(sex[index])
                        }
                    }
                    .onChange(of: sexIndex) { gender = sex[sexIndex] }
                    DatePicker("生日：\(bornDate.formatted(.dateTime.month().day()))", selection: $bornDate, displayedComponents: .date)
                } header: {
                    Text("基本信息")
                }

                Section {
                    HStack(alignment: .center) {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                } header: {
                    HStack {
                        Text("大頭貼")
                        PhotosPicker(
                            selection: $selectedPhoto,
                            // limit the type of selected photos
                            matching: .images
                        ) {
                            Image(systemName: "pencil")
                        }.task(id: selectedPhoto) {
                            image = try? await selectedPhoto?.loadTransferable(type: Image.self)
                        }
                    }
                }
                
                Section {
                    VStack {
                        
                    }
                    .listRowBackground(color)
                } header: {
                    HStack {
                        Text("背景顏色")
                        ColorPicker(
                            "",
                            selection: $color
                        ).labelsHidden()
                    }
                }
                
                Section {
                    Button {
                        let judge = Judge(lastName: $lastName, firstName: $firstName, gender: $gender, height: $height, bornDate: $bornDate)
                        if (!judge.judge()) {
                            showResult = true
                            alertTitle = ["有缺少的資料喔！", "再回去檢查一下吧？"].randomElement()!
                        } else { showResultView = true }
                    } label: {
                        VStack {
                            Text("查看結果")
                        }
                    }
                    .sheet(isPresented: $showResultView) {
                        ResultView(avatar: $image, lastName: $lastName, firstName: $firstName, gender: $gender, height: $height, bornDate: $bornDate, bgColor: $color)
                    }
                    .alert(alertTitle, isPresented: $showResult) {
                        Button("OK") {}
                    }
                }
                
                Section {
                    Button("Reset All Content and Settings") {
                        showAlert = true
                    }
                    .alert("確定重製嗎？", isPresented: $showAlert) {
                        Button("確認") {
                            lastName = ""
                            firstName = ""
                            gender = ""
                            sexIndex = 0
                            height = 0.0
                            isExpanded = false
                            bornDate = Date()
                        }
                        Button("取消", role: .cancel) {}
                    }
                }
            }
            .navigationTitle("表單")
        }
    }
}

struct Judge {
    @Binding var lastName: String
    @Binding var firstName: String
    @Binding var gender: String
    @Binding var height: Double
    @Binding var bornDate: Date
    
    func judge() -> Bool {
        if lastName == "" {
            return false
        }
        if firstName == "" {
            return false
        }
        if gender == "" {
            return false
        }
        if height == 0.0 {
            return false
        }
        return true
    }
}

#Preview {
    ContentView()
}
