//
//  Category.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import Foundation

enum Category: Int64, Identifiable, CaseIterable {
    var id: Self { self }
    case pro = 0, neutral, con
    var text: String {
        switch self {
        case .pro:
            return "Pro"
        case .neutral:
            return "="
        case .con:
            return "Con"
        }
    }
}
