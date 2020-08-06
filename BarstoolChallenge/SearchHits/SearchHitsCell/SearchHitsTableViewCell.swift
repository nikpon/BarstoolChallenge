import UIKit

final class SearchHitsTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    var viewModel: SearchHitsCellViewModel?
    
    let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.alpha = 1.0
        imageView.backgroundColor = UIColor.white
        imageView.layer.isOpaque = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        
        return label
    }()
    
    let brandNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        
        return label
    }()
    
    // MARK:- Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    private func commonInit() {
        layer.isOpaque = true
        backgroundColor = UIColor.white
        contentView.addSubviews(storyImageView, titleLabel, descriptionLabel, logoImageView, brandNameLabel, authorLabel)
        
        storyImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, paddingTop: 6, paddingLeading: 6, paddingBottom: 6, width: 108)
        
        authorLabel.anchor(leading: storyImageView.trailingAnchor, bottom: bottomAnchor, paddingLeading: 6, paddingBottom: 6, height: 15)
        
        brandNameLabel.anchor(leading: trailingAnchor, bottom: bottomAnchor, paddingLeading: 6, paddingBottom: 6, height: 15)
        
        titleLabel.anchor(top: topAnchor, leading: storyImageView.trailingAnchor, bottom: authorLabel.topAnchor, trailing: trailingAnchor, paddingTop: 6, paddingLeading: 6, paddingTrailing: 6)
        
    }
    
    func initViews(viewModelId: ObjectIdentifier) {
        storyImageView.image = nil
        viewModel?.fetchImageData(completion: { (imageData) in
            DispatchQueue.main.async {
                if viewModelId == self.viewModel?.id {
                    self.storyImageView.image = UIImage(data: imageData)
                }
            }
        })
        titleLabel.text = viewModel?.title
        authorLabel.text = viewModel?.author
    }
    
}

