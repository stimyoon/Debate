//
//  Argument+Extension.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import Foundation

extension Argument {
    var text: String {
        get { text_ ?? ""}
        set { text_ = newValue}
    }
    var category: Category {
        get { Category(rawValue: categoryID) ?? .neutral}
        set { categoryID = newValue.rawValue}
    }
}
