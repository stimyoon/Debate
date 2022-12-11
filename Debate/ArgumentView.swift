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
    
    @State private var text: String = ""
    @State private var category: Category = .neutral
    
    var body: some View {
        TextField("Argument", text: $text)
            .onAppear{
                text = argument.text
                category = argument.category
            }
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                argument.text = text
                argument.category = category
                vm.saveAll()
            }
        
    }
}
