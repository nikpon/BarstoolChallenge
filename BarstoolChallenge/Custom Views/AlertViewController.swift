import UIKit

final class AlertViewController: UIViewController {
    
    private let alertContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        return button
    }()
    
    convenience init(title: String, message: String, textButton: String) {
        self.init()
        configureTitleLabel(title: title)
        configureActionButton(textButton: textButton)
        configureBodyLabel(message: message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
    }
    
    private func commonInit() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        view.addSubview(alertContainer)
        alertContainer.anchor(width: 280, height: 200)
        alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        alertContainer.addSubviews(titleLabel, actionButton, bodyLabel)
        titleLabel.anchor(top: alertContainer.topAnchor, leading: alertContainer.leadingAnchor, trailing: alertContainer.trailingAnchor, paddingTop: 20, paddingLeading: 20, paddingTrailing: 20, height: 28)
        
        actionButton.anchor(leading: alertContainer.leadingAnchor, bottom: alertContainer.bottomAnchor, trailing: alertContainer.trailingAnchor, paddingLeading: 20, paddingBottom: 20, paddingTrailing: 20, height: 44)
        
        bodyLabel.anchor(top: titleLabel.bottomAnchor, leading: alertContainer.leadingAnchor, bottom: actionButton.topAnchor, trailing: alertContainer.trailingAnchor, paddingTop: 8, paddingLeading: 20, paddingBottom: 12, paddingTrailing: 20)
    }
    
    private func configureTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    private func configureActionButton(textButton: String) {
        actionButton.setTitle(textButton, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    private func configureBodyLabel(message: String) {
        bodyLabel.text = message
        bodyLabel.numberOfLines = 4
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
}
