import UIKit

class DetailStoryViewController: UIViewController {
    
    // MARK:- Properties
    private var detailStoryView: DetailStoryView {
        return view as! DetailStoryView
    }
    
    var viewModel: DetailStoryViewModel!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func loadView() {
        let detailStoryview = DetailStoryView()
        view = detailStoryview
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK:- Methods
    private func commonInit() {
        view.backgroundColor = .white
        initViews()
    }
    
    private func initViews() {
        showSpinner()
        detailStoryView.titleLabel.text = viewModel.title
        viewModel.fetchImageData(completion: { (imageData) in
            DispatchQueue.main.async {
                self.detailStoryView.eventImageView.image = UIImage(data: imageData)
            }
        })
        viewModel.fetchContentText(completion: { (contentText) in
            DispatchQueue.main.async {
                self.detailStoryView.contentTextView.attributedText = contentText
                self.removeSpinner()
            }
        })
        detailStoryView.authorLabel.text = viewModel.author
        detailStoryView.brandNameLabel.text = viewModel.brandName
    }
    
}
