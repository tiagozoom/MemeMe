//
//  MemeTableViewCell.swift
//  Mememe
//
//  Created by tiago turibio on 07/06/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    
    static let ID = "MemeTableViewCell"
    
    var meme: Meme?{
        didSet{
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        memeImageView.image = meme?.memeImage
        memeText.text = meme?.topText
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
