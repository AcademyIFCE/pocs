//
//  MovieTableViewCell.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 30/08/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "photo")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension MovieTableViewCell: ViewCoding {

    func addViewsInHierarchy() {
        contentView.addSubview(postImage)
        contentView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(movieLabel)
        verticalStackView.addArrangedSubview(overviewLabel)
    }
    
    func setupConstraints() {
        
        let postImageConstraints = [
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            postImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postImage.widthAnchor.constraint(equalToConstant: 100),
            postImage.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let verticalStackViewConstraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: 18),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ]
        
        NSLayoutConstraint.activate(postImageConstraints)
        NSLayoutConstraint.activate(verticalStackViewConstraints)
    }
    
}


extension MovieTableViewCell {
    func configureCell(label: String, imageUrl: URL?, overview: String) {
            movieLabel.text = label
            overviewLabel.text = overview
            
            if imageUrl != nil {
                AsyncImageWrapper.load(url: imageUrl!) { image in
                    DispatchQueue.main.async { [weak self] in
                        self?.postImage.image = image
                        self?.postImage.accessibilityLabel = "Capa do filme \(label)"
                    }
                }
                
                return
            }
            
            postImage.image = UIImage(systemName: "photo")
    }
}
