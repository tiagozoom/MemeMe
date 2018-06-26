//
//  MemeCollectionViewCell.swift
//  Mememe
//
//  Created by tiago turibio on 11/06/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme:Meme? {
        didSet{
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        memeImageView.image = meme?.memeImage
    }
}
