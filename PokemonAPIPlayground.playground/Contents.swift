
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

import XCPlayground
import Foundation

// API Website: https://pokeapi.co
// URL: https://pokeapi.co/api/v2/pokemon

typealias SuccessHandler = (Bool -> Void)

struct Pokemon {
    var url: NSURL
    var name: String
    
    init?(dictionary: NSDictionary) {
        if
            let urlString = dictionary["url"] as? String,
            let url = NSURL(string: urlString),
            let name = dictionary["name"] as? String
        {
            self.url = url
            self.name = name
        }
        else
        {
            return nil
        }
    }
}

class PokemonDataSource {
    
    private(set) var pokemon = [Pokemon]()
    
    func create(completion: SuccessHandler) {
        // implement at some point
    }
    
    private let rootPokemonURL = NSURL(string: "https://pokeapi.co/api/v2/pokemon")!
    func read(completion: SuccessHandler) {
        self.pokemon = []
        self.downloadDataFromEndpoint(self.rootPokemonURL, completion: completion)
    }
    
    func update(completion: SuccessHandler) {
        // implement at some point
    }
    
    func delete(completion: SuccessHandler) {
        // implement at some point
    }
    
    private func downloadDataFromEndpoint(endpoint: NSURL, completion: SuccessHandler) {
        let request = NSURLRequest(URL: endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            // quick and dirty check to make sure we have data
            guard let data = data, let response = response as? NSHTTPURLResponse where response.statusCode == 200  else { completion(false); return; }
            
            // get the JSON out
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let p = dictionary["results"] as? [NSDictionary] {
                // append to the data
                let pMap = p.map() { d -> Pokemon? in
                    return Pokemon(dictionary: d)
                    }.filter { $0 != nil }.map { $0! }
                self.pokemon += pMap
            }
            
            // see if there are more pokemon
            if let nextURLString = dictionary["next"] as? String, let nextURL = NSURL(string: nextURLString) {
                // if so, repeat
                self.downloadDataFromEndpoint(nextURL, completion: completion)
            } else {
                // if not, finish
                completion(true)
            }
        }).resume()
    }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let dataSource = PokemonDataSource()
dataSource.read() { success in
    print("Finished Downloading Pokemon Successfully: \(success)")
    print("Total number of pokemon downloaded, \(dataSource.pokemon.count)")
    XCPlaygroundPage.currentPage.finishExecution()
}

