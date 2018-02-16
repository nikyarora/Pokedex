//
//  CollectionViewCell.swift
//  Pokedex
//
//  Created by Niky Arora on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var pokemonImage: UIImageView!
    var pokemonCell: UIButton!
    var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonImage = UIImageView(frame: contentView.frame)
        pokemonImage.contentMode = .scaleAspectFill
        pokemonImage.clipsToBounds = true
        contentView.addSubview(pokemonImage)
        
        pokemonName = UILabel(frame: CGRect(x: 0, y: contentView.frame.height * 0.9, width: contentView.frame.width, height: contentView.frame.height * 0.1))
         pokemonName.clipsToBounds = true
        pokemonName.textColor = .black
        pokemonName.backgroundColor = .white
        pokemonName.font = UIFont(name: "Pokemon Classic", size: 11.0)
        
        contentView.addSubview(pokemonName)
        
        pokemonCell = UIButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width-50, height: contentView.frame.height-10))
        pokemonCell.backgroundColor = .white
        pokemonCell.sizeToFit()
        contentView.addSubview(pokemonCell)
        
        
    }
}
