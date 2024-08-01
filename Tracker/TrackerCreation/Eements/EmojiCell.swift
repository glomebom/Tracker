//
//  EmojiCell.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    // MARK: - Public Properties
    static let identifier = "EmojiCell"
    
    // MARK: - Private Properties
    private let label = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? UIColor(named: "YP Gray") : .clear
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 16
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setEmoji(with string: String) {
        label.text = string
    }
    
    func getEmoji() -> String {
        guard let text = label.text else { return String() }
        return text
    }
    
    // MARK: - Private Methods
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
