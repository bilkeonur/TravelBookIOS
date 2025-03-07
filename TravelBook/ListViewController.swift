//
//  ViewController.swift
//  TravelBook
//
//  Created by Onur Bilke on 27.02.2025.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewSource = [ListItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }

    func setupUI() {
        
        tableViewSource.append(ListItemModel(id: "1", title: "1", description: "1"))
        tableViewSource.append(ListItemModel(id: "2", title: "2", description: "2"))
        tableViewSource.append(ListItemModel(id: "3", title: "3", description: "3"))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tableView.register(UINib(nibName: "CellListItem", bundle: Bundle(for: CellListItem.self)), forCellReuseIdentifier: "CellListItem")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @objc func addButtonTapped() {
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            navigationController?.pushViewController(mapVC, animated: true)
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellListItem", for: indexPath) as! CellListItem
        let item = tableViewSource[indexPath.row]
        cell.configure(model: item)
        return cell
    }
}
