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
    var pokemonCollectionView: UICollectionView!
    var pokemonTableView: UITableView!
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
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        pokemonCollectionView = UICollectionView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY + 30, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        pokemonCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "pokemonCell")
        pokemonCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        pokemonCollectionView.backgroundColor = .white
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        view.addSubview(pokemonCollectionView)
    }
    
    func switchTableView() {
        pokemonTableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.minY, width: view.frame.width, height: view.frame.height))
        pokemonTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.rowHeight = 50
        view.addSubview(pokemonTableView)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "..." {
            //do something
        }
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
        let pokemonInCell = pokemon[indexPath.row]
        let imageURL = URL(string: pokemonInCell.imageUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                if let retrievedImage = data {
                    cell.pokemonImage.image = UIImage(data: retrievedImage)
                }
                else {
                    cell.pokemonImage.image = #imageLiteral(resourceName: "fire")
                }
            }
        }
        
        cell.pokemonName.text = pokemonInCell.name
        cell.pokemonName.text = "#00\(pokemonInCell.number!)" + " " + cell.pokemonName.text!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/3, height: view.frame.width/3 + 20)
    }
    
    func collectionView(_ tableView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemonSelected = pokemon[indexPath.row]
        performSegue(withIdentifier: "...", sender: nil)
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    // Setting up cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! ListTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview() //remove stuff from cell before initializing
        }
        cell.awakeFromNib() //initialize cell
        let pokemonInCell = pokemon[indexPath.row]
        // retrieving images
        let imageURL = URL(string: pokemonInCell.imageUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                if let imageRetrieved = data {
                    cell.pokemonImageList.image = UIImage(data: imageRetrieved)
                } else {
                    cell.pokemonImageList.image = #imageLiteral(resourceName: "fire")
                }
            }
        }
        cell.pokemonNameList.text = pokemonInCell.name
        cell.pokemonNameList.sizeToFit()
        cell.pokemonNameList.frame.origin.y = tableView.rowHeight / 2 - cell.pokemonNameList.frame.height/2
        cell.pokemonNameList.frame.origin.x = cell.pokemonImageList.frame.maxX + 10
        cell.pokemonNameList.text = "#00\(pokemonInCell.number!)" + " " + cell.pokemonNameList.text!
        cell.pokemonNumber.sizeToFit()
        cell.pokemonNumber.frame.origin.y = tableView.rowHeight / 2 - cell.pokemonNumber.frame.height / 2
        cell.pokemonNumber.frame.origin.x = view.frame.width - cell.pokemonNumber.frame.width - 15
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSelected = pokemon[indexPath.row]
        performSegue(withIdentifier: "...", sender: nil)
    }
}


