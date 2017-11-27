//
//  ChatVC.swift
//  smack
//
//  Created by Alex LaDue on 11/26/17.
//  Copyright © 2017 Alex LaDue. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlets
    
    
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }


}
