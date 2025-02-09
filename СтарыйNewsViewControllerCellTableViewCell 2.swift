////
////  NewsViewControllerCellTableViewCell.swift
////  ToDoTasks
////
////  Created by Максим on 30.05.2024.
////
//import UIKit
//
//private class NewsTableViewCell: UITableViewCell {
//    
//    let newsImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    let contentLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    let authorLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.italicSystemFont(ofSize: 12)
//        label.textAlignment = .right
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(newsImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(contentLabel)
//        contentView.addSubview(authorLabel)
//        
//        newsImageView.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentLabel.translatesAutoresizingMaskIntoConstraints = false
//        authorLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            newsImageView.heightAnchor.constraint(equalToConstant: 200),
//            
//            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            
//            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            
//            authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
//            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//        print("cell created")
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
