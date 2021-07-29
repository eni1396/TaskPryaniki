//
//  PictureCell.swift
//  TaskPryaniki
//
//  Created by Nikita Entin on 28.07.2021.
//

import UIKit

class PictureCell: UITableViewCell {

    let newImageView = UIImageView()
    let newTextLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(newImageView)
        contentView.addSubview(newTextLabel)
        
        newImageView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.height.equalTo(100)
        }
        newTextLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(5)
        }
    }
}
