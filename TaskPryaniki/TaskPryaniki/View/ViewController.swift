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
    private var matchedName: String? = ""
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: IDConstants.textCell)
        table.register(PictureCell.self, forCellReuseIdentifier: IDConstants.pictureCell)
        table.register(ButtonsCell.self, forCellReuseIdentifier: IDConstants.buttonCell)
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        
        //обращение к сети
        viewModel.getData {
            self.table.reloadData()
        } errorBlock: {
            self.showAlert(message: AlertConstants.error)
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
        //проверка на соответствие имени в массиве с данными с именами в массиве расположения
        matchedName = viewModel.itemsName.first(where: { $0 == viewModel.namesByOrder[indexPath.row] })
        if matchedName == DataNamesConstants.text {
            let cell = UITableViewCell(style: .default, reuseIdentifier: IDConstants.textCell)
            cell.textLabel?.text = viewModel.textBlock
            return cell
        } else if matchedName == DataNamesConstants.button {
            let cell = table.dequeueReusableCell(withIdentifier: IDConstants.buttonCell, for: indexPath) as! ButtonsCell
            cell.delegate = self
            cell.handleButtonTap(variant: viewModel.selector)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: IDConstants.pictureCell, for: indexPath) as! PictureCell
            cell.newImageView.sd_setImage(with: viewModel.pictureURL, completed: nil)
            cell.newTextLabel.text = viewModel.pictureText
            return cell
        }
    }
    // показ алерта по нажатию на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if matchedName == DataNamesConstants.text {
            showAlert(message: "\(AlertConstants.textBlock) \(indexPath.row + 1)")
        } else if matchedName == DataNamesConstants.picture {
            showAlert(message: "\(AlertConstants.pictureBlock) \(indexPath.row + 1)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return matchedName == DataNamesConstants.text ? 50 : 150
    }
}

extension ViewController: CellDelegate {
    
    //алерт для нажатия на кнопку внутри ячейки. Сообщения через делегат
    func showAlert(sender: ButtonsCell, with message: String) {
        let vc = UIAlertController(title: AlertConstants.buttonsBlock, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AlertConstants.okButton, style: .default, handler: nil)
        vc.addAction(action)
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(message: String?) {
        let vc = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AlertConstants.okButton, style: .default, handler: nil)
        vc.addAction(action)
        present(vc, animated: true, completion: nil)
    }
}
