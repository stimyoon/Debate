//
//  ArgumentListVM.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import Foundation
import Combine

class ArgumentListVM: ObservableObject {
    @Published private(set) var arguments: [Argument] = []
    
    private let ds = CoreDataService<Argument>(manager: PersistenceController.shared, entityName: "Argument")
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { [weak self] arguments in
                self?.arguments = arguments
            }
            .store(in: &cancellables)
    }
    func saveAll(){
        ds.saveAll()
    }
    func create(text: String, category: Category) -> Argument {
        let argument = ds.create()
        argument.text = text
        argument.category = category
        return argument
    }
    func update(argument: Argument) {
        ds.saveAll()
    }
    func delete(argument: Argument) {
        ds.delete(argument)
    }
}
