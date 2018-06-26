//
//  MemeCollectionViewController.swift
//  Mememe
//
//  Created by tiago turibio on 11/06/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var statusBarShouldBeHidden = false
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBAction func presentModaly(_ sender: Any) {
        // Instantiate the modal view controller from storyboard
        let memeViewController = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        
        // Hide the status bar
        statusBarShouldBeHidden = true
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        // Present the modal view controller
        present(memeViewController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return statusBarShouldBeHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.statusBarShouldBeHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        self.collectionView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let memeCell = cell as? MemeCollectionViewCell{
            memeCell.meme = memes[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / 3 ) - 1
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var meme = memes[indexPath.row]
        meme.index = indexPath.row
        openDetailView(meme)
    }
    
    fileprivate func openDetailView(_ meme: Meme){
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! MemeDetailViewController
        detailViewController.meme = meme
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
