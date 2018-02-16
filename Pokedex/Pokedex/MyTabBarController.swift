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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabOne = ViewController()
        let image1 = UIImage(named: "Search")
        tabOne.tabBarItem = UITabBarItem(title: "Search", image: image1, tag: 0)
        let tabTwo = FavoritesViewController()
        let image2 = UIImage(named: "Favorites")
        tabTwo.tabBarItem = UITabBarItem(title: "Favorites", image: image2, tag: 1)
        self.viewControllers = [tabOne, tabTwo]
        // Do any additional setup after loading the view.
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
