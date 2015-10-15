//
//  SentMemesTableViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 10/13/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("There are \(memes.count) sent memes")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "New",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "newMeme")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

