//
//  ArgumentView.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import SwiftUI
struct ArgumentView: View {
    @ObservedObject var argument: Argument
    @EnvironmentObject var vm: TopicListVM
    @State private var isEditing = false
    
    var body: some View {
        if isEditing {
            VStack{
                HStack{
                    Spacer()
                    Button {
                        vm.saveAll()
                        isEditing = false
                    } label: {
                        Text("Save")
                    }
                }
                TextField("Argument", text: $argument.text, axis: .vertical)
    
                    .background(RoundedRectangle(cornerRadius: 10).fill(.regularMaterial))
                    .onSubmit {
                        vm.saveAll()
                    }
                
            }
        }else{
            Text("\(argument.text)")
                .onTapGesture {
                    isEditing = true
                }
        }
    }
}
