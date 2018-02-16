//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Max Miranda on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNameLabel()
        // Do any additional setup after loading the view.
    }
    
    func initializeNameLabel() {
        var pokemonName = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.8, width: view.frame.width, height: view.frame.height * 0.2))
        pokemonName.text = pokemon.name
        view.addSubview(pokemonName)
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
