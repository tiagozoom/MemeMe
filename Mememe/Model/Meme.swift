//
//  Meme.swift
//  Mememe
//
//  Created by tiago turibio on 18/04/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

struct Meme: Equatable{
    var originalImage: UIImage?
    var memeImage: UIImage?
    var topText: String
    var bottomText: String
    var index: Int?
    
    init(originalImage: UIImage?, memeImage: UIImage?,  topText: String, bottomText: String) {
        self.originalImage = originalImage
        self.memeImage = memeImage
        self.topText = topText
        self.bottomText = bottomText
    }
    
    init(meme: Meme) {
        self.originalImage = meme.originalImage
        self.memeImage = meme.memeImage
        self.topText = meme.topText
        self.bottomText = meme.bottomText
    }
}
