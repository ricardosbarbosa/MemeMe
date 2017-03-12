//
//  MemeUITableTableViewCell.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

class MemeUITableTableViewCell: UITableViewCell {
 
  @IBOutlet weak var imageMeme: UIImageView!
  @IBOutlet weak var labelMeme: UILabel!
  
  var meme : Meme? {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    if let meme = meme {
      imageMeme.image = meme.memedImage
      labelMeme.text = "\(meme.topText) \(meme.bottomText)"
    }
    
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

}
