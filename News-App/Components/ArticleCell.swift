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
            articleImage.image = article?.urlToImage?.image
            articleTitle.text = article?.title
            articleDescription.text = article?.description
        }
    }
    
    private let articleTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0

        return lbl
    }()
    
    
    private let articleDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()
        
    private var articleImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(articleImage)
        addSubview(articleTitle)
        addSubview(articleDescription)
        
        articleImage.anchor(top: topAnchor, left: articleTitle.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 125, height: 100, enableInsets: false)
        
        articleTitle.anchor(top: topAnchor, left: leftAnchor, bottom: articleDescription.topAnchor, right: articleImage.leftAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: UIScreen.main.bounds.width, height: 0, enableInsets: false)
        
        articleDescription.anchor(top: articleTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: articleImage.leftAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 15, width: UIScreen.main.bounds.width, height: 0, enableInsets: false)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
