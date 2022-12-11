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
        guard let args = topic.arguments else { return [] }
        
        return (args.allObjects as! [Argument])
            .sorted(by: {$0.listorder < $1.listorder})
            .filter { $0.category == filterCategory }
        
    }
    
    var body: some View {
        VStack(spacing: 0){
            Text(title)
                .padding(.top)
            TextField("Argument", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 4)
                .onSubmit {
                    let argument = vm.createArgument(text: text, category: filterCategory)
                    if let count = topic.arguments?.count {
                        argument.listorder = Int64(count)
                    }else{
                        argument.listorder = Int64(0)
                    }
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
                                argVM.saveAll()
                            } label: {
                                Text("Pro")
                            }.tint(.green)
                            Button {
                                argument.category = .neutral
                                argVM.saveAll()
                            } label: {
                                Text("Neutral")
                            }
                            Button {
                                argument.category = .con
                                argVM.saveAll()
                            } label: {
                                Text("Con")
                            }
                            .tint(.orange)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                argVM.delete(argument: argument)
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
