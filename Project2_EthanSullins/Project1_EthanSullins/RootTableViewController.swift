//
//  RootTableViewController.swift
//  Project1_EthanSullins
//
//  Created by Ethan Sullins on 12/3/24.
//

import Foundation
import UIKit
class RootTableViewController : UITableViewController {
    var BaseballTeamArray = [MLB2024]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let red: CGFloat = 150 / 255.0
        let green: CGFloat = 40 / 255.0
        let blue: CGFloat = 32 / 255.0
            
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: red, green: green, blue: blue, alpha: 1) // RGB color
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        GetAPIJSONData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  BaseballTeamArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseballObject = BaseballTeamArray[indexPath.row]
        let teamName = baseballObject.TeamName
        let teamDivision = baseballObject.TeamDivision
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        
        cell.textLabel!.text = teamName
        cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        cell.detailTextLabel!.text = teamDivision
        cell.detailTextLabel!.font = UIFont.italicSystemFont(ofSize: 12)
        
        return cell
    }
    
    // function to accept an URL and then download the bytes and convert bytes into an Image type and return the image back to the caller of the function.
    func PullImage(imagePath:String) -> UIImage {
        var downloadedImage = UIImage()
        
        //1. convert the String Parameter to an URL type
        let imageURL = URL(string:imagePath)
        
        //2. call the end point URL and receive bytes of data
        let imgBytes = try? Data(contentsOf: imageURL!)
        print(imgBytes ?? "Error! Image does not exist at the URL \(imageURL!)")
        
        //3. convert the bytes to an UIImage data type
        downloadedImage = UIImage(data:imgBytes!)!
    
        //4. Return the image
        return downloadedImage
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        if segue.identifier == "showTeamDetails" {
            
            let indexPath = tableView.indexPathForSelectedRow
            let selectedTeamObject = BaseballTeamArray[indexPath!.row]
            let destController = segue.destination as! ViewController
            destController.mlb2024 = selectedTeamObject
        }
    }

    
    func GetAPIJSONData() {
    // Connect to the JSON source using the URL.
        let endPointURL = URL(string: "https://raw.githubusercontent.com/ej-sully5/Final_IT315/refs/heads/main/MLB2024Teams.JSON")
    // pull the JSON data fromt he remote github site to local memory
        let dataBytes = try? Data(contentsOf: endPointURL!)
        // add a print statement for debugging purposes
        print("Received DataBytes --:  \(dataBytes!) ----- \n")
        
        if(dataBytes != nil) {
            // serialize  (change the format f data coming in to a format that is understood by Swift) the JSON into a dictionary
            let dictionary:NSDictionary = (try? JSONSerialization.jsonObject(with: dataBytes!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print("Received Dictionary --:  \(dictionary) ----- \n")
            
            // Isolate the dictionary element that we need. leave the other element behind.
            let baseballDictonary = dictionary["MLB2024Teams"]! as! [[String:AnyObject]]
            // now that the JSON data is isoated and we know that there are multiple rows... lets iterate throuh=gh the list and add it to the local array.
            for index in 0...baseballDictonary.count - 1 {
                let bt = MLB2024()
                let dictionaryBT = baseballDictonary[index] // iterating over the JSON ojects and selecting the next hiking trail.
                
                // extract each element of the object from the dictionary and store it in the local bt object.
                bt.TeamName = dictionaryBT["TeamName"] as! String
                bt.TeamDesc = dictionaryBT["TeamDesc"] as! String
                bt.TeamDivision = dictionaryBT["TeamDivision"] as! String
                bt.TeamPhoto = dictionaryBT["TeamPhoto"] as! String
                bt.TeamStadium = dictionaryBT["TeamStadium"] as! String
                bt.TeamRecord = dictionaryBT["TeamRecord"] as! String
                bt.TeamManager = dictionaryBT["TeamManager"] as! String
                bt.KeyPlayers = dictionaryBT["KeyPlayers"] as! String
                bt.PlayoffHistory = dictionaryBT["PlayoffHistory"] as! String
               
                BaseballTeamArray.append(bt)
            } // end of for
        } // end of databytes if condition
        else {
            // provide error condition to the developer
            print ("Could Not receive data from Remote Source. JSON is nil. Check the URL")
        } // end of databytes else condition
    } // end of GetAPIJSONData function
}
