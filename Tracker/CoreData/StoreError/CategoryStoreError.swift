//
//  CategoryStoreError.swift
//  Tracker
//
//  Created by Gleb on 04.07.2024.
//

import Foundation

enum CategoryStoreError: Error {
    case decodingTitleError
    case decodingTrackersError
    case fetchingCategoryError
}
