//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Max Miranda on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var pokemon : Pokemon!
    var pokemonImageView: UIImageView!
    var pokemonImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNavBar()
        initializeImage()
        initializeInfoAndStatsBar()
        initializeStats()
        initializeWeb()
    }
    
    func initializeNavBar() {
        edgesForExtendedLayout = []
        var pokemonName = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        pokemonName.text = pokemon.name
        pokemonName.font = UIFont(name: "Lato-Regular", size: 26)
        pokemonName.textAlignment = .center
        view.addSubview(pokemonName)
        navigationItem.titleView = pokemonName;
    }
    
    func initializeFavorite() {
        
    }
    
    func initializeImage() {
        let imageURL = URL(string: pokemon.imageUrl)
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                if let retrievedImage = data {
                    self.pokemonImage = UIImage(data: retrievedImage)
                }
                else {
                    self.pokemonImage = #imageLiteral(resourceName: "Pokeball")
                }
                self.pokemonImageView = UIImageView(frame: CGRect(x: 140, y: 50, width: 150, height: 200))
                self.pokemonImageView.image = self.pokemonImage
                self.pokemonImageView.contentMode = .scaleAspectFit
                self.pokemonImageView.clipsToBounds = true
                self.view.addSubview(self.pokemonImageView)
            }
        }
    }
    
    func initializeInfoAndStatsBar() {
        var bar = UILabel(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 50))
        bar.backgroundColor = .black
        view.addSubview(bar)
        
        var infoLabel = UILabel(frame: CGRect(x: 0, y: 300, width: view.frame.width/2, height: 50))
        infoLabel.text = "INFO:"
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Lato-Regular", size: 26)
        view.addSubview(infoLabel)
        
        var statsLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: 300, width: view.frame.width/2, height: 50))
        statsLabel.text = "STATS:"
        statsLabel.textColor = .white
        statsLabel.textAlignment = .center
        statsLabel.font = UIFont(name: "Lato-Regular", size: 26)
        view.addSubview(statsLabel)
        initializeInfo()
        initializeStats()
    }
    
    func initializeInfo() {
        var numberLabel = UILabel(frame: CGRect(x: 20, y: 380, width: view.frame.width/2 - 20, height: 70))
        numberLabel.text = "Number: \(pokemon.number!)"
        numberLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(numberLabel)
        
        var typeLabel = UILabel(frame: CGRect(x: 20, y: 460, width: view.frame.width/2 - 20, height: 70))
        if (pokemon.types.count > 1) {
            typeLabel.text = "Type: \(pokemon.types[0] + ", " + pokemon.types[1])"
        } else {
            typeLabel.text = "Type: \(pokemon.types[0])"
        }
        typeLabel.lineBreakMode = .byWordWrapping
        typeLabel.numberOfLines = 2
        typeLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(typeLabel)
        
        var speciesLabel = UILabel(frame: CGRect(x: 20, y: 540, width: view.frame.width/2 - 20, height: 70))
        speciesLabel.text = "Species: \(pokemon.species!)"
        speciesLabel.lineBreakMode = .byWordWrapping
        speciesLabel.numberOfLines = 3
        speciesLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(speciesLabel)
    }

    func initializeStats() {
        var HPLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 380, width: view.frame.width/2, height: 30))
        HPLabel.text = "HP: \(pokemon.health!)"

        var attackLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 415, width: view.frame.width/2, height: 30))
        attackLabel.text = "Attack: \(pokemon.attack!)"

        var defenseLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 450, width: view.frame.width/2, height: 30))
        defenseLabel.text = "Attack: \(pokemon.defense!)"
        
        var spAtkLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 485, width: view.frame.width/2, height: 30))
        spAtkLabel.text = "Sp. Def: \(pokemon.specialAttack!)"
        
        var spDefLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 520, width: view.frame.width/2, height: 30))
        spDefLabel.text = "Sp. Atk: \(pokemon.specialDefense!)"
        
        var speedLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 555, width: view.frame.width/2, height: 30))
        speedLabel.text = "Speed: \(pokemon.speed!)"
        
        var totalLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 590, width: view.frame.width/2, height: 30))
        totalLabel.text = "Total: \(pokemon.total!)"

        for label in [HPLabel, attackLabel, defenseLabel, spAtkLabel, spDefLabel, speedLabel, totalLabel] {
            label.font = UIFont(name: "Pokemon Classic", size: 14)
            view.addSubview(label)

        }





    }

    func initializeWeb() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
