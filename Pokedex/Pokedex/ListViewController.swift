//
//  ListViewController.swift
//  Pokedex
//
//  Created by Niky Arora on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var segmentedControl: UISegmentedControl!
    var pokemonCollectionView: UIPokemonCollectionView!
    var pokemonTableView: UIPokemonTableView!
    var pokemonSelected: Pokemon!
    var pokemon: [Pokemon]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSegmentedControl()
    }
    
    func createSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["List", "Grid"])
        segmentedControl.setWidth(80, forSegmentAt: 0)
        segmentedControl.setWidth(80, forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .white
        segmentedControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    func changeView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            switchTableView()
        }
        else {
            switchGridView()
        }
    }
    
    func switchGridView() {
        let layout = UIPokemonCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        pokemonCollectionView = UIPokemonCollectionView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY + 30, width: view.frame.width, height: view.frame.height), pokemonCollectionViewLayout: layout)
        pokemonCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "pokemonCell")
        pokemonCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        pokemonCollectionView.backgroundColor = .white
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        view.addSubview(pokemonCollectionView)
    }
    
    func switchTableView() {
        pokemonTableView = UIPokemonTableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.minY, width: view.frame.width, height: view.frame.height))
        pokemonTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.rowHeight = 50
        view.addSubview(pokemonTableView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! CollectionViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CollectionViewCell
        cell.pokemonImage.image = UIImage(named: pokemon[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
}

