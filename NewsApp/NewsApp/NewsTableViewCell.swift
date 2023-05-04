//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by cecily li on 5/3/23.
//

import UIKit

class NewsTableViewCellViewModel {
    let title:String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title:String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let newssubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTableViewCell.identifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newssubTitleLabel)
        contentView.addSubview(newsTitleLabel)
    }
                   
                   required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
       
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 170,
                                      height: 70)
        newssubTitleLabel.frame = CGRect(x: 10,
                                      y: 70,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 150,
                                      y: 5,
                                      width: 160,
                                      height: contentView.frame.size.height - 10)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        newssubTitleLabel.text = viewModel.subtitle

        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            print(url)
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
   
    }

   
