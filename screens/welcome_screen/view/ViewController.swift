//
//  ViewController.swift
//  fsocial
//
//  Created by halil yılmaz on 27.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var userListController: UserListController!
    
    private let table : UITableView = {
        let table = UITableView()
        table.register( UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var models: [Codable] = []
    private var selectedIndex: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        fetch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func fetch(){
        HttpService.shared.getRequest(
            url: Constants.url,
            httpMethod: "GET",
            expecting: [User].self
        ){ [weak self] result in
            switch result{
            case .success(let users):
                DispatchQueue.main.async {
                    self?.models = users
                    self?.table.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.userListController.userAtIndex(indexPath.row)
        self.selectedIndex = cell.phone
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (models[indexPath.row] as? User)?.name
        //cell.textLabel?.text = (models[indexPath.row] as? User)?.username
        //cell.textLabel?.text = (models[indexPath.row] as? User)?.phone
        return cell
    }
    
    

}


