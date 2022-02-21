import UIKit


struct ArrayFacts: Codable {
    var categories:[String]
    var value:String
}

struct StructSearch: Codable {
    var total:Int
    var result:[ArrayFacts]
}

class Busca {
    
    var category:[[String]] = [[]]
    var facts:[String] = []
    
    
    func getSearch(termo: String, completion: @escaping () -> Void){
        
        self.facts = []
        self.category = [[]]
        
        guard let url = URL (string: "https://api.chucknorris.io/jokes/search?query=\(termo)") else {
            completion ()
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let infos = try JSONDecoder().decode(StructSearch.self, from: data)
                for item in infos.result.self {
                    self.facts.append(item.value + "\n " )
                    //print (item.value)
                    self.category.append(item.categories)
//                    print (item.categories)

                }
            } catch {
                print (error.localizedDescription)
            }
            completion()
        }
        task.resume()
    }
}

