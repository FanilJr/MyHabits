//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Fanil_Jr on 13.06.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
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
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
