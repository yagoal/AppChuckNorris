//
//  ViewController.swift
//  appChuckNorris
//
//  Created by Yago Pereira on 12/02/22.
//

import UIKit


//let larguraTela:CGFloat = UIScreen.main.bounds.width
//let alturaTela:CGFloat = UIScreen.main.bounds.height


class ViewController: UIViewController {
    
    
    
    
    var frase:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont (name: "Noteworthy-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var categoria:UILabel =  {
        let labelCategoria = UILabel()
        labelCategoria.textColor = .black
        labelCategoria.font = UIFont (name: "Noteworthy-Light", size: 18)
        labelCategoria.translatesAutoresizingMaskIntoConstraints = false
        return labelCategoria
    }()
    
    var gerarNovoFato:UIButton = {
        let button = UIButton ()
        button.setTitle("Gerar outro fato", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font =  UIFont(name: "Noteworthy-Bold" ,size: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(gerarFato), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let progressView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView (style: .large)
        progress.startAnimating()
        progress.isHidden = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var fato = GetAPI()
    
//    let searchController =  UISearchController (searchResultsController: TelaPesquisa())
    
        override func viewDidLoad() {
            
            super.viewDidLoad()
//            navigationItem.searchController = searchController
            self.view.backgroundColor = .systemGray
            gerarFato()
            
            self.view.addSubview(progressView)
            self.view.addSubview(frase)
            self.view.addSubview(categoria)
            self.view.addSubview(gerarNovoFato)
            
            self.title = "Chuck Norris"
            
            
            configureConstraints()
    }
    
    
    
    
    
    func configureConstraints() {
            NSLayoutConstraint.activate([
                frase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                frase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
                frase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
                
                categoria.topAnchor.constraint(greaterThanOrEqualTo: frase.bottomAnchor, constant: 24),
                categoria.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                categoria.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                
                gerarNovoFato.leadingAnchor
                    .constraint(equalTo: view.leadingAnchor, constant: 24.0),
                gerarNovoFato.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
                gerarNovoFato.heightAnchor.constraint(equalToConstant: 52.0),
                gerarNovoFato.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),
                
                progressView.centerXAnchor.constraint(equalTo: frase.centerXAnchor),
                progressView.centerYAnchor.constraint(equalTo: frase.centerYAnchor)
            ])
    }
    
 
    @objc func gerarFato () {
        self.progressView.isHidden = false
        fato.getFato {
            
            var stringCategoria:String = "Categoria: "
            DispatchQueue.main.async {
                
                self.frase.text = self.fato.fato
                print(self.fato.fato)
                if self.fato.categoria.count > 0 {
                    for i in 0..<self.fato.categoria.count {
                        stringCategoria += i < self.fato.categoria.count - 1 ? self.fato.categoria[i] + ", " : self.fato.categoria[i] + "."
                    }
                    self.categoria.text = stringCategoria
                } else {
                    self.categoria.text = "uncategorized"
                }
                self.progressView.isHidden = true
            }
            
        }
    }
}




//    func setLoadingState(_ state:Bool) {
//            if(state) {
//                self.indicator.isHidden = false
//                self.textView.isHidden = true
//            } else {
//                self.indicator.isHidden = true
//                self.textView.isHidden = false
//            }
//        }
//
//    var indicator:UIActivityIndicatorView
//    var texto

//    func navBar () {
//        let controller = ViewController()
//        controller.title = "Fatos de Chuck Norris"
//        let navigation = UINavigationController(rootViewController: controller)
//        present(navigation, animated: true, completion: nil)
//    }


//func setNavigationBar() {
//    let screenSize: CGRect = UIScreen.main.bounds
//    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//    _ = UINavigationItem(title: "Chuck Norris")
//    self.view.addSubview(navBar)
//}
