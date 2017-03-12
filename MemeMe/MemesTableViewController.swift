//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

extension MemesTableViewController : MemeViewControllerProtocol {
  func added(controller: ViewController, meme: Meme) {
    listOfMemes.addMeme(meme)
  }
}


extension MemesTableViewController : ListOfMemesProtocol {
  func added(ListOfMemes: ListOfMemes) {
    tableView.reloadData()
  }
}

private let reuseIdentifier = "Cell"

class MemesTableViewController: UITableViewController {

  var listOfMemes : ListOfMemes = ListOfMemes.sharedInstance
  var selectedMeme : Meme?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    listOfMemes.addObserve(observer: self)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listOfMemes.memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MemeUITableTableViewCell
    cell.meme = listOfMemes.memes[indexPath.row]
    return cell
  }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? ViewController {
        vc.memeViewControllerProtocol = self
      }
      
      if let vc = segue.destination as? MemeDetailViewController {
        vc.meme = (sender as! MemeUITableTableViewCell).meme
      }
    }
  

}
