//
//  DetailViewController.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var URLLabel: UILabel?
    
    weak var delegate: DeletePokemonDelegate?
    var pokemonIndex: PokemonIndex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel?.text = self.pokemonIndex?.pokemon.name
        self.URLLabel?.text = self.pokemonIndex?.pokemon.URL.absoluteString
    }
    
    @IBAction func deleteButtonTapped(sender: UIButton?) {
        self.delegate?.viewController(self, deletePokemonAtIndexPath: self.pokemonIndex!.indexPath)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
