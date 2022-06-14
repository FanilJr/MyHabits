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
        //collectionsView.delegate = self
        //collectionsView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionsView.reloadData()
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



