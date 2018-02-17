//
//  MyTabBarController.swift
//  Pokedex
//
//  Created by Max Miranda on 2/16/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    var favorites : [Pokemon] = []
    var pokemon : Pokemon!
    var nav : UINavigationItem!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        nav = navigationItem
        let tabOne = ProfileViewController()
        let image1 = UIImage(named: "Search")
        tabOne.tabBarItem = UITabBarItem(title: "Pokemon", image: image1, tag: 0)
        let tabTwo = FavoritesViewController()
        let image2 = UIImage(named: "Favorites")
        tabTwo.tabBarItem = UITabBarItem(title: "Favorites", image: image2, tag: 1)
        self.viewControllers = [tabOne, tabTwo]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.set(favorites, forKey: "favorites")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favorites = defaults.object(forKey: "favorites") as! [Pokemon]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(favorites, forKey: "favorites")
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subVC = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        print(favorites)
        subVC.favorites = favorites
        print(subVC.favorites)
    }*/
    
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
