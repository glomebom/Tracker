//
//  CategoryCreationViewController.swift
//  Tracker
//
//  Created by Gleb on 23.07.2024.
//

import UIKit

final class CategoryCreationViewController: UIViewController {
    // MARK: - Public Properties
    var saveButtonCanBePressed: Bool? {
        didSet {
            switch saveButtonCanBePressed {
            case true:
                saveButton.backgroundColor = .black
                saveButton.isEnabled = true
            case false:
                saveButton.backgroundColor = .lightGray
                saveButton.isEnabled = false
            default:
                saveButton.backgroundColor = .lightGray
                saveButton.isEnabled = false
            }
        }
    }
    
    // MARK: - Private Properties
    private let saveButton = UIButton()
    private let categoryNameTextField = UITextField()
    private let trackerCategoryStore = TrackerCategoryStore()
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("category.new", comment: "")
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        setupSaveButton()
        setupTextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Private Methods
    @objc
    private func saveButtonTapped() {
        guard let text = categoryNameTextField.text else { return }
        createNewCategory(categoryName: text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc
    func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = categoryNameTextField.text else { return }
        if text == "" {
            saveButtonCanBePressed = false
        } else {
            saveButtonCanBePressed = true
        }
    }
    
    private func setupSaveButton() {
        saveButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        saveButton.titleLabel?.textColor = .white
        saveButton.backgroundColor = UIColor(named: "YP Gray")
        saveButton.layer.cornerRadius = 16
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupTextField() {
        categoryNameTextField.layer.cornerRadius = 16
        categoryNameTextField.backgroundColor = UIColor(named: "YP Gray")?.withAlphaComponent(0.3)
        categoryNameTextField.placeholder = NSLocalizedString("category.enterTittle", comment: "")
        categoryNameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        categoryNameTextField.setLeftPaddingPoints(12)
        categoryNameTextField.clearButtonMode = .whileEditing
        categoryNameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingDidEnd)
        categoryNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryNameTextField)
        
        NSLayoutConstraint.activate([
            categoryNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            categoryNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryNameTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func createNewCategory(categoryName: String) {
        try? trackerCategoryStore.addNewCategory(name: categoryName)
    }
}
