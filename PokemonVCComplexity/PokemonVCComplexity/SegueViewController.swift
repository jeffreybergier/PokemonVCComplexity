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

struct PokemonIndex {
    var indexPath: NSIndexPath
    var pokemon: Pokemon
}

class SegueViewController: CRUDViewController {
    
    enum StoryboardSegue: String {
        case DetailShowSegue
        case NewModalSegue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier, let segueType = StoryboardSegue(rawValue: identifier) else { return }
        switch segueType {
        case .DetailShowSegue:
            let indexPath = self.tableView!.indexPathForCell(sender as! UITableViewCell)!
            let destVC = segue.destinationViewController as? DetailViewController
            destVC?.delegate = self
            destVC?.pokemonIndex = PokemonIndex(indexPath: indexPath, pokemon: self.data[indexPath.row])
        case .NewModalSegue:
            let navVC = segue.destinationViewController as? UINavigationController
            let destVC = navVC?.viewControllers.first as? AddViewController
            destVC?.delegate = self
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) { }
}