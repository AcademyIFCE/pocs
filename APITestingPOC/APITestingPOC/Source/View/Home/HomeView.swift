//
//  HomeView.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 25/08/22.
//

import UIKit

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    var entity: HomeEntity? { didSet { updateUi() } }
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Carregando..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    let imageIcon: UIButton = {
        let button = UIButton()
        button.setImage( UIImage(systemName: "star.fill")!, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()

    init(frame: CGRect, entity: HomeEntity) {
        self.entity = entity
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func updateUi() {
        DispatchQueue.main.async { [weak self] in
            if self?.entity?.trendingData?.results != nil {
                self?.label.text = "Filmes"
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.moviesTableView.frame = CGRect (
            x: 0.0,
            y: label.bounds.origin.y + 150,
            width: self.bounds.width,
            height: self.bounds.height
        )
    }
}

extension HomeView: ViewCoding {
    
    func addViewsInHierarchy() {
        addSubview(label)
        addSubview(imageIcon)
        addSubview(moviesTableView)
    }
    
    func setupConstraints() {
        let labelConstraints = [
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ]
        
        let imageConstraint = [
            imageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            imageIcon.widthAnchor.constraint(equalToConstant: 25),
            imageIcon.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(imageConstraint)
    }
    
    func setupAditionalConfiguration() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resultLenght = entity?.trendingData?.results.count else { return 0 }
        return resultLenght
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: MovieTableViewCell.identifier,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
        
        let currentItem = entity?.trendingData?.results[indexPath.row]
        
        let posterUrl = "\(Constants.IMAGE_URL)\(currentItem?.posterPath ?? "")"
        
        cell.configureCell (
            label: currentItem?.title ?? "Untitle",
            imageUrl: URL(string: posterUrl),
            overview: currentItem?.overview ?? ""
        )

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentItem = entity?.trendingData?.results[indexPath.row] else { return }
        delegate?.selectMovie(currentItem)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

