//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    //Pokemon Array
    var pokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    
    //Random Pokemon
    var sendPokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    var rands: [Int] = []
    
    //Search Variables
    var searchBar: UISearchBar!
    var searchText: String!
    
    //Buttons
    var randButton: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeSearch()
        initializeRandButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeSearch(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.backgroundColor = .blue
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func initializeRandButton(){
        randButton = UIButton(frame: CGRect(x: 0, y: view.frame.maxY - 50, width: (view.frame.width / 2), height: 50))
        randButton.setTitle("Random", for: .normal)
        randButton.titleLabel?.font = UIFont(name: "Pokemon Classic", size: 14.0)
        //randButton.titleLabel?.setTextSpacing(spacing: 0.7)
        randButton.backgroundColor = UIColor(red:0.42, green:0.71, blue:0.90, alpha:1.0)
        randButton.addTarget(self, action: #selector(generateRandomPokemon), for: .touchUpInside)
        view.addSubview(randButton)
    }
    
    func dismissKeyboard(){
        navigationItem.titleView?.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListScreen" {
            //send stuff
        }
    }
    
    func generateRandomPokemon() {
        sendPokemon.removeAll()
        for i in 0...20 {
            let rand = getRand(index: i)
            rands.append(rand)
            sendPokemon.append(pokemon[rand])
        }
        rands.removeAll()
        performSegue(withIdentifier: "showListScreen", sender: randButton)
    }
    
    func getRand(index: Int) -> Int {
        var i = index
        while rands.contains(i) {
            i = Int(arc4random_uniform(UInt32(pokemon.count)))
        }
        return i
    }

}

