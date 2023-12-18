//
//  EmojiesCell.swift
//  MyEmojiMixer
//
//  Created by Toto Tsipun on 09.11.2023.
//

import UIKit

final class EmojiesCell: UICollectionViewCell {
    
    let labelForCell = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(labelForCell)
        labelForCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelForCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelForCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

