//
//  MemeDetailsViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 10/18/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class MemeDetailVeiwController: UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memeImage
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}
