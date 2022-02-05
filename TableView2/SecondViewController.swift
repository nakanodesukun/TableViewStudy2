//
//  SceondViewController.swift
//  TableView2
//
//  Created by 中野翔太 on 2022/02/03.
//

import UIKit

class SecondViewController: UIViewController {
    
    var secondText = ""

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = secondText
    }
    


}

