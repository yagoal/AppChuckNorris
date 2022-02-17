//
//  GetAPI.swift
//  appChuckNorris
//
//  Created by Yago Pereira on 12/02/22.
//

import UIKit


struct Fato: Codable {
    var categories:[String]
    var value:String
    
}

class GetAPI {

    
    var fato = ""
    var categoria:[String] = []
    let url = "https://api.chucknorris.io/jokes/random"
    
    func getFato(completion: @escaping () -> Void){
        let urlString = url
        
        guard let url = URL (string:urlString) else {
            completion()
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
            }
            do {
                let result = try JSONDecoder().decode(Fato.self, from: data!)
                self.fato = result.value
                self.categoria = result.categories
            } catch {
                print (error.localizedDescription)
            }
            completion()
        }
        task.resume()
    }
}


        





