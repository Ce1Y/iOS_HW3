//
//  ResultView.swift
//  iOS_HW3
//
//  Created by user06 on 2023/11/15.
//

import SwiftUI

struct ResultView: View {
    @Binding var avatar: Image?
    @Binding var lastName: String
    @Binding var firstName: String
    @Binding var gender: String
    @Binding var height: Double
    @Binding var bornDate: Date
    @Binding var bgColor: Color
    
    var body: some View {
        HStack {
            if avatar == Image("") {
                Image("figure.stand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            } else {
                avatar?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .clipShape(Circle())
                    .background(
                        Circle()
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .padding(0)
            }
            List {
                Section {
                    Text("姓名：\(lastName)\(firstName)")
                    Text("性別：\(gender)")
                    Text("生日：\(bornDate.formatted(.dateTime.month().day()))")
                    Text("身高：\(height, specifier: "%.1f")")
                }
                .listRowSeparator(.hidden)
            }
            .frame(height: 250)
            .scrollContentBackground(.hidden)
        }
        .background(
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .fill(bgColor)
                .cornerRadius(10.0)
        )
    }
}

#Preview {
    ResultView(avatar: .constant(Image("")), lastName: .constant(""), firstName: .constant(""), gender: .constant(""), height: .constant(0.0), bornDate: .constant(Date()), bgColor: .constant(Color(Color.red)))
}
