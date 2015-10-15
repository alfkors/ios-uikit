//
//  SentMemesCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 10/14/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.topTextLabel.text = meme.topText
        cell.bottomTextLabel.text = meme.bottomText
        
        let imageView = UIImageView(image: meme.memeImage)
        cell.memeImageView.image = imageView.image
        
        return cell
    }

}
