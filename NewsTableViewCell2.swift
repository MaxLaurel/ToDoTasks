import UIKit

class NewsTableViewCell2: UITableViewCell {
    
    let newsImageView: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        headerLabel.numberOfLines = 0 // Добавлено
        return headerLabel
    }()
    
    let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 3 // Добавлено
        return contentLabel
    }()
    
    let sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.font = .italicSystemFont(ofSize: 12)
        sourceLabel.numberOfLines = 1 // Добавлено
        sourceLabel.textAlignment = .right
        return sourceLabel
    }()
    
    private func setViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(sourceLabel)
        
//        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//        contentLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//        sourceLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//
//        headerLabel.setContentHuggingPriority(.required, for: .vertical)
//        contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        sourceLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false

        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        headerLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
     
        contentLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        sourceLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10).isActive = true
        sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
