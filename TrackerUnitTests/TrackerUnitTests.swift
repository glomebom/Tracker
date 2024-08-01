//
//  TrackerUnitTests.swift
//  TrackerUnitTests
//
//  Created by Gleb on 31.07.2024.
//

@testable import Tracker
import XCTest

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

final class TrackerCategoriesMock {
    lazy var completedTrackersMock: [TrackerRecord] = {
        let tracker = categoriesMock[0].trackers.first!
        return [
            TrackerRecord(id: tracker.id, date: Date())
        ]
    }()
    
    let categoriesMock: [TrackerCategory] = {
        let todayWeekDayInt = Calendar.current.component(.weekday, from: Date())
        let today = (todayWeekDayInt == 1) ? WeekDays(rawValue: 7)! : WeekDays(rawValue: todayWeekDayInt-1)!
        
        let tomorrowWeekDayInt = Calendar.current.component(.weekday, from: Date.tomorrow)
        let tomorrow = (tomorrowWeekDayInt == 1) ? WeekDays(rawValue: 7)! : WeekDays(rawValue: tomorrowWeekDayInt-1)!
        
        return [
            TrackerCategory(
                title: "Important",
                trackers: [
                    Tracker(name: "water plants",
                            color: .color1,
                            emoji: Constants.allEmojies[1],
                            schedule: [today],
                            state: .habit,
                            isPinned: false),
                    Tracker(name: "walk with dog",
                            color: .color2,
                            emoji: Constants.allEmojies[2],
                            schedule: [today],
                            state: .habit,
                            isPinned: false),
                    Tracker(name: "deliever package",
                            color: .color3,
                            emoji: Constants.allEmojies[2],
                            schedule: [tomorrow],
                            state: .habit,
                            isPinned: true)
                ]),
            TrackerCategory(
                title: "Health",
                trackers: [
                    Tracker(
                        name: "gym",
                        color: .color3,
                        emoji: Constants.allEmojies[3],
                        schedule: [today],
                        state: .habit,
                        isPinned: false)
                ])
        ]
    }()
}

final class TrackerUnitTests: XCTestCase {
    
    func testFilterCategoriesBySelectedDay() throws {
        //given
        let mock = TrackerCategoriesMock()
        let presenter = TrackerPresenter()
        presenter.categories = mock.categoriesMock
        presenter.currentDate = Date.tomorrow
        
        //when
        let result = presenter.filterCategoriesBySelectedDay()
        
        //then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].trackers.count, 1)
    }
    
    func testFilterPinnedTrackers() throws {
        //given
        let mock = TrackerCategoriesMock()
        let presenter = TrackerPresenter()
        presenter.categories = mock.categoriesMock
        let categories = mock.categoriesMock
        
        //when
        let result = presenter.filterPinnedTrackers(categories: categories)
        print(result)
        
        //then
        //First category is Pinned
        XCTAssertEqual(result[0].title, NSLocalizedString("pinned", comment: ""))
        //Pinned Category has only 1 tracker
        XCTAssertEqual(result[0].trackers.count, 1)
    }
    
    func testFilterCategoriesByCompletion() throws {
        //given
        let presenter = TrackerPresenter()
        let mock = TrackerCategoriesMock()
        presenter.currentDate = Date()
        presenter.categories = mock.categoriesMock
        presenter.completedTrackers = mock.completedTrackersMock
        
        //when
        let result = presenter.filterCategoriesByCompletion(isCompleted: true)
        
        //then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].trackers.count, 1)
        XCTAssertEqual(result[0].trackers[0].name, mock.categoriesMock[0].trackers[0].name)
    }
    
    //INTERNET CONNECTION
    func testFilterCategoriesToShow() throws {
        //given
        let presenter = TrackerPresenter()
        let mock = TrackerCategoriesMock()
        presenter.currentDate = Date()
        presenter.categories = mock.categoriesMock
        presenter.completedTrackers = mock.completedTrackersMock
        
        //when
        let result = presenter.filterCategoriesToshow(filter: .completedTrackers)
        
        //then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].trackers.count, 1)
        XCTAssertEqual(result[0].trackers[0].name, mock.categoriesMock[0].trackers[0].name)
        
    }
    
    //MARK: - Create Tracker
    func testCreateButtonCanBePressed() {
        //given
        let vc = NewHabitCreationViewController()
        let mock = TrackerCategoriesMock()
        
        //when
        vc.trackerName = "Doctor appointment"
        vc.selectedEmoji = "🙂"
        vc.selectedColor = .color3
        vc.selectedWeekDays = [.monday]
        vc.trackerCategory = mock.categoriesMock[0]
        vc.checkIfSaveButtonCanBePressed()
        
        //then
        XCTAssertTrue(vc.saveButtonCanBePressed!)
    }
    
    func testCreateButtonCanNotBePressed() {
        //given
        let vc = NewHabitCreationViewController()
        
        
        //when
        vc.trackerName = "Doctor appointment"
        vc.checkIfSaveButtonCanBePressed()
        
        //then
        XCTAssertFalse(vc.saveButtonCanBePressed!)
    }
    
    //convertSelectedDaysToString
    func testConvertSelectedDaysToString() throws {
        //given
        let mock = TrackerCategoriesMock()
        let trackerInfo = TrackerInfoModel(
            id: UUID(),
            name: "drink 2l of water",
            color: .color8,
            emoji: "🙌",
            schedule: [
                .monday,
                .tueseday,
                .wednesday,
                .thursday,
                .friday,
                .saturday,
                .sunday
            ],
            category: mock.categoriesMock[0],
            daysCount: 0,
            isPinned: false,
            state: .habit
        )
        let viewModel = EditingViewModel(trackerInfo: trackerInfo)
        
        //when
        let result = viewModel.convertSelectedDaysToString()
        
        //then
        XCTAssertEqual(result, NSLocalizedString("weekdays.all", comment: ""))
    }
}
