
import UIKit


class Search:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableFacts.deselectRow(at: indexPath, animated: true)
        let fact = arrayFacts[indexPath.row]
        let category = arrayCategory[indexPath.row]
        let activityViewController = UIActivityViewController (activityItems: [fact, category], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell (style: .subtitle, reuseIdentifier: nil)
        cell.separatorInset = UIEdgeInsets (top: 50, left: 50, bottom: 50, right: 50)
        cell.textLabel!.text = arrayFacts[indexPath.row]
        cell.detailTextLabel!.text = arrayCategory[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Noteworthy-Light", size: 17)
        cell.imageView?.image = UIImage(named: "shared-icon.png")
        cell.textLabel?.font = UIFont(name: "Noteworthy-Bold", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .systemGray3
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.layer.borderWidth = 3
        
        cell.detailTextLabel!.backgroundColor = .systemGreen
        cell.detailTextLabel!.layer.borderWidth = 2
        cell.detailTextLabel!.layer.cornerRadius = 10
        cell.detailTextLabel!.layer.masksToBounds = true
        return cell
    }
        
    var tableFacts:UITableView = {
        let table = UITableView ()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
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
        label.text = "Fact Not Found"
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var factSearch = Busca()
    var arrayFacts:[String] = []
    var matrizCategory:[[String]] = [[]]
    var arrayCategory:[String] = []
    let searchController =  UISearchController (searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray3
        self.title = "Search"
        
    
        tableFacts.delegate = self
        tableFacts.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.tableFacts.backgroundColor = .systemGray3
        self.view.addSubview(notFound)
        self.view.addSubview(progressView)
        self.view.addSubview(tableFacts)
//        tableFacts.register(CelulaTableViewCell.self, forCellReuseIdentifier: "My Cell")
        

        configureConstraints()
    }
    
    func setIndicatowView (_ ind: Bool){
        if ind {
            self.progressView.isHidden = false
            self.tableFacts.isHidden = true
        } else {
            self.progressView.isHidden = true
            self.tableFacts.isHidden = false
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
//            self.setIndicatowView(false)
            return
        }
        
        if (text.trimmingCharacters(in: .whitespaces).isEmpty) {
            self.notFound.text = "Write the Search"
            return
        }
        
        
        self.factSearch.getSearch(termo: text) {
            
            DispatchQueue.main.async {
                self.arrayFacts = self.factSearch.facts
                self.matrizCategory = self.factSearch.category
                
                if self.arrayFacts.count < 1 && !(text.trimmingCharacters(in: .whitespaces).isEmpty)  {
                    self.setIndicatowView(true)
                    self.notFound.text = "Fact not found"
                    return
                }
                    
                    
                    var arrayCategoria:[String] = []
                    for i in 0..<self.matrizCategory.count {
                        var stringCategoria:String = "  Category: "
                        if  self.matrizCategory[i].count > 0 {
                        for j in 0..<self.matrizCategory[i].count {
                            stringCategoria += j <  self.matrizCategory[i].count - 1 ?  self.matrizCategory[i][j] + ", " :  self.matrizCategory[i][j] + ".  "
                        }
                        arrayCategoria.append (stringCategoria)
                    } else {
                        arrayCategoria.append ("  uncategorized  ")
                    }
                }
                self.arrayCategory = arrayCategoria
                self.arrayCategory.removeFirst()
                self.setIndicatowView(false)
                self.tableFacts.reloadData()
                
               
            }
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
                    tableFacts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
                    tableFacts.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
                    tableFacts.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                    tableFacts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    tabelaFatos.widthAnchor.constraint(equalTo: view.widthAnchor),
                    tableFacts.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    notFound.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    notFound.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
                    progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    }
    
}
//        celula.imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive
        
//        guard let celula = tableView.dequeueReusableCell(withIdentifier: CelulaTableViewCell.identificador, for: indexPath) as? CelulaTableViewCell else {
//            return UITableViewCell ()
//        }
//
//        celula.fact.text = arrayFinal[indexPath.row]
//        celula.category.text = arrayCategoria[indexPath.row]
//
//
