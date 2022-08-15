//
//  PersonDetailsViewController.swift
//  Directory App
//
//  Created by Kacper Cichosz on 25/07/2022.
//

import UIKit

class PersonDetailsViewController: ModelledViewController<PersonDetailsViewModel> {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var accountDateLabel: UILabel!
    @IBOutlet var detailsTitleLabels: [UILabel]!
    @IBOutlet var detailsViews: [UIView]!
    @IBOutlet weak var searchTableView: UITableView!
    
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
        self.setupUI()
        self.setUpSearchBar()
        self.searchTableView.register(UINib(nibName: "PeopleListTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "PeopleListTableViewCell")
    }
    
    override func updateView(_ type: PersonDetailsViewModel.UpdateType) {
        switch type {
        case .personDetails:
            self.searchTableView.isHidden = true
            self.detailsBackgroundView.isHidden = false
            self.imageView.isHidden = false
        case .searchPeople:
            self.searchTableView.isHidden = false
            self.detailsBackgroundView.isHidden = true
            self.imageView.isHidden = true
            self.searchTableView.reloadOnMainThread()
        }
    }
    
    @objc func seachBarIconTapped() {
        self.showSearchBar(searchBar: self.searchBar)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        for label in self.detailsTitleLabels {
            label.textColor = Constants.MainBrandColour
        }
        for view in self.detailsViews {
            view.layer.cornerRadius = Constants.People.DetailsViewCornerRadius
        }
        self.detailsBackgroundView.backgroundColor = Constants.MainBrandColour
        self.imageView.makeRounded(borderWidth: Constants.People.ImageBorderWidth)
        self.imageView.image = self.viewModel.person.image
        self.nameLabel.text = [self.viewModel.person.firstName, self.viewModel.person.lastName].joined(separator: " ")
        self.emailLabel.text = self.viewModel.person.email.lowercased()
        self.jobTitleLabel.text = self.viewModel.person.jobtitle
        self.colourLabel.text = self.viewModel.person.favouriteColor.capitalized
        self.accountDateLabel.text = self.viewModel.getDate()
    }
    
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
        self.viewModel.update?(.personDetails)
    }
}

// MARK: - UITableViewDataSource
extension PersonDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.filteredPeople?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleListTableViewCell", for: indexPath) as! PeopleListTableViewCell
        cell.setupCell(person: self.viewModel.filteredPeople?[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PersonDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let filteredPeople = self.viewModel.filteredPeople {
            self.navigationController?.pushViewController(PersonDetailsViewController(
                viewModel: PersonDetailsViewModel(person: filteredPeople[indexPath.row],
                                                  people: self.viewModel.people)),
                                                          animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension PersonDetailsViewController: UISearchBarDelegate {
    
    // Extension to SearchBar to search through the list of people
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.viewModel.people = self.viewModel.people
            searchBar.resignFirstResponder()
            self.hideSearchBar()
            return
        }
        
        self.viewModel.filteredPeople = self.viewModel.people.filter({ (person) -> Bool in
            let firstNameMatch = person.firstName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let lastNameMatch = person.lastName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let jobTitleMatch = person.jobtitle.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let emailMatch = person.email.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return firstNameMatch != nil || lastNameMatch != nil || jobTitleMatch != nil || emailMatch != nil}
        )
        self.viewModel.update?(.searchPeople)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.hideSearchBar()
    }
}
