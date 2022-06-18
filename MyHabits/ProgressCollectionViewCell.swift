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
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        textLabel.text = "Всё получится!"
        textLabel.textColor = .systemGray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    var resultProgressBarLabel: UILabel = {
        let resultProgressBarLabel = UILabel()
        resultProgressBarLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        resultProgressBarLabel.textColor = .systemGray
        resultProgressBarLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultProgressBarLabel
    }()
    
    private var progressView: UIProgressView = {
        var habitsProgressView = UIProgressView()
        habitsProgressView.progressTintColor = UIColor(named: "Purple")
        habitsProgressView.translatesAutoresizingMaskIntoConstraints = false
        return habitsProgressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        resultProgressBarLabel.text = "\(Int(progressView.progress * 100))%"
        backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
}

private extension ProgressCollectionViewCell {
    func setupConstraints() {
        contentView.addSubview(textLabel)
        contentView.addSubview(resultProgressBarLabel)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            resultProgressBarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            resultProgressBarLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

