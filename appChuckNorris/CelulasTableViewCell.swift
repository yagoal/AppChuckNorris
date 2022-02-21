//
//  CelulasTableViewCell.swift
//  appChuckNorris
//
//  Created by Yago Pereira on 18/02/22.
//

import UIKit

class CelulaTableViewCell: UITableViewCell {
    
    
//    var boxView: UIView = {
//        let box = UIView
//    }
    static let identificador = "My Cell"
    
    var imageShared:UIImageView = {
        let image = UIImage(named: "shared-icon.png")
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        return imageView
    }()
    
    var fact:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont (name: "Noteworthy-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var category:UILabel =  {
        let labelCategoria = UILabel()
        labelCategoria.textColor = .black
        labelCategoria.font = UIFont (name: "Noteworthy-Light", size: 18)
        labelCategoria.translatesAutoresizingMaskIntoConstraints = false
        return labelCategoria
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageShared)
        contentView.addSubview(fact)
        contentView.addSubview(category)
        
        NSLayoutConstraint.activate([
//                    containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
//                    containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
//                    containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
//                    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
                    
                    fact.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                    fact.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    fact.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    
                    category.topAnchor.constraint(equalTo: fact.bottomAnchor,constant: 10),
                    category.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
                    category.leadingAnchor.constraint(equalTo: fact.leadingAnchor),
                    
                    imageShared.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    imageShared.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
                    imageShared.heightAnchor.constraint(equalToConstant: 30),
                    imageShared.widthAnchor.constraint(equalToConstant: 30),
                ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
