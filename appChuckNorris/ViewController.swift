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
    
    
    let error = Error()
    
    var frase:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font =  UIFont(name: "Noteworthy-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var categoria:UILabel =  {
        let labelCategoria = UILabel()
        labelCategoria.backgroundColor = .clear
        labelCategoria.backgroundColor = .systemGreen
        labelCategoria.layer.borderWidth = 2
        labelCategoria.layer.masksToBounds = true
        labelCategoria.layer.cornerRadius = 10
        labelCategoria.textColor = .black
        labelCategoria.font =  UIFont(name: "Noteworthy-Light", size: 18)
        labelCategoria.translatesAutoresizingMaskIntoConstraints = false
        return labelCategoria
    }()
    
    var gerarNovoFato:UIButton = {
        let button = UIButton ()
        button.setTitle("GENERATE FACT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold" ,size: 22)
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(generateFact), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var buttonError:UIButton = {
        let button = UIButton ()
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold" ,size: 22)
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(generateFact), for: .touchUpInside)
        button.isHidden = true
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
    
    var fact = GetAPI()
    
//    let searchController =  UISearchController (searchResultsController: TelaPesquisa())
    
        override func viewDidLoad() {
            
            super.viewDidLoad()
//            navigationItem.searchController = searchController
            self.view.backgroundColor = .systemGray3
            generateFact()
            
            self.view.addSubview(progressView)
            self.view.addSubview(frase)
            self.view.addSubview(categoria)
            self.view.addSubview(gerarNovoFato)
            self.view.addSubview(buttonError)
            
            self.title = "FACTS ABOUT CHUCK NORRIS"
            
            
            
            configureConstraints()
    }
    
    
    func configureConstraints() {
            NSLayoutConstraint.activate([
                frase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                frase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
                frase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
                
                categoria.topAnchor.constraint(greaterThanOrEqualTo: frase.bottomAnchor, constant: 24),
                categoria.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                
//                buttonError.topAnchor.constraint(greaterThanOrEqualTo: frase.bottomAnchor, constant: 24),
                buttonError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                buttonError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                buttonError.heightAnchor.constraint(equalToConstant: 52.0),
                buttonError.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),
//                categoria.widthAnchor.constraint(equalTo: categoria.widthAnchor),
                
                gerarNovoFato.leadingAnchor
                    .constraint(equalTo: view.leadingAnchor, constant: 24.0),
                gerarNovoFato.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
                gerarNovoFato.heightAnchor.constraint(equalToConstant: 52.0),
                gerarNovoFato.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),
                
                progressView.centerXAnchor.constraint(equalTo: frase.centerXAnchor),
                progressView.centerYAnchor.constraint(equalTo: frase.centerYAnchor)
            ])
    }
    
 
    @objc func generateFact () {
        self.progressView.isHidden = false
        fact.getFact {
            
            var stringCategoria:String = "  Category: "
            DispatchQueue.main.async {
                if (self.fact.error != self.fact.mensage) {
                    self.frase.text = self.fact.fato
                
                    print(self.fact.fato)
                    if self.fact.category.count > 0 {
                        for i in 0..<self.fact.category.count {
                            stringCategoria += i < self.fact.category.count - 1 ? self.fact.category[i] + ", " : self.fact.category[i] + ".  "
                        }
                        self.categoria.text = stringCategoria
                    } else {
                        self.categoria.text = "  uncategorized  "
                    }
                    self.progressView.isHidden = true
                    self.gerarNovoFato.isHidden = false
                } else {
                    self.frase.text = self.fact.mensage
                    self.gerarNovoFato.isHidden = true
                    self.buttonError.isHidden = false
                    self.progressView.isHidden = true
                }
            }
            
        }
    }
}

