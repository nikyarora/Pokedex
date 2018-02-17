//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Max Miranda on 2/16/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITabBarControllerDelegate {
    
    var pokemonTableView: UITableView!
    var myTabBarVC : MyTabBarController!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTabBarVC = tabBarController as! MyTabBarController
        loadLayout()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(myTabBarVC.favorites)
        loadLayout()
    }
    func loadLayout() {
        pokemonTableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.minY, width: view.frame.width, height: view.frame.height))
        pokemonTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        pokemonTableView.delegate = self as! UITableViewDelegate
        pokemonTableView.dataSource = self as! UITableViewDataSource
        pokemonTableView.rowHeight = 50
        view.addSubview(pokemonTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTabBarVC.favorites.count
    }
    
    // Setting up cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! ListTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        let pokemonInCell = myTabBarVC.favorites[indexPath.row]
        let imageURL = URL(string: pokemonInCell.imageUrl)
        DispatchQueue.global().async {
            if(imageURL != nil) {
                let data = try? Data(contentsOf: imageURL!)
                DispatchQueue.main.async {
                    if let imageRetrieved = data {
                        cell.pokemonImageList.image = UIImage(data: imageRetrieved)
                    } else {
                        cell.pokemonImageList.image = #imageLiteral(resourceName: "Pokeball")
                    }
                }
            }
            else {
                cell.pokemonImageList.image = #imageLiteral(resourceName: "Pokeball")
            }
        }
        cell.pokemonNameList.text = pokemonInCell.name
        cell.pokemonNameList.sizeToFit()
        cell.pokemonNameList.frame.origin.y = tableView.rowHeight / 2 - cell.pokemonNameList.frame.height/2
        cell.pokemonNameList.frame.origin.x = cell.pokemonImageList.frame.maxX + 10
        cell.pokemonNameList.text = "#\(pokemonInCell.number!)" + " " + cell.pokemonNameList.text!
        cell.pokemonNumber.sizeToFit()
        cell.pokemonNumber.frame.origin.y = tableView.rowHeight / 2 - cell.pokemonNumber.frame.height / 2
        cell.pokemonNumber.frame.origin.x = view.frame.width - cell.pokemonNumber.frame.width - 15
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* pokemonSelected = pokemon[indexPath.row]
        performSegue(withIdentifier: "showProfileView", sender: nil)*/
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
