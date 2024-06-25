//
//  TrackerRecord.swift
//  Tracker
//
//  Created by Gleb on 06.06.2024.
//

import Foundation

struct TrackerRecord {
    let id: UUID
    let date: Date
    
    init(id: UUID, date: Date) {
        self.id = id
        self.date = date
    }
}
