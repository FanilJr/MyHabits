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
    
    private let deleteButton = {
        
        let delete = UIButton()
        delete.tintColor = .red
        delete.setTitle("Удалить привычку", for: .normal)
        delete.setTitleColor(.red, for: .normal)
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(createHabit))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelCreateHabit))
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()

    }
    
    @objc func deleteHabit() {
        
    }
    
    @objc func createHabit() {
        
    }
    
    @objc func cancelCreateHabit() {
        
    }

}
