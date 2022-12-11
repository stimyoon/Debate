//
//  ArgumentListView.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import SwiftUI

struct ArgumentListView: View {
    @ObservedObject var topic: Topic
    let title: String
    let filterCategory: Category
    
    @State private var text = ""
    @EnvironmentObject var vm: TopicListVM
    @EnvironmentObject var argVM: ArgumentListVM // Needed to update arguments live
    
    private var arguments: [Argument] {
        (topic.arguments?.allObjects as! [Argument])
            .sorted(by: {$0.listorder < $1.listorder})
            .filter { $0.category == filterCategory }
    }
    
    var body: some View {
        VStack{
            Text(title)
            TextField("Argument", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 4)
                .onSubmit {
                    let argument = vm.createArgument(text: text, category: filterCategory)
                    topic.addToArguments(argument)
                    vm.saveAll()
                }
            List{
                ForEach(arguments){ argument in
                    ArgumentView(argument: argument)
                        .padding(.horizontal, -8)
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                argument.category = .pro
                                vm.saveAll()
                            } label: {
                                Text("Pro")
                            }.tint(.green)
                            Button {
                                argument.category = .neutral
                                vm.saveAll()
                            } label: {
                                Text("Neutral")
                            }
                            Button {
                                argument.category = .con
                                vm.saveAll()
                            } label: {
                                Text("Con")
                            }
                            .tint(.orange)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                vm.deleteArgument(argument: argument)
                            } label: {
                                Text("Delete")
                            }

                        }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}
