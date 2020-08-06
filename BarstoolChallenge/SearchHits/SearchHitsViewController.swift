import UIKit

class SearchHitsViewController: UIViewController {
    
    // MARK:- Properties
    enum Constants {
        static let searchHitsTableViewCell = "SearchHitsTableViewCell"
    }
    
    lazy private var searchBar: UISearchBar = UISearchBar()
    private var tableView: UITableView!
    var viewModel: SearchHitsViewModel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK:- Methods
    private func commonInit() {
        view.backgroundColor = .white
        configureTableView()
        configureSearchBar()
        addSingleTapGesture()
    }
    
    private func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.rowHeight = 108
        tableView.register(SearchHitsTableViewCell.self, forCellReuseIdentifier: Constants.searchHitsTableViewCell)
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addSingleTapGesture() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    // MARK:- Actions
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
}

// MARK:- UITableViewDataSource
extension SearchHitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchHitsTableViewCell, for: indexPath) as! SearchHitsTableViewCell
        
        let hit = viewModel.getHit(for: indexPath)
        let hitCellViewModel = SearchHitsCellViewModel(hit: hit)
        cell.viewModel = hitCellViewModel
        cell.initViews(viewModelId: hitCellViewModel.id)
        
        return cell
    }
    
}

// MARK:- UITableViewDelegate
extension SearchHitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
}

// MARK:- UISearchBarDelegate
extension SearchHitsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchBarText = searchBar.text else { return }
        showSpinner()
        viewModel.fetch(query: searchBarText) { [weak self] in
            self?.removeSpinner()
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .left)
        }
    }
    
}
