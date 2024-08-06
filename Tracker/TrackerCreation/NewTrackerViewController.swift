//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import UIKit

final class NewTrackerViewController: UIViewController {
    // MARK: - Public Properties
    weak var delegate: TrackerCreationDelegate?
    
    // MARK: - Private Properties
    private var newHabitButton = UIButton()
    private var newEventButton = UIButton()
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString("chooseTrackerVC.title", comment: "")
        
        setupNewHabitButton()
        setupNewEventButton()
    }
    
    // MARK: - IBAction
    @objc
    private func newHabitPressed() {
        let vc = NewHabitCreationViewController()
        vc.closeCreatingTrackerViewController = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: vc)
        vc.creationDelegate = delegate
        present(navigationController, animated: true)
    }
    
    @objc
    private func newEventPressed() {
        let vc = NewEventCreationViewController()
        vc.closeCreatingTrackerViewController = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: vc)
        vc.creationDelegate = delegate
        present(navigationController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupNewHabitButton() {
        newHabitButton.setTitle(NSLocalizedString("habit", comment: ""), for: .normal)
        newHabitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        newHabitButton.titleLabel?.textColor = .white
        newHabitButton.backgroundColor = UIColor(named: "YP Black")
        newHabitButton.layer.cornerRadius = 16
        newHabitButton.addTarget(self, action: #selector(newHabitPressed), for: .touchUpInside)
        newHabitButton.accessibilityIdentifier = "NewHabit"
        newHabitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newHabitButton)
        
        NSLayoutConstraint.activate([
            newHabitButton.heightAnchor.constraint(equalToConstant: 60),
            newHabitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newHabitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newHabitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNewEventButton() {
        newEventButton.setTitle(NSLocalizedString("event", comment: ""), for: .normal)
        newEventButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        newEventButton.titleLabel?.textColor = .white
        newEventButton.backgroundColor = UIColor(named: "YP Black")
        newEventButton.layer.cornerRadius = 16
        newEventButton.addTarget(self, action: #selector(newEventPressed), for: .touchUpInside)
        newEventButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newEventButton)
        
        NSLayoutConstraint.activate([
            newEventButton.heightAnchor.constraint(equalToConstant: 60),
            newEventButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newEventButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newEventButton.topAnchor.constraint(equalTo: newHabitButton.bottomAnchor, constant: 16)
        ])
    }
}
