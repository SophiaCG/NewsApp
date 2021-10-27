//
//  ProductCell.swift
//  News-App
//
//  Created by SCG on 10/27/21.
//

import UIKit

class ArticleCell : UITableViewCell {
    
    var article : Article? {
        didSet {
//            articleImage.image = article?.urlToImage
            articleTitle.text = article?.title
            articleDescription.text = article?.description
        }
    }
    
    
    private let articleTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0

        return lbl
    }()
    
    
    private let articleDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()
        
//    private let articleImage : UIImageView = {
//        let imgView = UIImageView(image: #imageLiteral(resourceName: "glasses"))
//        imgView.contentMode = .scaleAspectFit
//        imgView.clipsToBounds = true
//        return imgView
//    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(productImage)
        addSubview(articleTitle)
        addSubview(articleDescription)
        
//        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        articleTitle.anchor(top: topAnchor, left: leftAnchor, bottom: articleDescription.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: UIScreen.main.bounds.width, height: 0, enableInsets: false)
        
        articleDescription.anchor(top: articleTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 10, paddingRight: 15, width: UIScreen.main.bounds.width, height: 0, enableInsets: false)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
