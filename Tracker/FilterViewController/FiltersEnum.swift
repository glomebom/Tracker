//
//  FiltersEnum.swift
//  Tracker
//
//  Created by Gleb on 29.07.2024.
//

import Foundation

enum Filters: String, CaseIterable {
    case allTrackers
    case todayTrackers
    case completedTrackers
    case uncompletedTrackers
    
    var name: String {
        switch self {
        case.allTrackers:
            return NSLocalizedString("allTrackers", comment: "")
        case .todayTrackers:
            return NSLocalizedString("todayTrackers", comment: "")
        case .completedTrackers:
            return NSLocalizedString("completedTrackers", comment: "")
        case .uncompletedTrackers:
            return NSLocalizedString("uncompletedTrackers", comment: "")
        }
    }
}
