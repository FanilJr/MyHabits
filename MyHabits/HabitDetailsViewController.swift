//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Fanil_Jr on 14.06.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit?
    
    private let habitEditViewController: HabitViewController = {
        
        let habitEdit = HabitViewController()
        return habitEdit
        
    }()
    
    private let tableViews: UITableView = {
        
        let table = UITableView()
        table.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "HabitDetailsTableViewCell")
        table.backgroundColor = UIColor(named: "LightGray")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
        
    }()
    
    private let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.doesRelativeDateFormatting = true
        return formatter
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Править", style: .plain, target: self, action: #selector(edit))
        
    //    tableViews.delegate = self
        tableViews.dataSource = self
        
        setup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habitEditViewController.habit {
            
            self.habit = habit
            if !HabitsStore.shared.habits.contains(habit) {
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = habit?.name
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        
    }
}

private extension HabitDetailsViewController {
    
    @objc func edit() {
        
        habitEditViewController.habit = habit
        habitEditViewController.state = .edit
        
        let editNavigationController = UINavigationController(rootViewController: habitEditViewController)
        editNavigationController.modalPresentationStyle = .fullScreen
        present(editNavigationController, animated: true, completion: nil)
        
    }
    
    func setup() {
        
        view.addSubview(tableViews)
        
        NSLayoutConstraint.activate([
            tableViews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViews.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViews.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//extension HabitDetailsViewController: UITableViewDelegate {
    
//}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HabitsStore.shared.dates.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitDetailsTableViewCell", for: indexPath) as! HabitDetailsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.date.text = dateFormatter.string(from: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1])
        
        if let isHabit = habit {
            
            if HabitsStore.shared.habit(isHabit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1]) {
                cell.accessoryType = .checkmark
                cell.tintColor = UIColor(named: "Purple")
                
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "АКТИВНОСТЬ"
        
    }
}
