//
//  Bit.swift
//  Tracker
//
//  Created by Gleb on 17.07.2024.
//

import Foundation

enum Bit: Int16 {
    case zero, one
    
    var description: Int {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        }
    }
}
