import UIKit


struct ArrayFatos: Codable {
    var categories:[String]
    var value:String
}

struct EstruturaBusca: Codable {
    var total:Int
    var result:[ArrayFatos]
}

class Busca {
    
    var categoria:[[String]] = [[]]
    var total:Int = 0
    var fatos:[String] = []
    
    
    func getBusca(termo: String, completion: @escaping () -> Void){
        
        self.fatos = []
        self.categoria = [[]]
        
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
                let infos = try JSONDecoder().decode(EstruturaBusca.self, from: data)
                for item in infos.result.self {
                    self.fatos.append(item.value)
                    //print (item.value)
                    self.categoria.append(item.categories)
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

