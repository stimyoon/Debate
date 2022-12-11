//
//  TopicDetail.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import SwiftUI

struct TopicDetailView: View {
    @ObservedObject var topic: Topic
    @EnvironmentObject var vm: TopicListVM
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Topic:")
                TextField("Topic Text", text: $topic.text)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        vm.saveAll()
                    }
            }.padding(.horizontal)
            .font(.headline)
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(Color.green.gradient.opacity(0.2))
                    ArgumentListView(topic: topic, title: "Pro", filterCategory: .pro)
                }.padding(.leading)
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(Color.blue.gradient.opacity(0.2))
                    ArgumentListView(topic: topic, title: "Neutral", filterCategory: .neutral)
                }
                    
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(Color.red.gradient.opacity(0.2))
                    ArgumentListView(topic: topic, title: "Con", filterCategory: .con)

                }.padding(.trailing)
                
            }
        }
    }
}
