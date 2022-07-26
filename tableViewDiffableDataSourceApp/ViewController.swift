//
//  ViewController.swift
//  tableViewDiffableDataSourceApp
//
//  Created by 新垣 清奈 on 2022/07/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    enum Section {
        case first
    }
    struct Fruit: Hashable {
        let title: String
    }

    var dataSource: UITableViewDiffableDataSource<Section,Fruit>!
    var fruits = [Fruit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fruits"
        tableView.delegate = self
        bind()
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(alert))
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }

    @objc func alert(){
        let alert = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        for x in 0...20 {
            alert.addAction(UIAlertAction(title: "Fruits:\(x+1)", style: .default, handler: {[weak self] _ in
                let fruits = Fruit(title: "Fruits:\(x+1)")
                self?.fruits.append(fruits)
                self?.updateDataSource()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    private func bind(){
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            //title = Fruit Title
            cell.textLabel?.text = model.title
            return cell
        })
    }

    private func updateDataSource(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections([.first])
        snapshot.appendItems(fruits)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }




}

