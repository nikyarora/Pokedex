//
//  ListTableViewCell.swift
//  Pokedex
//
//  Created by Niky Arora on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    var pokemonImageList: UIImageView!
    var pokemonNameList: UILabel!
    var pokemonNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonImageList = UIImageView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        pokemonNameList = UILabel(frame: CGRect(x: 30, y: 0, width: 50, height: 50))
        pokemonNameList.textColor = .black
        pokemonNameList.font = UIFont(name: "Pokemon Classic", size: 9.0)
        pokemonNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        pokemonNumber.textColor = .black
        pokemonNumber.font = UIFont(name: "Pokemon Classic", size: 11.0)
        contentView.addSubview(pokemonImageList)
        contentView.addSubview(pokemonNameList)
        contentView.addSubview(pokemonNumber)
    }

}
