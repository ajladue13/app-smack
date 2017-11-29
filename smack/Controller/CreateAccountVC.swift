//
//  CreateAccountVC.swift
//  smack
//
//  Created by Alex LaDue on 11/28/17.
//  Copyright © 2017 Alex LaDue. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
