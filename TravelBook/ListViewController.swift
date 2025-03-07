//
//  ViewController.swift
//  TravelBook
//
//  Created by Onur Bilke on 27.02.2025.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }

    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
