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
    
    var body: some View {
        TextField("Argument", text: $argument.text)
            .onSubmit {
                vm.saveAll()
            }
        
    }
}
