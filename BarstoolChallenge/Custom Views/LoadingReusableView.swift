import UIKit

final class LoadingReusableView : UICollectionReusableView {
    
    // MARK:- Properties
    let refreshControlIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
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
        addSubview(refreshControlIndicator)
        refreshControlIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        refreshControlIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
