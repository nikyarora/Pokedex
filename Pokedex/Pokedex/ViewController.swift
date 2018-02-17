//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITabBarControllerDelegate {
    
    //Pokemon Array
    var pokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    
    //Random Pokemon
    var rands: [Int] = []
    var sendPokemon = PokemonGenerator.getPokemonArray()

    
    //Search Variables
    var searchBar: UISearchBar!
    var searchText: String!
    
    //Buttons and Labels
    var randButton: UIButton!
    var searchButton: UIButton!
    var attackPoints: UIButton!
    var attackPointsLab: UILabel!
    var defensePoints: UIButton!
    var defensePointsLab: UILabel!
    var healthPoints: UIButton!
    var healthPointsLab: UILabel!
    var attributesLabel: UILabel!
    var typeLabel: UILabel!
    
    //Attributes
    var minAttack: Int = 0
    var minDefense: Int = 0
    var minHealth: Int = 0
    
    //Type Scroll View
    var directPokemon: Pokemon!
    let screenWidth = UIScreen.main.bounds.size.width
    var scrollView: LTInfiniteScrollView!
    var pokemonType: [UIImageView] = []
    var pokemonTypeNames = ["bug", "grass", "dark", "ground", "dragon", "ice", "electric", "normal", "fairy",
    "poison", "fighting", "psychic", "fire", "rock", "flying", "steel", "ghost", "water"]
    var pokemonTypeImagesDim = [#imageLiteral(resourceName: "bug_dim"), #imageLiteral(resourceName: "grass_dim"), #imageLiteral(resourceName: "dark_dim"), #imageLiteral(resourceName: "ground_dim"), #imageLiteral(resourceName: "dragon_dim"), #imageLiteral(resourceName: "ice_dim"), #imageLiteral(resourceName: "electric_dim"), #imageLiteral(resourceName: "normal_dim"), #imageLiteral(resourceName: "fairy_dim"), #imageLiteral(resourceName: "poison_dim"), #imageLiteral(resourceName: "fighting_dim"), #imageLiteral(resourceName: "psychic_dim"), #imageLiteral(resourceName: "fire_dim"), #imageLiteral(resourceName: "rock_dim"), #imageLiteral(resourceName: "flying_dim"), #imageLiteral(resourceName: "steel_dim"), #imageLiteral(resourceName: "ghost_dim"), #imageLiteral(resourceName: "water_dim")]
    var pokemonTypeImages = [#imageLiteral(resourceName: "bug"), #imageLiteral(resourceName: "grass"), #imageLiteral(resourceName: "dark"), #imageLiteral(resourceName: "ground"), #imageLiteral(resourceName: "dragon"), #imageLiteral(resourceName: "ice"), #imageLiteral(resourceName: "electric"), #imageLiteral(resourceName: "normal"), #imageLiteral(resourceName: "fairy"), #imageLiteral(resourceName: "poison"), #imageLiteral(resourceName: "fighting"), #imageLiteral(resourceName: "psychic"), #imageLiteral(resourceName: "fire"), #imageLiteral(resourceName: "rock"), #imageLiteral(resourceName: "flying"), #imageLiteral(resourceName: "steel"), #imageLiteral(resourceName: "ghost"), #imageLiteral(resourceName: "water")]
    var selectedTypes: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearch()
        initializeRandButton()
        initializeSearchButton()
        initializeScrollView()
        initializeTitleLabels()
        initializeAttackPoints()
        initializeDefensePoints()
        initializeHealthPoints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.reloadData(initialIndex: 0)
    }
    
    func initializeTitleLabels() {
        typeLabel = UILabel(frame: CGRect(x: 15, y: (navigationController?.navigationBar.frame.maxY)! + 10, width: view.frame.width, height: 50))
        typeLabel.text = "Types: "
        typeLabel.font = UIFont(name: "Pokemon Classic", size: 16.0)
        view.addSubview(typeLabel)
        
        attributesLabel = UILabel(frame: CGRect(x: 15, y: scrollView.frame.maxY + 50, width: view.frame.width, height: 50))
        attributesLabel.text = "Attributes: "
        attributesLabel.font = UIFont(name: "Pokemon Classic", size: 16.0)
        view.addSubview(attributesLabel)
    }
    
    func initializeSearch(){
        automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        searchBar = UISearchBar()
        searchBar.delegate = self as? UISearchBarDelegate
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.55, green:0.58, blue:0.25, alpha:1.0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text
        print(searchText)
        generateSearchWithText()
    }
    
    func initializeRandButton(){
        randButton = UIButton(frame: CGRect(x: 20, y: view.frame.maxY - 110, width: (view.frame.width / 2) - 20, height: 50))
        randButton.layer.cornerRadius = 25
        randButton.setTitle("Random", for: .normal)
        randButton.titleLabel?.font = UIFont(name: "Pokemon Classic", size: 14.0)
        randButton.backgroundColor = UIColor(red:0.42, green:0.71, blue:0.90, alpha:1.0)
        randButton.addTarget(self, action: #selector(generateRandomPokemon), for: .touchUpInside)
        view.addSubview(randButton)
    }
    
    func initializeSearchButton() {
        searchButton = UIButton(frame: CGRect(x: view.frame.width/2 + 10, y: view.frame.maxY - 110, width: (view.frame.width / 2) - 20, height: 50))
        searchButton.layer.cornerRadius = 25
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "Pokemon Classic", size: 14.0)
        searchButton.backgroundColor = UIColor(red:0.42, green:0.71, blue:0.90, alpha:1.0)
        searchButton.addTarget(self, action: #selector(generateSearchWithButton), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    func initializeScrollView() {
        scrollView = LTInfiniteScrollView(frame: CGRect(x: 0, y: 175, width: view.frame.width + 2, height: 50))
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.maxScrollDistance = 5
        
        let size = screenWidth / CGFloat(numberOfVisibleViews())
        
        scrollView.contentInset.left = screenWidth / 2 - size / 2
        scrollView.contentInset.right = screenWidth / 2 - size / 2
        
        view.addSubview(scrollView)
    }
    
    func dismissKeyboard(){
        navigationItem.titleView?.endEditing(true)
    }
    
    func initializeAttackPoints() {
       attackPoints = UIButton(frame: CGRect(x:0, y:attributesLabel.frame.maxY + 10, width: view.frame.width, height: 50))
        attackPoints.backgroundColor = UIColor(red:0.32, green:0.32, blue:0.13, alpha:1.0)
        attackPoints.layer.cornerRadius = 25
        attackPoints.titleLabel?.font = UIFont(name: "Pokemon Classic", size:12.0)
        attackPoints.setTitle("Attack Points", for: .normal)
        view.addSubview(attackPoints)
        
        attackPointsLab = UILabel(frame: CGRect(x: 0, y: attackPoints.frame.minY + (attackPoints.frame.height / 2) - 10, width: view.frame.width, height: 20))
        attackPointsLab.text = "0-200"
        attackPointsLab.font = UIFont(name: "Pokemon Classic", size: 10.0)
        attackPointsLab.textColor = .white
        attackPointsLab.frame = CGRect(x: view.frame.width - (attackPointsLab.intrinsicContentSize.width) - 15, y: attackPoints.frame.minY + (attackPoints.frame.height / 2) - 10, width: attackPointsLab.intrinsicContentSize.width, height: 20)
        view.addSubview(attackPointsLab)
        
        attackPoints.addTarget(self, action: #selector(attackPointsPressed), for: .touchUpInside)
    }
    
    func attackPointsPressed(sender: UIButton) {
        let alertAction = UIAlertController(title: "Enter Minimum Attack Points", message: nil, preferredStyle: .alert)
        alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertAction.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Minimum"
        })
        
        alertAction.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            
                let text = alertAction.textFields?.first?.text
                let num = Int(text!)!
                if num >= 0 && num <= 200 {
                    self.minAttack = Int(text!)!
                    self.attackPointsLab.text = text! + "-200"
                    self.resizeAttackLabel()
                }
                else {
                    self.produceIntegerRangeError()
                }
        }))
        self.present(alertAction, animated: true)
    }
    
    func resizeAttackLabel() {
        attackPointsLab.frame = CGRect(x: view.frame.width - (attackPointsLab.intrinsicContentSize.width) - 15, y: attackPoints.frame.minY + (attackPoints.frame.height / 2) - 10, width: attackPointsLab.intrinsicContentSize.width, height: 20)
    }
    
    
    func initializeDefensePoints() {
        defensePoints = UIButton(frame: CGRect(x:0, y:attributesLabel.frame.maxY + 100, width: view.frame.width, height: 50))
        defensePoints.backgroundColor = UIColor(red:0.32, green:0.32, blue:0.13, alpha:1.0)
        defensePoints.layer.cornerRadius = 25
        defensePoints.titleLabel?.font = UIFont(name: "Pokemon Classic", size:12.0)
        defensePoints.setTitle("Defense Points", for: .normal)
        view.addSubview(defensePoints)
        
        defensePointsLab = UILabel(frame: CGRect(x: 0, y: defensePoints.frame.minY + (defensePoints.frame.height / 2) - 10, width: view.frame.width, height: 20))
        defensePointsLab.text = "0-200"
        defensePointsLab.font = UIFont(name: "Pokemon Classic", size: 10.0)
        defensePointsLab.textColor = .white
        defensePointsLab.frame = CGRect(x: view.frame.width - (defensePointsLab.intrinsicContentSize.width) - 15, y: defensePoints.frame.minY + (defensePoints.frame.height / 2) - 10, width: defensePointsLab.intrinsicContentSize.width, height: 20)
        view.addSubview(defensePointsLab)
        
         defensePoints.addTarget(self, action: #selector(defensePointsPressed), for: .touchUpInside)
    }
    
    func defensePointsPressed(sender: UIButton) {
        let alertAction = UIAlertController(title: "Enter Minimum Defense Points", message: nil, preferredStyle: .alert)
        alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertAction.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Minimum"
        })
        
        alertAction.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            
            let text = alertAction.textFields?.first?.text
            let num = Int(text!)!
            if num >= 0 && num <= 200 {
                self.minDefense = Int(text!)!
                self.defensePointsLab.text = text! + "-200"
                self.resizeDefenseLabel()
            }
            else {
                self.produceIntegerRangeError()
            }
        }))
        self.present(alertAction, animated: true)
    }
    
    func resizeDefenseLabel() {
        defensePointsLab.frame = CGRect(x: view.frame.width - (defensePointsLab.intrinsicContentSize.width) - 15, y: defensePoints.frame.minY + (defensePoints.frame.height / 2) - 10, width: defensePointsLab.intrinsicContentSize.width, height: 20)
    }
    
    func initializeHealthPoints() {
        healthPoints = UIButton(frame: CGRect(x:0, y:attributesLabel.frame.maxY + 200, width: view.frame.width, height: 50))
        healthPoints.backgroundColor = UIColor(red:0.32, green:0.32, blue:0.13, alpha:1.0)
        healthPoints.layer.cornerRadius = 25
        healthPoints.titleLabel?.font = UIFont(name: "Pokemon Classic", size:12.0)
        healthPoints.setTitle("Health Points", for: .normal)
        view.addSubview(healthPoints)
        
        healthPointsLab = UILabel(frame: CGRect(x: 0, y: healthPoints.frame.minY + (healthPoints.frame.height / 2) - 10, width: view.frame.width, height: 20))
        healthPointsLab.text = "0-200"
        healthPointsLab.font = UIFont(name: "Pokemon Classic", size: 10.0)
        healthPointsLab.textColor = .white
        healthPointsLab.frame = CGRect(x: view.frame.width - (healthPointsLab.intrinsicContentSize.width) - 15, y: healthPoints.frame.minY + (healthPoints.frame.height / 2) - 10, width: healthPointsLab.intrinsicContentSize.width, height: 20)
        view.addSubview(healthPointsLab)
        
        healthPoints.addTarget(self, action: #selector(healthPointsPressed), for: .touchUpInside)
    }
    
    func healthPointsPressed(sender: UIButton) {
        let alertAction = UIAlertController(title: "Enter Minimum Health Points", message: nil, preferredStyle: .alert)
        alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertAction.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Minimum"
        })
        
        alertAction.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            
            let text = alertAction.textFields?.first?.text
            let num = Int(text!)!
            if num >= 0 && num <= 200 {
                self.minHealth = Int(text!)!
                self.healthPointsLab.text = text! + "-200"
                self.resizeHealthLabel()
            }
            else {
                self.produceIntegerRangeError()
            }
        }))
        self.present(alertAction, animated: true)
    }
    
    func resizeHealthLabel() {
        healthPointsLab.frame = CGRect(x: view.frame.width - (healthPointsLab.intrinsicContentSize.width) - 15, y: healthPoints.frame.minY + (healthPoints.frame.height / 2) - 10, width: healthPointsLab.intrinsicContentSize.width, height: 20)
    }
    
    func produceIntegerRangeError() {
        let alert = UIAlertController(title: "Error", message: "You must enter a valid integer between 0 and 200.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func generateRandomPokemon() {
        sendPokemon.removeAll()
        for _ in 0..<20 {
            let rand = getRand(index: Int(arc4random_uniform(UInt32(pokemon.count))))
            rands.append(rand)
            sendPokemon.append(pokemon[rand])
        }
        rands.removeAll()
        performSegue(withIdentifier: "showListScreen", sender: nil)
    }
    
    func getRand(index: Int) -> Int {
        var i = index
        while rands.contains(i) {
            i = Int(arc4random_uniform(UInt32(pokemon.count)))
        }
        return i
    }
    
    func generateSearchWithText() {
        sendPokemon.removeAll()
        if searchText != "" {
            //let selectedTypesSet: Set<String> = Set(typesToSearch)
            for pokemon in pokemon {
                if pokemon.name.lowercased() == searchText.lowercased() || Int(searchText) == pokemon.number {
                    directPokemon = pokemon
                    performSegue(withIdentifier: "seeProfile", sender: self)
                    return
                } else if pokemon.name.lowercased().contains(searchText.lowercased()) {
                    //let pokemonTypeSet: Set<String> = Set(pokemon.types)
                    //if selectedTypesSet.intersection(pokemonTypeSet).count > 0 && pokemon.attack >= minAttack && pokemon.defense > minDefense && pokemon.health > minHealth { //if pokemon's types fall under search types and stat conditions met
                        sendPokemon.append(pokemon)
                    //}
                }
            }
            performSegue(withIdentifier: "showListScreen", sender: nil)
        }
        else {
            //let selectedTypesSet: Set<String> = Set(typesToSearch)
            for pokemon in pokemon {
                //let pokemonTypeSet: Set<String> = Set(pokemon.types)
                //if selectedTypesSet.intersection(pokemonTypeSet).count > 0 && pokemon.attack >= minAttack && pokemon.defense > minDefense && pokemon.health > minHealth {
                    sendPokemon.append(pokemon)
                //}
            }
            performSegue(withIdentifier: "showListScreen", sender: nil)
        }
    }
    
    func generateSearchWithButton() {
        let selectedTypesSet: Set<String> = Set(selectedTypes)
        print(selectedTypesSet)
        for pokemon in pokemon {
            let pokemonTypeSet: Set<String> = Set(pokemon.types)
            if selectedTypesSet.intersection(pokemonTypeSet).count > 0 && pokemon.attack >= minAttack && pokemon.defense > minDefense && pokemon.health > minHealth {
                sendPokemon.append(pokemon)
                print(pokemon)
            }
        }
        performSegue(withIdentifier: "showListScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListScreen" {
            let listViewController = segue.destination as! ListViewController
            sendPokemon = sendPokemon.sorted{$0.name < $1.name}
            listViewController.pokemon = self.sendPokemon
        }
    }
}

extension ViewController: LTInfiniteScrollViewDataSource {
    
    func viewAtIndex(_ index: Int, reusingView view: UIView?) -> UIView {
        if let imageButton = view as? UIButton {
            imageButton.setImage(pokemonTypeImages[index], for: .normal)
            imageButton.setTitle(pokemonTypeNames[index], for: .normal)
            imageButton.addTarget(self, action: #selector(typeSelected), for: .touchUpInside)
            return imageButton
        }
        else {
            let size = screenWidth / CGFloat(numberOfVisibleViews())
            let imageButton = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
            imageButton.setImage(pokemonTypeImages[index], for: .normal)
            imageButton.setTitle(pokemonTypeNames[index], for: .normal)
            imageButton.addTarget(self, action: #selector(typeSelected), for: .touchUpInside)
            return imageButton
        }
    }
    
    func numberOfViews() -> Int {
        return 18
    }
    
    func numberOfVisibleViews() -> Int {
        return 5
    }
    
    func typeSelected(sender: UIButton!) {
        var title = sender.currentTitle
        if (title?.contains("_dim"))! {
            title?.removeSubrange(title?.endIndex.advanced(by: -4)..<title?.endIndex)
            sender.setTitle(title!, for: .normal)
            sender.setImage(UIImage(named: title!), for: .normal)
            let index = selectedTypes.index(of: title!)
            selectedTypes.remove(at: index!)
        } else {
            selectedTypes.append(sender.currentTitle!)
            title?.append("_dim")
            sender.setTitle(title!, for: .normal)
            sender.setImage(UIImage(named: title!), for: .normal)
            print(selectedTypes)
        }
    }
    
}

extension ViewController: LTInfiniteScrollViewDelegate {
    
    func updateView(_ view: UIView, withProgress progress: CGFloat, scrollDirection direction: LTInfiniteScrollView.ScrollDirection) {
        let size = screenWidth / CGFloat(numberOfVisibleViews())
        
        var transform = CGAffineTransform.identity
        // scale
        let scale = (1.4 - 0.3 * (fabs(progress)))
        transform = transform.scaledBy(x: scale, y: scale)
        
        // translate
        var translate = size / 4 * progress
        if progress > 1 {
            translate = size / 4
        }
        else if progress < -1 {
            translate = -size / 4
        }
        transform = transform.translatedBy(x: translate, y: 0)
        
        view.transform = transform
    }
    
    func scrollViewDidScrollToIndex(_ scrollView: LTInfiniteScrollView, index: Int) {
        print("scroll to index: \(index)")
    }
}

