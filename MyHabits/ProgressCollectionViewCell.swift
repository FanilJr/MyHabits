//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Fanil_Jr on 13.06.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progressLevel: Float? {
        
        didSet {
            
            progressView.progress = progressLevel ?? 0
            
        }
    }
    
    private let textLabel: UILabel = {
        
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        text.text = "Всё получится!"
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
        
    }()
    
    var resultProgress: UILabel = {
        
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        result.textColor = .systemGray
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
        
    }()
    
    private var progressView: UIProgressView = {
        
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(named: "Purple")
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        resultProgress.text = "\(Int(progressView.progress * 100))%"
        backgroundColor = .white
        self.layer.cornerRadius = 8
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
        
    }
}


extension ProgressCollectionViewCell {
    
    func setup() {
        
        [textLabel, resultProgress, progressView].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            resultProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            resultProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            
        ])
    }
}
