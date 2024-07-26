//
//  PlaceHolderView.swift
//  Tracker
//
//  Created by Gleb on 10.06.2024.
//

import UIKit

final class PlaceHolderView: UIView {
    
    // MARK: - Private Properties
    private var imageView = UIImageView()
    private var label = UILabel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setupNoTrackersState() {
        imageView.image = UIImage(named: "statisticsStar")
        label.text = NSLocalizedString("placeholder.noTrackers", comment: "")
    }
    
    func setupNoSearchResultsState() {
        imageView.image = UIImage(named: "notFound")
        label.text = NSLocalizedString("placeholder.noSearchResults", comment: "")
    }
    
    func setUpNoCategories() {
        let image = UIImage(named: "statisticsStar")
        imageView.image = image
        
        label.text = NSLocalizedString("placeholder.noCategories", comment: "")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    func setupNoStatisticState() {
        // TODO: реализовать функционал статистики
    }
    
    // MARK: - Private Methods
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            //label.heightAnchor.constraint(equalToConstant: 18),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
