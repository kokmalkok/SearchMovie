//
//  ViewController.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 26.10.2022.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, MovieInformationDelegate {
    
    private var cellData: [Movie] = []
    private var cellFinalData: [FullMovie] = []
    private var timer: Timer?
    
    private let tableViewCustom: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    let alert: UIAlertController! = {
        let alert = UIAlertController(title: "Error!", message: "Error searching. We didn't found anything by your request. Enter another request!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fine", style: .cancel))
        return alert
    }()
    
    private let searchBar: UISearchController = {
        let search = UISearchController(searchResultsController: ShowSearchResultViewController())
        search.searchBar.placeholder = "Enter the request.."
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.becomeFirstResponder()
        search.searchBar.enablesReturnKeyAutomatically = true
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupSearchBar()
        setupTableView()
        topMovies()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewCustom.frame = view.bounds
    }
    //MARK: - Setup
    private func setupSearchBar(){
        view.addSubview(searchBar.searchBar)
        searchBar.delegate = self
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
    }
    
    private func setupNavigationController(){
        navigationItem.title = "Search Movies"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView(){
        tableViewCustom.delegate = self
        tableViewCustom.dataSource = self
        view.addSubview(tableViewCustom)
    }
    //delegate Movie Information
    func transferLink(imdb: String) { }
    //MARK: - Upload movies
    //func with base request "Matrix" decoding data from api to swift data
    func topMovies(){
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=8e9fef78&s=matrix") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(Root.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.cellData = result.Search
                    self?.tableViewCustom.reloadData()
                }
            }
            catch {
                print("error of trends \(error)")
            }
        }.resume()
    }
    //func for decode data from api to swift data and display it
    func requestMovies(string request: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=8e9fef78&s=\(request)") else { return }
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data , error == nil else { return }
                do {
                    let result = try JSONDecoder().decode(Root.self, from: data)
                    DispatchQueue.main.async { [self] in
                        self.cellData = result.Search
                        self.tableViewCustom.reloadData()
                    }
                } catch {
                    print("Error of searching \(error)")
                    DispatchQueue.main.async {
                        self.present((self.alert)!,animated: true)
                    }
                }
        } .resume()
    }
}
    //MARK: - table view delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configureCell(with: cellData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = cellData[indexPath.row]
        let vc = MovieInformationViewController()
        vc.imdbLinkInherit = cell.imdbID
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
//settings for search controllers
extension SearchViewController:  UISearchResultsUpdating, UISearchBarDelegate , UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else {
            return
        }
        if let vc = searchController.searchResultsUpdater as? ShowSearchResultViewController{
            vc.view.backgroundColor = .gray
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in
            searchBar.becomeFirstResponder()
            if let text = searchBar.text {
                self.cellData.removeAll()
                self.requestMovies(string: text)
                self.title = "Search"
                self.dismiss(animated: true)
                self.tableViewCustom.reloadData()
            }
        })
    }
}



