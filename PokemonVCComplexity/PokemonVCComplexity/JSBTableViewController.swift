//
//  TableViewController.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

class JSBTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView?
    
    var pokemon: [Pokemon] { return (UIApplication.sharedApplication().delegate as! AppDelegate).pokemonDataSource.pokemon }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func dataUpdated() {
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemon.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PokemonCell", forIndexPath: indexPath)
        cell.textLabel?.text = self.pokemon[indexPath.row].name
        return cell
    }
}
