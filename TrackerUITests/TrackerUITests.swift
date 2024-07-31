//
//  TrackerUITests.swift
//  TrackerUITests
//
//  Created by Gleb on 31.07.2024.
//

import XCTest

final class TrackerUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testCategoryCreation() {
        sleep(5)
        if (app.buttons["onboardingButton"].exists) {
            app.buttons["onboardingButton"].tap()
            sleep(3)
        }
        let trackersCollection = app.collectionViews
        app.buttons["AddTracker"].tap()
        sleep(2)
        
        app.buttons["NewHabit"].tap()
        sleep(1)
        
        let creationCollection = app.collectionViews
        let buttonsCell = creationCollection.children(matching: .cell).element(boundBy: 1)
        let categoryCell = buttonsCell.cells.element(matching: .cell, identifier: "CategoryCell")
        categoryCell.tap()
        sleep(1)
        
        let amountOfCategoriesBefore = app.tables.children(matching: .cell).count
        app.buttons["createCategory"].tap()
        
        let saveButton = app.buttons["saveNewCategory"]
        XCTAssertFalse(!saveButton.isEnabled)
        let textField = app.descendants(matching: .textField).element
        textField.tap()
        textField.typeText("Health")
        if (app.toolbars.buttons["Return"].exists) {
            app.toolbars.buttons["Return"].tap()
            print("button")
        } else {
            let window = app.children(matching: .window).firstMatch
            window.tap()
        }
        
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()
        let amountOfCategoriesAfter = app.tables.children(matching: .cell).count
        XCTAssertNotEqual(amountOfCategoriesBefore, amountOfCategoriesAfter)
    }

    func testTrackerCreating() throws {
        sleep(5)
        let trackersCollection = app.collectionViews
        let amountOfTrackersBefore = trackersCollection.children(matching: .cell).count
        print(amountOfTrackersBefore)
        
        app.buttons["AddTracker"].tap()
        sleep(2)
        
        app.buttons["NewHabit"].tap()
        sleep(1)
        
        let saveButton = app.buttons["saveNewTracker"]
        XCTAssertFalse(!saveButton.isEnabled)
        
        let creationCollection = app.collectionViews
        let nameCell = creationCollection.children(matching: .cell).element(boundBy: 0)
        let nameTextField = nameCell.descendants(matching: .textField).element
        let buttonsCell = creationCollection.children(matching: .cell).element(boundBy: 1)
        let categoryCell = buttonsCell.cells.element(matching: .cell, identifier: "CategoryCell")
        let scheduleCell = buttonsCell.cells.element(matching: .cell, identifier: "ScheduleCell")
        
        // enter tracker name
        nameTextField.tap()
        sleep(2)
        nameTextField.typeText("gym")
        if (app.toolbars.buttons["Return"].exists) {
            app.toolbars.buttons["Return"].tap()
            print("button")
        } else {
            let window = app.children(matching: .window).firstMatch
            window.tap()
        }
        
        //enter schedule
        scheduleCell.tap()
        chooseAllDays()
        
        //enter category
        categoryCell.tap()
        app.tables.children(matching: .cell).firstMatch.tap()
        
        //enter color
        creationCollection.children(matching: .cell).element(boundBy: 2).tap()
        creationCollection.children(matching: .cell).element(boundBy: 2).swipeUp()
        
        //enter emoji
        creationCollection.children(matching: .cell).element(boundBy: (2 + 19)).tap()
        
        //check button
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()
        sleep(1)
        
        let amountOfTrackersAfter = trackersCollection.children(matching: .cell).count
        XCTAssertNotEqual(amountOfTrackersBefore, amountOfTrackersAfter)
        
    }
    
    func testTrackerDeleting() {
        sleep(5)
        let trackersCollection = app.collectionViews
        let amountOfTrackersBefore = trackersCollection.children(matching: .cell).count
        if amountOfTrackersBefore > 0 {
            let trackerToDelete = trackersCollection.firstMatch
            
            let card = trackerToDelete.otherElements["trackerBackground"]
            card.press(forDuration: 3)
            
            let deleteButton = app.buttons["deleteTracker"]
            deleteButton.tap()
            sleep(1)
            
            let deleteButtonConfirmation = app.buttons["deleteTrackerConfirmation"]
            deleteButtonConfirmation.tap()
            sleep(1)
            
            let amountOfTrackersAfter = trackersCollection.children(matching: .cell).count
            XCTAssertNotEqual(amountOfTrackersBefore, amountOfTrackersAfter)
        }
        
    }
    
    private func chooseAllDays() {
        let mondayCell = app.tables.children(matching: .cell).element(boundBy: 0)
        let tuesdayCell = app.tables.children(matching: .cell).element(boundBy: 1)
        let wednesdayCell = app.tables.children(matching: .cell).element(boundBy: 2)
        let thursdayCell = app.tables.children(matching: .cell).element(boundBy: 3)
        let fridayCell = app.tables.children(matching: .cell).element(boundBy: 4)
        let saturdayCell = app.tables.children(matching: .cell).element(boundBy: 5)
        let sundayCell = app.tables.children(matching: .cell).element(boundBy: 6)
        mondayCell.switches.firstMatch.tap()
        tuesdayCell.switches.firstMatch.tap()
        wednesdayCell.switches.firstMatch.tap()
        thursdayCell.switches.firstMatch.tap()
        fridayCell.switches.firstMatch.tap()
        saturdayCell.switches.firstMatch.tap()
        sundayCell.switches.firstMatch.tap()
        
        app.buttons["saveSchedule"].tap()
        sleep(1)
    }
}
