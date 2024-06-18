//
//  ScheduleTableCell.swift
//  Tracker
//
//  Created by Gleb on 16.06.2024.
//

import UIKit

final class ScheduleTableCell: UITableViewCell {
    static let identifier = "ScheduleTableCell"
    
    let switchButton = UISwitch(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "YP Gray")?.withAlphaComponent(0.3)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSwitch() {
        switchButton.setOn(false, animated: true)
        self.accessoryView = switchButton
    }
}
