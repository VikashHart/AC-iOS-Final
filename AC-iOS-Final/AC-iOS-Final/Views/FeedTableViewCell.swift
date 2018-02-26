//
//  FeedTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    var currentIndexPath: IndexPath?
    
    lazy var postCaption: UILabel = {
        let label = UILabel()
        label.text = "Caption"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "Post Cell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        setupPostImageView()
        setupPostCaption()
    }

    private func setupPostImageView() {
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 1),
            postImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupPostCaption() {
        addSubview(postCaption)
        postCaption.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postCaption.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            postCaption.centerXAnchor.constraint(equalTo: centerXAnchor),
            postCaption.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            postCaption.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
    }


    public func configurePostCell(post: Post) {
        postCaption.text = post.caption
        if let imageURL = post.postImageStr {
            postImageView.kf.indicatorType = .activity
            postImageView.kf.setImage(with: URL(string:imageURL), placeholder: UIImage.init(named: "placeholder-image"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            }
        }
    }
}

