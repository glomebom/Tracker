//
//  TrackerCreationDelegete.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import Foundation

protocol TrackerCreationDelegete: AnyObject {
    func createTracker(tracker: Tracker, category: String)
}
