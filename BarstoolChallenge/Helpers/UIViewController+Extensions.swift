import UIKit
//import SafariServices

fileprivate var loaderView: UIView!

extension UIViewController {
    
    func showSpinner() {
        loaderView = UIView(frame: view.bounds)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        loaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        loaderView.backgroundColor = .secondarySystemBackground
        loaderView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            loaderView.alpha = 0.6
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loaderView.center
        activityIndicator.startAnimating()
        
        loaderView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor).isActive = true
    }
    
    func removeSpinner() {
        loaderView.removeFromSuperview()
        loaderView = nil
    }
    
    //    func presentSafariViewController(with url: URL) {
    //        let safariViewController = SFSafariViewController(url: url)
    //        //        safariViewController.preferredControlTintColor = .systemBlue
    //        present(safariViewController, animated: true)
    //    }
    
    func presentAlertViewController(title: String, message: String, textButton: String) {
        let alertViewController = AlertViewController(title: title, message: message, textButton: textButton)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        self.present(alertViewController, animated: true)
    }
    
}
