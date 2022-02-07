//
//  CoustomCell.swift
//  TableView2
//
//  Created by 中野翔太 on 2022/02/07.
//

import UIKit

class CoustomCell: UITableViewCell {
    var count: Int = 0

   
    @IBOutlet weak var titleLabel: UILabel!


    func configur(title: String) {
        titleLabel.text = title
    }

}
