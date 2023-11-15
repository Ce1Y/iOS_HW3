//
//  tool.swift
//  iOS_HW3
//
//  Created by user06 on 2023/11/15.
//

import PhotosUI
import SwiftUI

struct tool: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhoto2: PhotosPickerItem?
    @State private var selectedPhoto3: [PhotosPickerItem] = []
    @State private var image: Image?
    @State private var image2: Image?
    @State private var image3: Image?
    @State private var commentTime = Date()
    @State private var description = ""
    let roles = ["0", "1", "2", "3"]
    @State private var selectedIndex = 0
    @State private var scale = 0.0
    @State private var isEnabled = false
    @State private var value = 26
    var number = Int.random(in: 0...2)
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State var color: Color = Color.red
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    ZStack {
                        image?
                            .resizable()
                            .scaledToFit()
                    }.toolbar {
                        PhotosPicker(
                            selection: $selectedPhoto,
                            // limit the type of selected photos
                            matching: .images
                        ) {
                            Image(systemName: "pencil")
                        }
                    }
                    .task(id: selectedPhoto) {
                        image = try? await selectedPhoto?.loadTransferable(type: Image.self)
                    }
                    ZStack {
                        image2?
                            .resizable()
                            .scaledToFit()
                    }.toolbar {
                        PhotosPicker(
                            selection: $selectedPhoto2,
                            matching: .all(of: [.screenshots, .panoramas])
                        ) {
                            Image(systemName: "heart.fill")
                        }
                    }
                    .task(id: selectedPhoto2) {
                        if selectedPhoto2?.supportedContentTypes.first == .image {
                            image = try? await selectedPhoto2?.loadTransferable(type: Image.self)
                        }
                    }
                    ZStack {
                        image3?
                            .resizable()
                            .scaledToFit()
                    }.toolbar {
                        PhotosPicker(selection: $selectedPhoto3, maxSelectionCount: 3) {
                            Image(systemName: "house")
                        }
                    }
                }
                HStack {
                    Text("註解時間:")
                    DatePicker("註解時間:", selection: $commentTime, displayedComponents: .date)
                        .labelsHidden()
                }
                HStack {
                    Text("描述")
                        .frame(width: 100)
                    Form {
                        Section {
                            TextField("描述", text: $description)
                        } header: {
                            Text("Description")
                        }
                    }
                }
                .frame(height: 100)
                VStack {
                    Text(roles[selectedIndex])
                    Picker("選擇角色：", selection: $selectedIndex) {
                        ForEach(roles, id: \.self) { role in
                            Text(role)
                        }
                    }
                }
                VStack {
                    Slider(value: $scale, in: 0...1)
                }
                .padding()
                Toggle(isOn: $isEnabled) {
                    Text("Airplane mode")
                        .font(.system(.title, design: .rounded))
                        .bold()
                }
                .padding()
                VStack {
                    Text("Current value: \(value)")
                    Stepper("What's your age?", value: $value)
                }
                .padding()
                Button {
                    showAlert = true
                    alertTitle = ["愛", "不愛"].randomElement()!
                } label: {
                    VStack {
                        Text("你還愛我嗎")
                    }
                }
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK") {}
                    Button("Cancel", role: .cancel) { }
                    Button("Destructive", role: .destructive) { }
                } message: {
                    Text("")
                }
                HStack {
                    ColorPicker(
                        "Color",
                        selection: $color
                    )
                }
                .padding()
                
            }
        }
    }
}


#Preview {
    tool()
}
