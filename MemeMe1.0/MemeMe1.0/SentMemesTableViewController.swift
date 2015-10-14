//
//  SentMemesTableViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 10/13/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("There are \(memes.count) sent memes")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "New",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "newMeme")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("The table will have \(memes.count) rows")
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesCell") as UITableViewCell!
        cell?.textLabel?.text = memes[indexPath.row].topText
        cell?.imageView?.image = memes[indexPath.row].memeImage
        return cell
    }
    
    func newMeme(){
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewControllerWithIdentifier("ViewController")
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(VC, animated: true)
        }
    }
}
