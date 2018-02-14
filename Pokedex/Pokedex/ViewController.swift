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
    
    //Buttons and Labels
    var randButton: UIButton!
    var attackPoints: UIButton!
    var attackPointsLab: UILabel!
    var defensePoints: UIButton!
    var defensePointsLab: UILabel!
    var healthPoints: UIButton!
    var healthPointsLab: UILabel!
    var attributesLabel: UILabel!
    var typeLabel: UILabel!
    
    var minAttack: Int = 0
    var minDefense: Int = 0
    var minHealth: Int = 0
    
    //Type Scroll View
    let screenWidth = UIScreen.main.bounds.size.width
    var scrollView: LTInfiniteScrollView!
    var pokemonType: [UIImageView] = []
    var pokemonTypeNames = ["bug", "grass", "dark", "ground", "dragon", "ice", "electric", "normal", "fairy",
    "poison", "fighting", "psychic", "fire", "rock", "flying", "steel", "ghost", "water"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeSearch()
        initializeRandButton()
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
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.55, green:0.58, blue:0.25, alpha:1.0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func initializeRandButton(){
        randButton = UIButton(frame: CGRect(x: 20, y: view.frame.maxY - 75, width: (view.frame.width / 2) - 20, height: 50))
        randButton.layer.cornerRadius = 25
        randButton.setTitle("Random", for: .normal)
        randButton.titleLabel?.font = UIFont(name: "Pokemon Classic", size: 14.0)
        randButton.backgroundColor = UIColor(red:0.42, green:0.71, blue:0.90, alpha:1.0)
        randButton.addTarget(self, action: #selector(generateRandomPokemon), for: .touchUpInside)
        view.addSubview(randButton)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListScreen" {
            //send stuff
        }
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
        attackPointsLab.font = UIFont(name: "Pokemon Classic", size: 12.0)
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
        defensePointsLab.font = UIFont(name: "Pokemon Classic", size: 12.0)
        defensePointsLab.textColor = .white
        defensePointsLab.frame = CGRect(x: view.frame.width - (defensePointsLab.intrinsicContentSize.width) - 15, y: defensePoints.frame.minY + (defensePoints.frame.height / 2) - 10, width: defensePointsLab.intrinsicContentSize.width, height: 20)
        view.addSubview(defensePointsLab)
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
        healthPointsLab.font = UIFont(name: "Pokemon Classic", size: 12.0)
        healthPointsLab.textColor = .white
        healthPointsLab.frame = CGRect(x: view.frame.width - (healthPointsLab.intrinsicContentSize.width) - 15, y: healthPoints.frame.minY + (healthPoints.frame.height / 2) - 10, width: healthPointsLab.intrinsicContentSize.width, height: 20)
        view.addSubview(healthPointsLab)
    }
    
    func produceIntegerRangeError() {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid integer between 0 and 200", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension ViewController: LTInfiniteScrollViewDataSource {
    
    func viewAtIndex(_ index: Int, reusingView view: UIView?) -> UIView {
        if let label = view as? UILabel {
            label.text = pokemonTypeNames[index]
            return label
        }
        else {
            let size = screenWidth / CGFloat(numberOfVisibleViews())
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: size, height: size))
            label.textAlignment = .center
            label.backgroundColor = UIColor(red:0.55, green:0.58, blue:0.25, alpha:1.0)
            label.font = UIFont(name: "Pokemon Classic", size: 11.0)
            label.textColor = UIColor.white
            label.layer.cornerRadius = size / 2
            label.layer.masksToBounds = true
            label.text = pokemonTypeNames[index]
            return label
        }
    }
    
    func numberOfViews() -> Int {
        return 18
    }
    
    func numberOfVisibleViews() -> Int {
        return 5
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

