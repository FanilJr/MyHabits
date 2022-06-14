//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Fanil_Jr on 14.06.2022.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    let date: UILabel = {
        
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension HabitDetailsTableViewCell {
    
    func setup() {
        contentView.addSubview(date)
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 11),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -11)
        ])
    }
}
