//
//  AddViewController.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField?
    @IBOutlet private weak var URLTextField: UITextField?
    
    weak var delegate: AddPokemonDelegate?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sender = sender as? UIBarButtonItem where sender.style == .Done {
            // since its a done button, we need to save
            let name = self.nameTextField!.text!
            let URL = NSURL(string: self.URLTextField!.text!)!
            self.delegate?.viewController(self, addPokemonWithName: name, URL: URL)
        }
    }
}
