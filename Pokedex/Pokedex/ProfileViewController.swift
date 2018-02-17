//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Max Miranda on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITabBarControllerDelegate {
    var pokemonImageView: UIImageView!
    var pokemonImage: UIImage!
    var myTabBarVC : MyTabBarController!

   // let homeScreen:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myTabBarVC = tabBarController as! MyTabBarController
        initializeNavBar()
        initializeImage()
        initializeInfoAndStatsBar()
        initializeStats()
        initializeWeb()
    }
    override func viewWillAppear(_ animated: Bool) {
        initializeNavBar()
    }
    
    func initializeNavBar() {
        edgesForExtendedLayout = []
        var pokemonName = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        pokemonName.text = myTabBarVC.pokemon.name
        pokemonName.font = UIFont(name: "Lato-Regular", size: 26)
        pokemonName.textAlignment = .center
        view.addSubview(pokemonName)
        myTabBarVC.nav.titleView = pokemonName;
        if (UserData.faves == nil || !UserData.faves!.contains(myTabBarVC.pokemon.name)) {
            myTabBarVC.nav.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            myTabBarVC.nav.rightBarButtonItem = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeFromFavorites))
        }
    }
    
    func addToFavorites() {
        UserData.addToFavorites(name: myTabBarVC.pokemon.name)
        myTabBarVC.nav.rightBarButtonItem = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeFromFavorites))

    }

    func removeFromFavorites() {
        UserData.removeFromFavorites(name: myTabBarVC.pokemon.name)
        myTabBarVC.nav.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addToFavorites))


    }
    
    func initializeImage() {
        let imageURL = URL(string: myTabBarVC.pokemon.imageUrl)
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                if let retrievedImage = data {
                    self.pokemonImage = UIImage(data: retrievedImage)
                }
                else {
                    self.pokemonImage = #imageLiteral(resourceName: "Pokeball")
                }
                self.pokemonImageView = UIImageView(frame: CGRect(x: 140, y: 80, width: 150, height: 200))
                self.pokemonImageView.center = CGPoint(x: self.view.frame.width/2, y: 170)
                self.pokemonImageView.image = self.pokemonImage
                self.pokemonImageView.contentMode = .scaleAspectFit
                self.pokemonImageView.clipsToBounds = true
                self.view.addSubview(self.pokemonImageView)
            }
        }
    }
    
    func initializeInfoAndStatsBar() {
        var bar = UILabel(frame: CGRect(x: 0, y: 310, width: view.frame.width, height: 50))
        bar.backgroundColor = .black
        view.addSubview(bar)
        
        var infoLabel = UILabel(frame: CGRect(x: 0, y: 310, width: view.frame.width/2, height: 50))
        infoLabel.text = "INFO:"
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Lato-Regular", size: 26)
        view.addSubview(infoLabel)
        
        var statsLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: 310, width: view.frame.width/2, height: 50))
        statsLabel.text = "STATS:"
        statsLabel.textColor = .white
        statsLabel.textAlignment = .center
        statsLabel.font = UIFont(name: "Lato-Regular", size: 26)
        view.addSubview(statsLabel)
        initializeInfo()
        initializeStats()
    }
    
    func initializeInfo() {
        var numberLabel = UILabel(frame: CGRect(x: 20, y: 360, width: view.frame.width/2 - 20, height: 70))
        numberLabel.text = "Number: \(myTabBarVC.pokemon.number!)"
        numberLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(numberLabel)
        
        var typeLabel = UILabel(frame: CGRect(x: 20, y: 440, width: view.frame.width/2 - 20, height: 70))
        if (myTabBarVC.pokemon.types.count > 1) {
            typeLabel.text = "Type: \(myTabBarVC.pokemon.types[0] + ", " + myTabBarVC.pokemon.types[1])"
        } else {
            typeLabel.text = "Type: \(myTabBarVC.pokemon.types[0])"
        }
        typeLabel.lineBreakMode = .byWordWrapping
        typeLabel.numberOfLines = 2
        typeLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(typeLabel)
        
        var speciesLabel = UILabel(frame: CGRect(x: 20, y: 520, width: view.frame.width/2 - 20, height: 70))
        speciesLabel.text = "Species: \(myTabBarVC.pokemon.species!)"
        speciesLabel.lineBreakMode = .byWordWrapping
        speciesLabel.numberOfLines = 3
        speciesLabel.font = UIFont(name: "Pokemon Classic", size: 16)
        view.addSubview(speciesLabel)
    }

    func initializeStats() {
        var HPLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 370, width: view.frame.width/2, height: 30))
        HPLabel.text = "HP: \(myTabBarVC.pokemon.health!)"

        var attackLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 405, width: view.frame.width/2, height: 30))
        attackLabel.text = "Attack: \(myTabBarVC.pokemon.attack!)"

        var defenseLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 440, width: view.frame.width/2, height: 30))
        defenseLabel.text = "Defense: \(myTabBarVC.pokemon.defense!)"
        
        var spAtkLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 475, width: view.frame.width/2, height: 30))
        spAtkLabel.text = "Sp. Def: \(myTabBarVC.pokemon.specialAttack!)"
        
        var spDefLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 510, width: view.frame.width/2, height: 30))
        spDefLabel.text = "Sp. Atk: \(myTabBarVC.pokemon.specialDefense!)"
        
        var speedLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 545, width: view.frame.width/2, height: 30))
        speedLabel.text = "Speed: \(myTabBarVC.pokemon.speed!)"
        
        var totalLabel = UILabel(frame: CGRect(x: view.frame.width/2 + 20, y: 580, width: view.frame.width/2, height: 30))
        totalLabel.text = "Total: \(myTabBarVC.pokemon.total!)"

        for label in [HPLabel, attackLabel, defenseLabel, spAtkLabel, spDefLabel, speedLabel, totalLabel] {
            label.font = UIFont(name: "Pokemon Classic", size: 14)
            view.addSubview(label)
        }
    }

    func initializeWeb() {
        var webButton = UIButton(frame: CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 50))
        webButton.backgroundColor = .black
        webButton.setTitle("Search on the Web", for: .normal)
        webButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 26)
        webButton.titleLabel?.textColor = .white
        webButton.titleLabel?.textAlignment = .center
        webButton.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
        view.addSubview(webButton)
    }
    
    func performSearch() {
        if let url = URL(string: "https://google.com/search?q=" + myTabBarVC.pokemon.name!) {
            UIApplication.shared.open(url, options: [:])
        }
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
