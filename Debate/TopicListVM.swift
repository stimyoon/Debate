//
//  TopicListVM.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import Foundation
import Combine

class TopicListVM: ObservableObject {
    @Published private(set) var topics: [Topic] = []
    @Published var selectedTopic: Topic? = nil
    
    private let ds : CoreDataService<Topic>
    private var cancellables = Set<AnyCancellable>()
    
    func create(text: String)->Topic {
        let topic = ds.create()
        topic.text = text
        topic.listOrder = Int64(topics.count)
        topic.timestamp = Date()
        saveAll()
        return topic
    }
    func createArgument(text: String, category: Category)->Argument {
        let argument = Argument(context: PersistenceController.shared.context)
        argument.category = category
        argument.text = text
        saveAll()
        return argument
    }
    func deleteArgument(argument: Argument) {
        PersistenceController.shared.context.delete(argument)
    }
    func moveArguments(topic: Topic, indexSet: IndexSet, index: Int) {
        var arguments = topic.arguments?.allObjects as! [Argument]
        arguments.sort(by: {$0.listorder < $1.listorder})
        arguments.move(fromOffsets: indexSet, toOffset: index)
        for index in 0..<arguments.count {
            arguments[index].listorder = Int64(index)
        }
        saveAll()
    }
    func saveAll() {
        ds.saveAll()
    }
    func delete(topic: Topic){
        ds.delete(topic)
    }
    func delete(indexSet: IndexSet){
        ds.delete(indexSet: indexSet)
    }
    func move(from offsets: IndexSet, to index: Int) {
        topics.move(fromOffsets: offsets, toOffset: index)
        for index in 0..<topics.count {
            topics[index].listOrder = Int64(index)
        }
        ds.saveAll()
    }
    init(){
        let sortDescriptor = NSSortDescriptor(key: "listOrder", ascending: true)
        ds = CoreDataService<Topic>(manager: PersistenceController.shared, entityName: "Topic", sortDescriptors: [sortDescriptor])
        
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { [weak self] topics in
                self?.topics = topics
            }
            .store(in: &cancellables)
    }
}
