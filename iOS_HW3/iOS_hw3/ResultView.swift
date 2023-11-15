//
//  ResultView.swift
//  iOS_HW3
//
//  Created by user06 on 2023/11/15.
//

import SwiftUI

struct ResultView: View {
    @Binding var lastName: String
    @Binding var firstName: String
    @Binding var gender: String
    @Binding var height: Double
    @Binding var bornDate: Date
    @Binding var bgColor: Color
    
    var body: some View {
        HStack {
            Image("")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            List {
                Section {
                    Text("姓名：\(lastName)\(firstName)")
                    Text("性別：\(gender)")
                    Text("年齡：")
                    Text("生日：\(bornDate.formatted(.dateTime.month().day()))")
                    Text("身高：\(height, specifier: "%.1f")")
                }
                .listRowSeparator(.hidden)
            }
            .frame(width: 200, height: 300)
            .scrollContentBackground(.hidden)
            
            
        }
    }
}

#Preview {
    ResultView(lastName: .constant(""), firstName: .constant(""), gender: .constant(""), height: .constant(0.0), bornDate: .constant(Date()), bgColor: .constant(Color(Color.red)))
}
