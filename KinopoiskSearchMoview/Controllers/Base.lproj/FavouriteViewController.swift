//
//  FavouriteViewController.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 01.11.2022.
// Current class need for showing favourite movies in table view type

import UIKit

class FavouriteViewController: UIViewController, MovieInformationDelegate {
    
    private let coreData = MovieEntityStack.instance
    private let identifier = FavouriteTableViewCell.identifier
    private var tableViewCell = [FavouriteTableViewCell]()
    
    private let table: UITableView = {
       let table = UITableView()
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh()
        setupNavigationController()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    //MARK: - Setups and target
    //func for refreshing page for reloading page
    @objc private func pullToRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            if self.table.refreshControl?.isRefreshing == true {
                self.tableViewCell.removeAll()
            }
            self.table.reloadData()
            self.coreData.loadData()
        }
        table.refreshControl?.endRefreshing()
    }
    
    private func setupTableView(){
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        coreData.loadData()
    }
    
    private func setupNavigationController(){
        title = "Favourite Movies"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func transferLink(imdb: String) {}
}
//Table view main setups
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.vaultData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavouriteTableViewCell
        let data = coreData.vaultData[indexPath.row]
        cell.configureCell(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = coreData.vaultData[indexPath.row]
        let vc = MovieInformationViewController()
        vc.imdbLinkInherit = cell.imdbLink ?? ""
        vc.delegate = self
        show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let data = coreData.vaultData[indexPath.row]
            coreData.vaultData.remove(at: indexPath.row)
            MovieEntityStack().deleteData(data: data)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    } 
}
