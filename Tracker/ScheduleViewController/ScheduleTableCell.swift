//
//  ScheduleTableCell.swift
//  Tracker
//
//  Created by Gleb on 16.06.2024.
//

import UIKit

final class ScheduleTableCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let identifier = "ScheduleTableCell"
    
    // MARK: - Private Properties
    private let switchButton = UISwitch(frame: .zero)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "YP Gray")?.withAlphaComponent(0.3)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configButton(with tag: Int, action: Selector, controller: UIViewController) {
        switchButton.tag = tag
        switchButton.addTarget(controller, action: action, for: .valueChanged)
    }
    
    func setOn() {
        switchButton.setOn(true, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupSwitch() {
        switchButton.setOn(false, animated: true)
        self.accessoryView = switchButton
    }
}
