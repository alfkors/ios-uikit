//
//  Meme.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 9/24/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText, bottomText: String
    let image, memeImage: UIImage
    init(topText: String, bottomText: String, image: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
}
