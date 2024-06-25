//
//  TrackerCounterDelegate.swift
//  Tracker
//
//  Created by Gleb on 09.06.2024.
//

import Foundation

protocol TrackerCounterDelegate: AnyObject {
    func increaseTrackerCounter(id: UUID, date: Date)
    func decreaseTrackerCounter(id: UUID, date: Date)
    func checkIfTrackerWasCompletedAtCurrentDay(id: UUID, date: Date) -> Bool
    func calculateTimesTrackerWasCompleted(id: UUID) -> Int
}
