import UIKit

class LatestStoriesCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Properties
    var viewModel: LatestStoriesCellViewModel?
    
    let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.alpha = 1.0
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    let brandNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    private func commonInit() {
        layer.isOpaque = true
        backgroundColor = .white
        configureViews()
    }
    
    private func configureViews() {
        contentView.addSubviews(storyImageView, titleLabel, authorLabel, brandNameLabel)
        
        storyImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 2, paddingLeading: 2, paddingTrailing: 2)
        storyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65).isActive = true
        
        titleLabel.anchor(top: storyImageView.bottomAnchor, leading: leadingAnchor, bottom: authorLabel.topAnchor, trailing: trailingAnchor, paddingLeading: 2, paddingTrailing: 2)
        
        let bottomLabelsHeight = frame.height / 13
        authorLabel.anchor(leading: leadingAnchor, bottom: bottomAnchor, paddingLeading: 2, width: frame.width / 2, height: bottomLabelsHeight)
        brandNameLabel.anchor(leading: authorLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTrailing: 2, height: bottomLabelsHeight)
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
        brandNameLabel.text = viewModel?.brandName
    }
    
}
