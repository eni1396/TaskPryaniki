//
//  ButtonsCell.swift
//  TaskPryaniki
//
//  Created by Nikita Entin on 28.07.2021.
//

import SnapKit

protocol CellDelegate: AnyObject {
    func showAlert(sender: ButtonsCell, with message: String)
}

class ButtonsCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    
    private let button1 = UIButton(type: .system)
    private let button2 = UIButton(type: .system)
    private let button3 = UIButton(type: .system)
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [button1, button2, button3])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(stack)
        button1.addTarget(self, action: #selector(button1Pressed(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Pressed(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Pressed(_:)), for: .touchUpInside)
        
        [button1, button2, button3].forEach {
            $0.backgroundColor = .green
            $0.layer.cornerRadius = 10
            $0.snp.makeConstraints { maker in
                maker.width.equalToSuperview()
            }
        }
        stack.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview().inset(20)
        }
    }
    //названия кнопок
    func handleButtonTap(variant: [String]) {
        button1.setTitle(variant[0], for: .normal)
        button2.setTitle(variant[1], for: .normal)
        button3.setTitle(variant[2], for: .normal)
    }
    // действия по нажатию на кнопку
    @objc private func button1Pressed(_ sender: UIButton) {
        self.delegate?.showAlert(sender: self, with: AlertConstants.button1Text)
    }
    @objc private func button2Pressed(_ sender: UIButton) {
        self.delegate?.showAlert(sender: self, with: AlertConstants.button2Text)
    }
    @objc private func button3Pressed(_ sender: UIButton) {
        self.delegate?.showAlert(sender: self, with: AlertConstants.button3Text)
    }
}

