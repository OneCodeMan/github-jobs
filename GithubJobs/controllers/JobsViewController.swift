import Foundation
import UIKit

class JobsViewController: UIViewController {
    
    private struct Constants {
        static let viewTitle: String = "Github Jobs"
        static let cellId: String = "JobCell"
        static let noResultsImageName: String = "rocket"
        static let cellHeight: CGFloat = 215.0
        static let searchBarButtonItemSize: CGFloat = 25.0
        static let noResultsText: String = "No results found, try something else!"
        static let noResultsTextSize: CGFloat = 18.0
    }
    
    var jobTitle: String = ""
    var jobLocation: String = ""
    var isFullTime: Bool = false
    var jobs = [Job]()
    
    // MARK:- Views
    var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    var noResultsView: UIView = {
        let noResultsView = UIView()
        let noResultsLabel = UILabel()
        
        let noResultsImageView = UIImageView()
        let noResultsImage = UIImage.init(named: Constants.noResultsImageName)
        
        noResultsImageView.image = noResultsImage
        noResultsView.addSubview(noResultsImageView)
        noResultsImageView.translatesAutoresizingMaskIntoConstraints = false
        noResultsImageView.centerXAnchor.constraint(equalTo: noResultsView.centerXAnchor).isActive = true
        noResultsImageView.centerYAnchor.constraint(equalTo: noResultsView.centerYAnchor).isActive = true
        
        noResultsView.addSubview(noResultsLabel)
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.topAnchor.constraint(equalTo: noResultsImageView.bottomAnchor).isActive = true
        noResultsLabel.centerXAnchor.constraint(equalTo: noResultsView.centerXAnchor).isActive = true
        noResultsLabel.font = UIFont(name: Avenir.medium.rawValue, size: Constants.noResultsTextSize)
        noResultsLabel.text = Constants.noResultsText
        noResultsLabel.numberOfLines = 2
        
        return noResultsView
    }()
    
    let session = GithubJobsAPI.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        session.getJobs(withDescription: jobTitle, location: jobLocation, isFullTime: isFullTime) { jobs in
            self.jobs = jobs ?? []
            self.tableView.reloadData()
        }
    }
    
    private func setupView() {
        let searchItem = UIButton(type: .custom)
        searchItem.frame = CGRect(x: 0, y: 0, width: Constants.searchBarButtonItemSize, height: Constants.searchBarButtonItemSize)
        searchItem.setImage(UIImage(named: "magnifying-glass"), for: .normal)
        searchItem.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        
        let searchMenuItem = UIBarButtonItem(customView: searchItem)
        let currWidth = searchMenuItem.customView?.widthAnchor.constraint(equalToConstant: Constants.searchBarButtonItemSize)
        currWidth?.isActive = true
        let currHeight = searchMenuItem.customView?.heightAnchor.constraint(equalToConstant: Constants.searchBarButtonItemSize)
        currHeight?.isActive = true
        
        navigationItem.leftBarButtonItem = searchMenuItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        title = Constants.viewTitle
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JobCell.self, forCellReuseIdentifier: "JobCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func goToSearch() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! JobCell
        let job = jobs[indexPath.row]
        cell.job = job
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 0
        if !jobs.isEmpty {
            numberOfSections = 1
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        } else {
            let noDataView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            noDataView.addSubview(noResultsView)
            noResultsView.translatesAutoresizingMaskIntoConstraints = false
            noResultsView.widthAnchor.constraint(equalTo: noDataView.widthAnchor).isActive = true
            noResultsView.heightAnchor.constraint(equalTo: noDataView.heightAnchor).isActive = true
            tableView.backgroundView = noDataView
            tableView.separatorStyle = .none
        }
        
        return numberOfSections
    }

}
