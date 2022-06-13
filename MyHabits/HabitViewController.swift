//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Fanil_Jr on 13.06.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit? {
        
        didSet {
            
            textField.text = habit?.name
            textField.textColor = habit?.color
            colorView.backgroundColor = habit?.color
            datePicket.date = habit?.date ?? Date()
        }
    }
    
    enum State {
        
        case save
        case edit
        
    }
    
    var state: State = State.save
    
    private let nameLabel: UILabel = {
        
        var name = UILabel()
        name.text = "НАЗВАНИЕ"
        name.backgroundColor = .white
        name.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
        
    }()
    
    private let textField: UITextField = {
        
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textField.textColor = UIColor(named: "Orange")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    private let colorLabel: UILabel = {
        
        var color = UILabel()
        color.text = "ЦВЕТ"
        color.backgroundColor = .white
        color.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
        
    }()
    
    private let colorView: UIView = {
        
        var color = UIView()
        color.backgroundColor = UIColor(named: "Orange")
        color.layer.cornerRadius = 15
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
        
    }()
    
    private let timeLabel: UILabel = {
        
        var time = UILabel()
        time.text = "ВРЕМЯ"
        time.backgroundColor = .white
        time.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
        
    }()
    
    private let timeDescription: UILabel = {
        
        var description = UILabel()
        description.text = "Каждый день в "
        description.backgroundColor = .white
        description.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
        
    }()
    
    private let datePicket: UIDatePicker = {
        
        var picker = UIDatePicker()
        picker.tintColor = UIColor(named: "Purple")
        picker.datePickerMode = .time
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
        
    }()
    
    private let deleteButton: UIButton = {
        
        let delete = UIButton()
        delete.tintColor = .red
        delete.setTitle("Удалить привычку", for: .normal)
        delete.setTitleColor(.red, for: .normal)
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return delete
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(createHabit))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelCreateHabit))
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()

        setup()
        let colorGesture = UITapGestureRecognizer(target: self, action: #selector(colorGesture))
        colorView.addGestureRecognizer(colorGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = (state == .save ? "Создать" : "Править")
        setup()
        
    }
}
    
extension HabitViewController {
    
    @objc func deleteHabit() {
        let habitsStore = HabitsStore.shared
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit?.name ?? " ") ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            _ in for (index, storaheHabit) in habitsStore.habits.enumerated() {
                if storaheHabit.name == self.habit?.name {
                    habitsStore.habits.remove(at: index)
                    self.navigationController?.dismiss(animated: false, completion: nil)
                    break
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func createHabit() {
        let habitsStore = HabitsStore.shared
        let habitik = Habit(name: textField.text!, date: datePicket.date, color: colorView.backgroundColor!)
        
        if state == .save {
            habitsStore.habits.append(habitik)
        } else {
            for (index, storageHabit) in habitsStore.habits.enumerated() {
                if storageHabit.name == habit?.name {
                    habitik.trackDates = storageHabit.trackDates
                    habitsStore.habits[index] = habitik
                    habit? = habitik
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
        
    @objc func cancelCreateHabit() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func colorGesture(gesure: UITapGestureRecognizer) {
        presentColor(colorView.backgroundColor!)
    }
    
    private func presentColor(_ color: UIColor) {
        let pickerViewController = UIColorPickerViewController()
        pickerViewController.delegate = self
        pickerViewController.selectedColor = color
        pickerViewController.title = "Выберите цвет"
        present(pickerViewController, animated: true, completion: nil)
    }
    
    func setup() {
        [nameLabel,textField,colorLabel,colorView,timeLabel,timeDescription,datePicket].forEach { view.addSubview($0) }
     
        if state == .edit {
            view.addSubview(deleteButton)
            NSLayoutConstraint.activate([
                deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
        
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            colorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 15),
            colorLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16),
            colorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 15),
            colorLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16),
            
            
        
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            timeLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),

            timeDescription.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),

            datePicket.centerYAnchor.constraint(equalTo: timeDescription.centerYAnchor),
            datePicket.leftAnchor.constraint(equalTo: timeDescription.rightAnchor)
        ])
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorView.backgroundColor = viewController.selectedColor
        textField.textColor = colorView.backgroundColor
    }
}


