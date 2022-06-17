//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Fanil_Jr on 13.06.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        
        didSet {
            
            namelabel.text = habit?.name
            namelabel.textColor = habit?.color
            dateLabel.text = habit?.dateString
            trackLabel.text = "Счётчик \(habit?.trackDates.count ?? 0)"
            if ((habit?.isAlreadyTakenToday) == true) {
                
                imageView.image = UIImage.init(systemName: "checkmark.circle.fill")
            } else {
                imageView.image = UIImage.init(systemName: "circle")
                
            }
        }
    }
    
    var delegate: HabitCollectionViewCellDelegate?
    
    private let namelabel: UILabel = {
        
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
        
    }()
    
    private let dateLabel: UILabel = {
        
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        date.textColor = .systemGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
        
    }()
    
    private let trackLabel: UILabel = {
        
        let track = UILabel()
        track.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        track.textColor = .systemGray
        track.translatesAutoresizingMaskIntoConstraints = false
        return track
        
    }()
    
    let imageView: UIImageView = {
        
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 38/2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.layer.cornerRadius = 8
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trackHabitGesture))
        imageView.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
}

protocol HabitCollectionViewCellDelegate {
    
    func updateData()
    
}

private extension HabitCollectionViewCell {
    
    @objc func trackHabitGesture(gesture: UITapGestureRecognizer) {
        
        if(habit?.isAlreadyTakenToday == false) {
            
            HabitsStore.shared.track(habit!)
            delegate?.updateData()
            
        }
    }
    
    func setup() {
        
        [namelabel, dateLabel, trackLabel, imageView].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            namelabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            namelabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: -40),
        
            dateLabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor,constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            trackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            trackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -25),
            imageView.heightAnchor.constraint(equalToConstant: 38),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            
        ])
    }
}
