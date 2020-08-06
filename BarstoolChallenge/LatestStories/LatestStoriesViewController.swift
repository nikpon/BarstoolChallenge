import UIKit

class LatestStoriesViewController: UIViewController {
    
    // MARK:- Properties
    private var collectionView: UICollectionView!
    var loadingView: LoadingReusableView?
    var viewModel: LatestStoriesViewModel!
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    enum Constants {
        static let latestStoriesCollectionViewCell = "LatestStoriesCollectionViewCell"
        static let loadingResuableView = "LoadingResuableView"
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK:- Methods
    private func commonInit() {
        configureViews()
        
        view.backgroundColor = .white
        showSpinner()
        viewModel.fetch { [weak self] in
            guard let self = self else { return }
            self.removeSpinner()
            self.collectionView.reloadData()
        }
    }
    
    private func configureViews() {
        configureCollectionView()
        configureNavBar()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        collectionView.backgroundColor = .white
        collectionView.register(LatestStoriesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.latestStoriesCollectionViewCell)
        collectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.loadingResuableView)
        collectionView.refreshControl = refreshControl
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureNavBar() {
        let imageView = UIImageView(image: UIImage(named: viewModel.iconName))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    // MARK:- Actions
    @objc private func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel.fetch(afterRefresh: true) { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
}

// MARK:- UICollectionViewDataSource
extension LatestStoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.latestStoriesCollectionViewCell, for: indexPath) as! LatestStoriesCollectionViewCell
        
        let story = viewModel.getStory(for: indexPath)
        let storyCellViewModel = LatestStoriesCellViewModel(story: story)
        cell.viewModel = storyCellViewModel
        cell.initViews(viewModelId: storyCellViewModel.id)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.loadingResuableView, for: indexPath) as! LoadingReusableView
            loadingView = footerView
            loadingView?.backgroundColor = UIColor.clear
            return footerView
        }
        return UICollectionReusableView()
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout
extension LatestStoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 2
        let height = (view.frame.width - 2) / 2
        
        return CGSize(width: width, height: height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.isFetching {
            return CGSize.zero
        } else {
            return CGSize(width: view.frame.width, height: 100)
        }
    }
    
}

// MARK:- UICollectionViewDelegate
extension LatestStoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        
        if offset >= contentHeight - height {
            self.loadingView?.refreshControlIndicator.startAnimating()
            view.isUserInteractionEnabled = false
            
            viewModel.fetch {
                DispatchQueue.main.async {
                    self.loadingView?.refreshControlIndicator.stopAnimating()
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @available(iOS 13.0, *)
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let configuration = UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            [weak self] in
            guard let self = self else { return UIViewController() }
            
            let detailStoryVC = self.viewModel.getDetailStoryVC(for: indexPath)
            
            return detailStoryVC
            
            } , actionProvider: nil
            //            { (_) -> UIMenu? in
            //
            //                let action = UIAction(title: "Share") { (_) in
            //                    print("Share!")
            //                }
            //
            //                let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: [action])
            //
            //                return menu
            //
            //        }
        )
        return configuration
    }
    
    @available(iOS 13.0, *)
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let detailStoryVC = animator.previewViewController as? DetailStoryViewController else { return }
        animator.addAnimations {
            detailStoryVC.viewModel.startDetailStoryVC()
        }
    }
    
}
