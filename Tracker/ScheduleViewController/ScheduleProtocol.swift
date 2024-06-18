//
//  ScheduleProtocol.swift
//  Tracker
//
//  Created by Gleb on 16.06.2024.
//

import Foundation

protocol ScheduleProtocol: AnyObject {
    func saveSelectedDays(selectedDays: Set<WeekDays>)
}
