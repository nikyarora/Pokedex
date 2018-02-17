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
    var favesLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTabBarVC = tabBarController as! MyTabBarController
        loadLayout()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadLayout()
        favesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        favesLabel.text = "Favorites"
        favesLabel.font = UIFont(name: "Lato-Regular", size: 26)
        favesLabel.textAlignment = .center
        view.addSubview(favesLabel)
        myTabBarVC.nav.titleView = favesLabel;
        myTabBarVC.nav.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    func loadLayout() {
        pokemonTableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.minY, width: view.frame.width, height: view.frame.height))
        pokemonTableView.register(FavoritesListCell.self, forCellReuseIdentifier: "pokemonCell")
        pokemonTableView.delegate = self as! UITableViewDelegate
        pokemonTableView.dataSource = self as! UITableViewDataSource
        pokemonTableView.rowHeight = 50
        view.addSubview(pokemonTableView)
    }
    override func viewWillDisappear(_ animated: Bool) {
        favesLabel.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserData.faves == nil {
            return 0
        }
        return UserData.faves!.count
    }
    
    // Setting up cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! FavoritesListCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        let pokemonInCell = UserData.faves![indexPath.row]
        cell.pokemonNameList.text = pokemonInCell
        cell.pokemonNameList.frame.origin.y = tableView.rowHeight / 2 - cell.pokemonNameList.frame.height/2
        cell.pokemonNameList.sizeToFit()
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
