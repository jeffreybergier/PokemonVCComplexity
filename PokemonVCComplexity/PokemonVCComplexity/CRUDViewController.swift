//
//  CRUDViewController.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

class CRUDViewController: UIViewController {
    
    var pokemon: [Pokemon] { return self.dataSource.pokemon }
    var dataSource: PokemonDataSource { return (UIApplication.sharedApplication().delegate as! AppDelegate).pokemonDataSource }
    
    @IBOutlet private weak var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView?.loading = true
        self.dataSource.read() { success in
            self.loadingView?.loading = false
            self.dataUpdated()
        }
    }
    
    func dataUpdated() {
        print("Pokemon Data Updated")
    }
    
}
