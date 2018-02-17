//
//  FavoritesListCellTableViewCell.swift
//  Pokedex
//
//  Created by Max Miranda on 2/16/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesListCell: UITableViewCell {
    var pokemonNameList: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pokemonNameList = UILabel(frame: CGRect(x: 35, y: 0, width: 50, height: 50))
        pokemonNameList.textColor = .black
        pokemonNameList.font = UIFont(name: "Pokemon Classic", size: 11.0)
        contentView.addSubview(pokemonNameList)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
