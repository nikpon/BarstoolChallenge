import UIKit

final class DetailStoryView: UIView {
    
    // MARK:- Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        
        return label
    }()
    
    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        
        return label
    }()
    
    let brandNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "splashicon")
        
        return imageView
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isSelectable = true
        
        return textView
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
        backgroundColor = UIColor.white
        constraintViews()
    }
    
    private func constraintViews() {
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubviews(titleLabel, eventImageView, authorLabel, brandNameLabel, logoImageView, contentTextView)
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 10)
        
        eventImageView.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 10, paddingLeading: 6, paddingTrailing: 6, height: 200)
        
        authorLabel.anchor(top: eventImageView.bottomAnchor, leading: containerView.leadingAnchor, paddingTop: 6, paddingLeading: 8, height: 10)
        authorLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        brandNameLabel.anchor(top: eventImageView.bottomAnchor, trailing: containerView.trailingAnchor, paddingTop: 6, paddingTrailing: 8, height: 10)
        
        logoImageView.anchor(top: eventImageView.bottomAnchor, trailing: brandNameLabel.leadingAnchor, paddingTop: 6, paddingTrailing: 6, width: 15, height: 15)
        
        contentTextView.anchor(top: logoImageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, paddingTop: 6, paddingLeading: 6, paddingTrailing: 6)
    }
    
}

