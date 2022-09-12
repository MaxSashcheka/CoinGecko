//
//  ViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 12.09.22.
//

import Core
import UIKit
import Utils

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreInstance = CoreClass(name: "Инокентий")
        let utilsInstance = UtilsClass(name: "Олех")
        
        coreInstance.printName()
        utilsInstance.printName()
    }
}
