//
//  CustomCell.swift
//  ItunesList
//
//  Created by Balaji Peddaiahgari on 6/18/19.
//  Copyright © 2019 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var name: String?
    var mainImage: UIImage?
    var type: String?
    
    var nameView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var typeView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainImageView)
        self.addSubview(nameView)
        self.addSubview(typeView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor, constant: 10).isActive = true
        nameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        typeView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor, constant: 10).isActive = true
        typeView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        typeView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        typeView.topAnchor.constraint(equalTo: self.nameView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let name = name {
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: name, attributes:attrs)
            nameView.attributedText = boldString
        }
        if let image = mainImage {
            mainImageView.image = image
        }
        if let type = type {
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 11), NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray]
            let boldString = NSMutableAttributedString(string: type, attributes:attrs)
            typeView.attributedText = boldString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
