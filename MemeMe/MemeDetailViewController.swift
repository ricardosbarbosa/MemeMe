//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

  var meme: Meme?
  
  @IBOutlet weak var imageMemed: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let meme = meme {
      imageMemed.image = meme.memedImage
    }
  }

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
