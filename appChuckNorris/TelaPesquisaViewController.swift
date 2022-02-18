
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
        celula.detailTextLabel?.font = UIFont(name: "Noteworthy-Light", size: 12)
        celula.imageView?.image = UIImage(named: "shared-icon.png")
        celula.textLabel?.font = UIFont(name: "Noteworthy-Bold", size: 17)
//        celula.i
        celula.textLabel?.numberOfLines = 0
        celula.backgroundColor = .systemGray
        celula.translatesAutoresizingMaskIntoConstraints = false
        celula.layer.borderWidth = 3
        return celula
    }
    
    var tabelaFatos:UITableView = {
        let table = UITableView ()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.backgroundColor = .systemGray
        
        return table
    }()
    
    let progressView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView (style: .large)
        progress.startAnimating()
        progress.isHidden = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var notFound:UILabel =  {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont (name: "Noteworthy-Bold", size: 15 )
        label.text = "Fato não encontrado..."
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var fatoPesquisa = Busca()
    var arrayFinal:[String] = []
    var matrizCategoria:[[String]] = [[]]
    var arrayCategoria:[String] = []
    let searchController =  UISearchController (searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.title = "Pesquisa"
        
    
        tabelaFatos.delegate = self
        tabelaFatos.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.view.addSubview(notFound)
        self.view.addSubview(progressView)
        self.view.addSubview(tabelaFatos)
        

        configureConstraints()
    }
    
    func setIndicatowView (_ ind: Bool){
        if ind {
            self.progressView.isHidden = false
            self.tabelaFatos.isHidden = true
        } else {
            self.progressView.isHidden = true
            self.tabelaFatos.isHidden = false
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
//            self.setIndicatowView(false)
            return
        }
        
        if (text.trimmingCharacters(in: .whitespaces).isEmpty) {
            self.notFound.text = "Digite o que deseja pesquisar"
            return
        }
        
        
        self.fatoPesquisa.getBusca(termo: text) {
            
            DispatchQueue.main.async {
                self.arrayFinal = self.fatoPesquisa.fatos
                self.matrizCategoria = self.fatoPesquisa.categoria
                
                if self.arrayFinal.count < 1 && !(text.trimmingCharacters(in: .whitespaces).isEmpty)  {
                    self.setIndicatowView(true)
                    self.notFound.text = "Fato não encontrado"
                    return
                }
                    
                    
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
                self.setIndicatowView(false)
                self.tabelaFatos.reloadData()
                
               
            }
        }
    }
    
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
                    tabelaFatos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
                    tabelaFatos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
                    tabelaFatos.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                    tabelaFatos.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    tabelaFatos.widthAnchor.constraint(equalTo: view.widthAnchor),
                    tabelaFatos.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    notFound.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    notFound.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
                    progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    }

//var pesquisarFato:UIButton = {
//    let button = UIButton ()
//    button.setTitle("Pesquisar", for: .normal)
//    button.setTitleColor(.black, for: .normal)
//    button.setTitleColor(.blue, for: .highlighted)
//    button.titleLabel?.font =  UIFont(name: "Verdana-Bold" ,size: 20)
//    button.backgroundColor = .systemGreen
//    button.layer.cornerRadius = 25
////        button.addTarget(self, action: #selector(gerarFatoPesquisa), for: .touchUpInside)
//    button.translatesAutoresizingMaskIntoConstraints = false
//    return button
//}()
}
