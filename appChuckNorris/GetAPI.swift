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

class Error: NSObject {
    func exibir (_ controller: UIViewController, _ title: String, _ mensage: String) {
        let alerta = UIAlertController (title: title, message: mensage, preferredStyle: .alert)
        let button = UIAlertAction (title: "OK", style: .default, handler: nil)
        alerta.addAction(button)
        
        controller.present (alerta, animated: true, completion: nil)
    }
}

class GetAPI {
    
    

    
    var fato = ""
    var category:[String] = []
    var error = ""
    let url = "https://api.chucknorris.io/jokes/random"
    let mensage = "An error occurred. Please try again!"
    
    func getFact(completion: @escaping () -> Void){
        let urlString = url
        
        guard let url = URL (string:urlString) else {
            completion()
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
//                Error().exibir.(self, "Atention", error.localizedDescription)
            }
            do {
                let result = try JSONDecoder().decode(Fato.self, from: data!)
                self.fato = result.value
                self.category = result.categories
            } catch {
                print (error.localizedDescription)
                self.error = self.mensage
            }
            completion()
        }
        task.resume()
    }
}


        





