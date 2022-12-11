//
//  Topic+Extensions.swift
//  Debate
//
//  Created by Tim Yoon on 12/11/22.
//

import Foundation

extension Topic {
    var text: String {
        get { text_ ?? ""}
        set { text_ = newValue}
    }
}
