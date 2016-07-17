//
//  AppDelegate.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let pokemonDataSource = PokemonDataSource()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.pokemonDataSource.read() { success in
            for p in self.pokemonDataSource.pokemon {
                print(p.name)
            }
        }
        
        return true
    }
}

