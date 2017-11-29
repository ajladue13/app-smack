//
//  ChannelVC.swift
//  smack
//
//  Created by Alex LaDue on 11/26/17.
//  Copyright © 2017 Alex LaDue. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
    }


    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
