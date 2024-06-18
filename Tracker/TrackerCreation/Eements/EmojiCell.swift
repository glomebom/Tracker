//
//  EmojiCell.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    static let identifier = "EmojiCell"
    
    let label = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? UIColor(named: "YP Gray") : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 16
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

