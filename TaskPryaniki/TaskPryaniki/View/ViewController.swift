//
//  ViewController.swift
//  TaskPryaniki
//
//  Created by Nikita Entin on 28.07.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    private let viewModel = DataViewModel()
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "text")
        table.register(PictureCell.self, forCellReuseIdentifier: "picture")
        table.register(ButtonsCell.self, forCellReuseIdentifier: "button")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        viewModel.getData {
            self.table.reloadData()
        }
        
        view.addSubview(table)
        table.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchedName = viewModel.itemsName.first(where: { $0 == viewModel.namesByOrder[indexPath.row] })
        if matchedName == "hz" {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "text")
            cell.textLabel?.text = viewModel.textBlock
            return cell
        } else if matchedName == "selector" {
            let cell = table.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! ButtonsCell
            cell.delegate = self
            cell.handleButtonTap(variant: viewModel.selector)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "picture", for: indexPath) as! PictureCell
            cell.newImageView.sd_setImage(with: viewModel.pictureURL, completed: nil)
            cell.newTextLabel.text = viewModel.pictureText
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let matchedName = viewModel.itemsName.first(where: { $0 == viewModel.namesByOrder[indexPath.row] })
        if matchedName == "hz" {
            showAlert(message: "Выбран текстовый блок по индексу \(indexPath.row + 1)")
        } else if matchedName == "picture" {
            showAlert(message: "Выбран блок с картинками по индексу \(indexPath.row + 1)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let matchedName = viewModel.itemsName.first(where: { $0 == viewModel.namesByOrder[indexPath.row] })
        if matchedName == "hz" {
            return 50
        } else {
            return 150
        }
    }
}

extension ViewController: CellDelegate {
    
    func showButtonAlert(sender: ButtonsCell, with message: String) {
        let vc = UIAlertController(title: "Выбран блок с кнопками", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(action)
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(message: String?) {
        let vc = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(action)
        present(vc, animated: true, completion: nil)
    }
}
