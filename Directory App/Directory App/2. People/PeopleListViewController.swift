//
//  PeopleListViewController.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import UIKit

class PeopleListViewController: ModelledViewController<PeopleListViewModel> {
    @IBOutlet weak var tableView: UITableView!

    var searchBar = UISearchBar()
    var searchBarContainer: SearchBarContainerView?
    var searchBarButtonItem: UIBarButtonItem?
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideSearchBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.downloadPeopleData()
        self.setUpSearchBar()
        self.title = Constants.PeopleTitle
        self.tableView.register(UINib(nibName: "PeopleListTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "PeopleListTableViewCell")
    }
    
    override func updateView(_ type: PeopleListViewModel.UpdateType) {
        switch type {
        case .reload:
            self.tableView.reloadOnMainThread()
        }
    }
    
    override func handle(_ error: PeopleListViewModel.ErrorType) {
        switch error {
        case .canNotProcessData:
            Alerts().showAlert(title: Constants.Alerts.PeopleAlertTitle,
                               message: Constants.Alerts.AlertMessage,
                               viewController: self)
        }
    }
    
    @objc func seachBarIconTapped() {
        self.showSearchBar(searchBar: self.searchBar)
    }
    
    // MARK: - Private Methods
    private func setUpSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.showsCancelButton = true
        self.searchBarContainer = SearchBarContainerView(customSearchBar: self.searchBar)
        self.searchBarContainer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: Constants.SearchBarHeight)
        self.searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "magnifyingglass"),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(seachBarIconTapped))
        self.navigationItem.rightBarButtonItem = self.searchBarButtonItem
    }
    
    private func showSearchBar(searchBar : UISearchBar) {
        guard let searchBarContainer = self.searchBarContainer else {
            return
        }
        
        searchBarContainer.alpha = 0
        navigationItem.titleView = searchBarContainer
        navigationItem.setRightBarButton(nil, animated: true)
        
        UIView.animate(withDuration: 0.5, animations: {
            searchBarContainer.alpha = 1
        }, completion: { finished in
            searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
    
    private func hideSearchBar() {
        guard let searchBarButtonItem = self.searchBarButtonItem else {
            return
        }
        
        self.searchBarContainer?.searchBar.text = nil
        self.navigationItem.setRightBarButton(searchBarButtonItem, animated: true)
        self.navigationItem.titleView = .none
        self.viewModel.update?(.reload)
    }
}

// MARK: - UITableViewDataSource
extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredPeople?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleListTableViewCell", for: indexPath) as! PeopleListTableViewCell
        cell.setupCell(person: self.viewModel.filteredPeople?[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PeopleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let filteredPeople = self.viewModel.filteredPeople,
           let people = self.viewModel.peopleData {
            self.navigationController?.pushViewController(PersonDetailsViewController(viewModel: PersonDetailsViewModel(person: filteredPeople[indexPath.row],
                                                                                                                        people: people)),
                                                          animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension PeopleListViewController: UISearchBarDelegate {
    
    // Extension to SearchBar to search through the list of people
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.viewModel.filteredPeople = self.viewModel.peopleData
            searchBar.resignFirstResponder()
            self.hideSearchBar()
            return
        }
        
        self.viewModel.filteredPeople = self.viewModel.peopleData?.filter({ (person) -> Bool in
            let firstNameMatch = person.firstName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let lastNameMatch = person.lastName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let jobTitleMatch = person.jobtitle.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let emailMatch = person.email.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return firstNameMatch != nil || lastNameMatch != nil || jobTitleMatch != nil || emailMatch != nil}
        )
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.hideSearchBar()
    }
}
