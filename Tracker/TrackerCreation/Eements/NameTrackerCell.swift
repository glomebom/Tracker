//
//  NameTrackerCell.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import UIKit

protocol SaveNameTrackerDelegate: AnyObject {
    func textFieldWasChanged(text: String)
}

final class NameTrackerCell: UICollectionViewCell {
    // MARK: - Public Properties
    static let identifier = "TrackerNameTextFieldCell"
    
    weak var delegate: SaveNameTrackerDelegate?
    
    // MARK: - Private Properties
    private let trackerNameTextField = UITextField()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTrackerNameTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBAction
    @objc
    func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = trackerNameTextField.text else { return }
        delegate?.textFieldWasChanged(text: text)
    }
    
    // MARK: - Public Methods
    func setTrackerNameTextField(with string: String) {
        trackerNameTextField.text = string
    }
    
    // MARK: - Private Methods
    private func setupTrackerNameTextField() {
        trackerNameTextField.layer.cornerRadius = 16
        trackerNameTextField.backgroundColor = UIColor { (traits: UITraitCollection) -> UIColor in
            if traits.userInterfaceStyle == .light {
                return UIColor.tableCellColor.withAlphaComponent(0.3)
            } else {
                return UIColor.tableCellColor.withAlphaComponent(0.85)
            }
        }
        trackerNameTextField.placeholder = NSLocalizedString("trackerCreation.enterTitle", comment: "")
        trackerNameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        trackerNameTextField.setLeftPaddingPoints(12)
        
        trackerNameTextField.clearButtonMode = .whileEditing
        trackerNameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingDidEnd)
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackerNameTextField)
        
        NSLayoutConstraint.activate([
            trackerNameTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            trackerNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackerNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trackerNameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
