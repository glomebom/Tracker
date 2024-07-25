//
//  CategoryCell.swift
//  Tracker
//
//  Created by Gleb on 23.07.2024.
//

import UIKit

final class CategoryCell: UITableViewCell {
    // MARK: - Public Properties
    static let identifier = "CategoryCell"
    
    var label = UILabel()
    var viewModel: CategoryViewModel? {
        didSet {
            viewModel?.titleBinding = { [weak self] title in
                self?.label.text = title
            }
        }
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "YP Gray")?.withAlphaComponent(0.3)
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layer.maskedCorners = []
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}