//
//    The MIT License (MIT)
//
//    Copyright (c) 2016 Jeffrey Bergier
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//

import UIKit

protocol AddPokemonDelegate: class {
    func viewController(viewController: UIViewController, addPokemonWithName name: String, URL: NSURL)
}

protocol DeletePokemonDelegate: class {
    func viewController(viewController: UIViewController, deletePokemonAtIndexPath indexPath: NSIndexPath)
}

class CRUDViewController: JSBTableViewController, AddPokemonDelegate, DeletePokemonDelegate {
    
    @IBOutlet private weak var loadingView: LoadingView?
        
    private var dataSource: PokemonDataSource {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).pokemonDataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView?.loading = true
        self.dataSource.read() { success in
            self.loadingView?.loading = false
            self.dataUpdated()
        }
    }
    
    override func dataUpdated() {
        self.data = self.dataSource.pokemon
        print("Pokemon Data Updated. \(self.data.count) Total Pokemon")
        super.dataUpdated()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.viewController(self, deletePokemonAtIndexPath: indexPath)
        }
    }
    
    func viewController(viewController: UIViewController, addPokemonWithName name: String, URL: NSURL) {
        let newPokemon = Pokemon(name: name, URL: URL)
        self.dataSource.create(pokemon: newPokemon) { succes in
            self.dataUpdated()
        }
    }
    
    func viewController(viewController: UIViewController, deletePokemonAtIndexPath indexPath: NSIndexPath) {
        self.dataSource.deletePokemonAt(indexPath: indexPath) { success in
            self.dataUpdated()
        }
    }
    
}