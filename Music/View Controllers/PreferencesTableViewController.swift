//
//  PreferencesTableViewController.swift
//  Music
//
//  Created by saeed on 3/24/20.
//  Copyright © 2020 saeed. All rights reserved.
//

import UIKit

class PreferencesTableViewController: UITableViewController, UINavigationControllerDelegate {

    
    @IBOutlet var playNextSwitch: UISwitch!    
    @IBOutlet var countinuousPlaybackSwitch
    : UISwitch!
    
    @IBOutlet var numberOfMusicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playNextSwitch.setOn(SavePreferences.playNext, animated: false)
        countinuousPlaybackSwitch.setOn(SavePreferences.countinuousPlayback, animated: false)
        numberOfMusicLabel.text = String(SaveMedia.musicCount())
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return 2
        case 1:
            return 2
        default:
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1 && indexPath.row == 1 {
           clearDataAlert()
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func playNextAction(_ sender: UISwitch) {
        SavePreferences.playNext.toggle()
        if SavePreferences.countinuousPlayback && SavePreferences.playNext {
           SavePreferences.countinuousPlayback.toggle()
            countinuousPlaybackSwitch.setOn(false, animated: true)
        }
        SavePreferences.savePreferences()
    }
    
    @IBAction func countinuousPlaybackAction(_ sender: UISwitch) {
        SavePreferences.countinuousPlayback.toggle()
        if SavePreferences.countinuousPlayback && SavePreferences.playNext {
           SavePreferences.playNext.toggle()
            playNextSwitch.setOn(false, animated: true)
        }
        SavePreferences.savePreferences()
        
    }
    func clearDataAlert() {
        let alertController = UIAlertController(title: "Caution", message: "Are you sure you want to delete all data?? This action cannot be undone!", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.orange
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler:  { action in
            self.numberOfMusicLabel.text = "0"
            SaveMedia.clearAll()
            })
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

        
    }
}
