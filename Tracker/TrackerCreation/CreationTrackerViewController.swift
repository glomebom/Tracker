//
//  CreationTrackerViewController.swift
//  Tracker
//
//  Created by Gleb on 11.06.2024.
//

import UIKit

class CreationTrackerViewController: UIViewController {
    weak var creationDelegate: TrackerCreationDelegete?
    weak var configureUIDelegate: ConfigureUIForTrackerCreationProtocol?
    
    private let stackView = UIStackView()
    private let saveButton = UIButton()
    private let cancelButton = UIButton()
    private let allEmojies = [ "🙂", "😻", "🌺", "🐶", "❤️", "😱",
                               "😇", "😡", "🥶", "🤔", "🙌", "🍔",
                               "🥦", "🏓", "🥇", "🎸", "🏝️", "😪"]
    private let allColors = [UIColor.color1, .color2, .color3, .color4, .color5, .color6,
                             .color7, .color8, .color9, .color10, .color11, .color12,
                             .color13, .color14, .color15, .color16, .color17, .color18]
    
    var selectedWeekDays: Set<WeekDays> = [] {
        didSet {
            configureUIDelegate?.checkIfSaveButtonCanBePressed()
        }
    }
    
    var trackerCategory = "Здоровье" { //???
        didSet {
            configureUIDelegate?.checkIfSaveButtonCanBePressed()
        }
    }
    
    var trackerName: String? {
        didSet {
            configureUIDelegate?.checkIfSaveButtonCanBePressed()
        }
    }
    
    var selectedEmoji: String? {
        didSet {
            configureUIDelegate?.checkIfSaveButtonCanBePressed()
        }
    }
    
    var selectedColor: UIColor? {
        didSet {
            configureUIDelegate?.checkIfSaveButtonCanBePressed()
        }
    }
    
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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
        setupCollectionView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc
    func saveButtonPressed() {
        guard let name = trackerName,
              let color = selectedColor,
              let emoji = selectedEmoji else { return }
        let tracker = Tracker(
            name: name,
            color: color,
            emoji: emoji,
            schedule: selectedWeekDays,
            state: .Habit //???
        )
        
        creationDelegate?.createTracker(tracker: tracker, category: trackerCategory)
        dismiss(animated: true)
    }
    
    //MARK: - Setup StackView And Buttons
    private func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = UIColor(named: "YP Gray")
        saveButton.layer.cornerRadius = 16
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.clipsToBounds = true
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(named: "YP Red")?.cgColor
        cancelButton.layer.backgroundColor = UIColor.white.cgColor
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupStackView() {
        setupSaveButton()
        setupCancelButton()
        
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 8
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(cancelButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    //MARK: - Setup CollectionView
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(NameTrackerCell.self, forCellWithReuseIdentifier: NameTrackerCell.identifier)
        collectionView.register(ButtonsCell.self, forCellWithReuseIdentifier: ButtonsCell.identifier)
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16)
        ])
    }
}

//MARK: DataSource
extension CreationTrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return allEmojies.count
        case 3:
            return allColors.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameTrackerCell.identifier, for: indexPath) as? NameTrackerCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.prepareForReuse()
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.identifier, for: indexPath) as? ButtonsCell else {
                return UICollectionViewCell()
            }
            configureUIDelegate?.configureButtonsCell(cell: cell)
            return cell
        case 2:
            return configureEmojiCell(cellForItemAt: indexPath)
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell else {
                return UICollectionViewCell()
            }
            cell.prepareForReuse()
            cell.colorView.backgroundColor = allColors[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let sectionHeader  = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            ) as? HeaderCollectionReusableView {
                if indexPath.section == 2 {
                    sectionHeader.titleLabel.text = "Emoji"
                    return sectionHeader
                } else if indexPath.section == 3 {
                    sectionHeader.titleLabel.text = "Цвет"
                    return sectionHeader
                }
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section{
        case 2, 3:
            return CGSize(width: collectionView.bounds.width, height: 18)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    
    private func configureEmojiCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifier, for: indexPath) as? EmojiCell else {
            return UICollectionViewCell()
        }
        cell.label.text = allEmojies[indexPath.row]
        return cell
    }
}

//MARK: - Delegate
extension CreationTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 16 * 2
        
        switch indexPath.section {
        case 0:
            return CGSize(width: cellWidth, height: 75)
        case 1:
            return configureUIDelegate?.calculateTableViewHeight(width: cellWidth) ?? CGSize(width: cellWidth, height: 150)
        case 2, 3:
            let width = collectionView.frame.width - 18 * 2
            return CGSize(width: width / 6, height: width / 6)
        default:
            return CGSize(width: cellWidth, height: 75)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 24, left: 16, bottom: 32, right: 16)
        }
        switch section {
        case 1:
            return UIEdgeInsets(top: 24, left: 16, bottom: 32, right: 16)
        case 2, 3:
            return UIEdgeInsets(top: 24, left: 16, bottom: 40, right: 16)
        default:
            return UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({ collectionView.deselectItem(at: $0, animated: false) })
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell else {
                collectionView.deselectItem(at: indexPath, animated: true)
                return
            }
            guard let emoji = cell.label.text else { return }
            selectedEmoji = emoji
        } else if indexPath.section == 3 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else {
                collectionView.deselectItem(at: indexPath, animated: true)
                return
            }
            guard let color = cell.colorView.backgroundColor else { return }
            selectedColor = color
        } else {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            selectedEmoji = nil
        } else if indexPath.section == 3 {
            selectedColor = nil
        }
    }
}

//MARK: - SaveNameTrackerDelegate
extension CreationTrackerViewController: SaveNameTrackerDelegate {
    func textFieldWasChanged(text: String) {
        if text == "" {
            trackerName = nil
            return
        } else {
            trackerName = text
        }
    }
}

//MARK: - ShowCategoriesDelegate
extension CreationTrackerViewController: ShowCategoriesDelegate {
    func showCategoriesViewController() {
        //TODO:
    }
}
