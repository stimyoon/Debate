//
//  DebateApp.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import SwiftUI

@main
struct DebateApp: App {
    @StateObject var vm = TopicListVM()
    @StateObject var argVM = ArgumentListVM()
    
    var body: some Scene {
        WindowGroup {
            TopicListView()
                .environmentObject(vm)
                .environmentObject(argVM)
        }
    }
}
