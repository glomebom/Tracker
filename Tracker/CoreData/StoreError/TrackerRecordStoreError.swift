//
//  TrackerRecordStoreError.swift
//  Tracker
//
//  Created by Gleb on 04.07.2024.
//

import Foundation

enum TrackerRecordStoreError: Error {
    case decodingTrackerRecordIdError
    case decodingTrackerRecordDateError
    case fetchTrackerRecordError
}
