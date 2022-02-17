
import UIKit

let larguraTela:CGFloat = UIScreen.main.bounds.width
let alturaTela:CGFloat = UIScreen.main.bounds.height

class TelaPesquisa:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFinal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula:UITableViewCell = UITableViewCell (style: .subtitle, reuseIdentifier: nil)
        celula.textLabel!.text = arrayFinal[indexPath.row]
        celula.detailTextLabel!.text = arrayCategoria[indexPath.row]
        celula.textLabel?.numberOfLines = 0
        celula.backgroundColor = .clear
        celula.translatesAutoresizingMaskIntoConstraints = false
        celula.layer.borderWidth = 3
        

        
        return celula
    }
    
    
    var pesquisarFato:UIButton = {
        let button = UIButton ()
        button.setTitle("Pesquisar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font =  UIFont(name: "Verdana-Bold" ,size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(gerarFatoPesquisa), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tabelaFatos:UITableView = {
        let table = UITableView ()
        table.translatesAutoresizingMaskIntoConstraints = false
    
        
        return table
    }()
    
    var fatoPesquisa = Busca()
    var arrayFinal:[String] = []
    var matrizCategoria:[[String]] = [[]]
    var arrayCategoria:[String] = []
    let searchController =  UISearchController (searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pesquisa"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        

        self.view.backgroundColor = .systemBlue
        
        tabelaFatos.delegate = self
        tabelaFatos.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        self.view.addSubview(tabelaFatos)

        configureConstraints()
    }
    
    var searchTime:Timer?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        self.fatoPesquisa.getBusca(termo: text) {
            
            DispatchQueue.main.async {
               
                    self.arrayFinal = self.fatoPesquisa.fatos
                    self.matrizCategoria = self.fatoPesquisa.categoria
                    
                    var arrayCategoria:[String] = []
                    for i in 0..<self.matrizCategoria.count {
                        var stringCategoria:String = "Categoria: "
                        if  self.matrizCategoria[i].count > 0 {
                        for j in 0..<self.matrizCategoria[i].count {
                            stringCategoria += j <  self.matrizCategoria[i].count - 1 ?  self.matrizCategoria[i][j] + ", " :  self.matrizCategoria[i][j] + "."
                        }
                        arrayCategoria.append (stringCategoria)
                    } else {
                        arrayCategoria.append ("uncategorized")
                    }
                }
                
                self.arrayCategoria = arrayCategoria
                self.arrayCategoria.removeFirst()
                self.tabelaFatos.reloadData()

            }
            
        }
        
    }
    
    
    func configureConstraints() {
                self.view.addConstraints(NSLayoutConstraint.constraints(
                                 withVisualFormat: "V:|-150-[v0]-32-|",
                                 options: NSLayoutConstraint.FormatOptions(),
                                 metrics: nil,
                                 views: ["v0" : tabelaFatos]))
                self.view.addConstraints(NSLayoutConstraint.constraints(
                                 withVisualFormat: "H:|-32-[v0]-32-|",
                                 options: NSLayoutConstraint.FormatOptions(),
                                 metrics: nil,
                                 views: ["v0" : tabelaFatos]))
    }
}


