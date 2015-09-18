//
//  Meme.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 9/17/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation
import UIKit

class Meme:NSObject {
    let topText: String?
    let bottomText: String?
    let image: UIImage
    let memeImage: UIImage
    init(topText: String, bottomText: String, image: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
}