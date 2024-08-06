//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Gleb on 31.07.2024.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {

    func testTrackerViewControllerLight() {
        let vc = TrackerViewController()
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
    
    func testTrackerViewControllerDark() {
        let vc = TrackerViewController()
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .dark)))
    }
}
