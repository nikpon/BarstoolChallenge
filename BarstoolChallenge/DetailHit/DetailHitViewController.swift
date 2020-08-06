import UIKit
import WebKit

class DetailHitViewController: UIViewController, WKUIDelegate {
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        return webView
    }()
    
    var viewModel: DetailHitViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadRequest()
    }
    
    private func setupUI() {
        view.addSubview(webView)
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func loadRequest() {
        guard let url = viewModel.url else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
}
