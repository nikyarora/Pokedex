
//
//  UserData.swift
//  Pokedex
//
//  Created by Max Miranda on 2/16/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class UserData: NSObject {
    static var faves: [String]?
    static let defaults = UserDefaults.standard
    
    static func removeFromFavorites (name: String) {
        faves!.remove(at: faves!.index(of: name)!)
    }
    static func addToFavorites (name: String) {
        if faves == nil {
            faves = defaults.array(forKey: defaultsKeys.favorites) as! [String]?
        }
        if (!faves!.contains(name)) {
            faves!.append(name)
        }
        defaults.setValue([name], forKey: defaultsKeys.favorites)
    }

    struct defaultsKeys {
        static let favorites = "Favorites"
    }
}
