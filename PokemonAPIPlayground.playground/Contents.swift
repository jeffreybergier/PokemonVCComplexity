import XCPlayground
import Foundation

// Website: https://pokeapi.co
// URL: https://pokeapi.co/api/v2/pokemon

let pokemonURL = NSURL(string: "https://pokeapi.co/api/v2/pokemon")!
var pokemon = [NSDictionary]()

func downloadDataFromEndpoint(endpoint: NSURL) {
    XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
    let request = NSURLRequest(URL: endpoint)
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
        // quick and dirty check to make sure we have data
        guard let data = data, let response = response as? NSHTTPURLResponse where response.statusCode == 200  else { fatalError() }
        
        // get the JSON out
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        if let p = dictionary["results"] as? [NSDictionary] {
            // append to the data
            pokemon += p
        }
        
        // see if there are more pokemon
        if let nextURLString = dictionary["next"] as? String, let nextURL = NSURL(string: nextURLString) {
            // if so, repeat
            downloadDataFromEndpoint(nextURL)
        } else {
            // if not, finish
            print("Finished")
            print(pokemon.count)
            XCPlaygroundPage.currentPage.finishExecution()
        }
    })
}

downloadDataFromEndpoint(pokemonURL)
