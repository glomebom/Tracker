//
//  ConfigureUIForTrackerCreationProtocol.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import Foundation

protocol ConfigureUIForTrackerCreationProtocol: AnyObject {
    func configureButtonsCell(cell: ButtonsCell)
    func setupBackground()
    func calculateTableViewHeight(width: CGFloat) -> CGSize
    func checkIfSaveButtonCanBePressed()
}
