//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Fanil_Jr on 13.06.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let collectionsView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsView.backgroundColor = UIColor(named: "LightGray")
        collectionsView.delegate = self
        collectionsView.dataSource = self
        
        setup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionsView.reloadData()
    }
    
    func bluer() {
        let bluer = UIBlurEffect(style: .light)
        let bluerEffect = UIVisualEffectView(effect: bluer)
        bluerEffect.frame = (tabBarController?.tabBar.bounds)!
        //view.addSubview(bluerEffect)
        
        //navigationController?.navigationBar.addSubview(bluerEffect)
    }
}

private extension HabitsViewController {
    
    private func setup() {
        
        view.addSubview(collectionsView)
        
        NSLayoutConstraint.activate([
            collectionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension HabitsViewController: HabitCollectionViewCellDelegate {
    
    func updateData() {
        
        collectionsView.reloadData()
        
    }
}

extension HabitsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            
            let habitDetailsView = HabitDetailsViewController()
            habitDetailsView.habit = HabitsStore.shared.habits[indexPath.row]
            habitDetailsView.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsView, animated: true)
            
        }
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return 1
        case 1:
            return HabitsStore.shared.habits.count
        default:
            return 0
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as! ProgressCollectionViewCell
            cell.progressLevel = HabitsStore.shared.todayProgress
            cell.resultProgress.text = "\(Int((cell.progressLevel ?? 0) * 100))%"
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as! HabitCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            cell.delegate = self
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
            
        case 0:
            var size = CGSize()
            size.width = (collectionView.frame.width - 33)
            size.height = 60
            return size
        case 1:
            var size = CGSize()
            size.width = (collectionView.frame.width - 33)
            size.height = 130
            return size
        default:
            return CGSize()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 17)
        
    }
}




