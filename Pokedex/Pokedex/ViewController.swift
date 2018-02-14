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
    
    let screenWidth = UIScreen.main.bounds.size.width
    var scrollView: LTInfiniteScrollView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeSearch()
        initializeRandButton()
        
        scrollView = LTInfiniteScrollView(frame: CGRect(x: 0, y: 200, width: view.frame.width + 2, height: 80))
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.maxScrollDistance = 5
        
        let size = screenWidth / CGFloat(numberOfVisibleViews())
        
        scrollView.contentInset.left = screenWidth / 2 - size / 2
        scrollView.contentInset.right = screenWidth / 2 - size / 2
        
        view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.reloadData(initialIndex: 0)
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

extension ViewController: LTInfiniteScrollViewDataSource {
    
    func viewAtIndex(_ index: Int, reusingView view: UIView?) -> UIView {
        if let label = view as? UILabel {
            label.text = "\(index)"
            return label
        }
        else {
            let size = screenWidth / CGFloat(numberOfVisibleViews())
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: size, height: size))
            label.textAlignment = .center
            label.backgroundColor = UIColor.darkGray
            label.textColor = UIColor.white
            label.layer.cornerRadius = size / 2
            label.layer.masksToBounds = true
            label.text = "\(index)"
            return label
        }
    }
    
    func numberOfViews() -> Int {
        return 10
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

