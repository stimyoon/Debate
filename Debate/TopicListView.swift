//
//  TopicListView.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import SwiftUI

struct TopicListView: View {
    @EnvironmentObject var vm: TopicListVM
    @State private var text = ""
    
    var body: some View {
        NavigationSplitView {
            VStack{
                topicTextField
                List(selection: $vm.selectedTopic) {
                    ForEach(vm.topics){ topic in
                        Text("\(topic.text)").tag(topic)
                            .lineLimit(nil)
                    }
                    .onMove(perform: vm.move)
                    .onDelete(perform: vm.delete)
                    .onAppear{
                        if vm.topics.count >= 1 {
                            vm.selectedTopic = vm.topics[0]
                        }
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .primaryAction) {
                        deleteSelectedTopicButton
                    }

                }
                
            }
            .navigationTitle("Debate ⚖️")
            .frame(minWidth: 300)
            
        } detail: {
            if let topic = vm.selectedTopic {
                TopicDetailView(topic: topic)
                    .navigationTitle("Topic ⚖️")
            } else {
                Text("Choose Topic")
                    .navigationTitle("Topic ⚖️")
            }
        }
    }
    private func createTopic(){
        _ = vm.create(text: text)
        text = ""
    }
}

extension TopicListView {
    var deleteSelectedTopicButton: some View {
        Button {
            deleteSelectedTopic()
        } label: {
            Image(systemName: "trash")
        }
        .keyboardShortcut(.delete)
    }
    func deleteSelectedTopic(){
        guard let topic = vm.selectedTopic else { return }
        vm.delete(topic: topic)
    }
    
    var topicTextField: some View {
        TextField("Topic", text: $text, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 8)
            .overlay(
                textFieldClearButton
            )
            .onSubmit {
                createTopic()
            }
    }
    
    var textFieldClearButton: some View {
        HStack{
            Spacer()
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark.circle")
                    .padding(.trailing, 8)
                    .foregroundColor(text.isEmpty ? .clear : .secondary)
            }
            .buttonStyle(.plain)
        }
    }
}

struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        TopicListView()
            .environmentObject(TopicListVM())
    }
}
