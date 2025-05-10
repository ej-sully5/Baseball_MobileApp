//
//  ViewController.swift
//  Project1_EthanSullins
//
//  Created by Ethan Sullins on 10/23/24.
//
// App Name: MLB Playoff Hub
// App Description: The ultimate companion app for the 2024 MLB postseason. Whether your
// a new or long time fan, MLB Playoff Hub will bring you up to date on each team that
// made it to the playoffs this year.
//
// Disclaimer:
// This App is developed as an educational project, certain materials are included under
// the fair use exemption of the U.S. Copyright Law and have been prepared according
// to the multimedia fair use guidelines and are restricted from further use.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var AreaOne: UIScrollView!
    @IBOutlet weak var AreaTwo: UIScrollView!
    @IBOutlet weak var AreaThree: UIScrollView!
    @IBOutlet weak var AreaFour: UIScrollView!
    @IBOutlet weak var AreaFive: UIScrollView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblTeamDivision: UILabel!
    @IBOutlet weak var lblTeamStadium: UILabel!
    @IBOutlet weak var TextTeamDesc: UITextView!
    @IBOutlet weak var lblTeamRecord: UILabel!
    @IBOutlet weak var lblTeamManager: UILabel!
    @IBOutlet weak var lblKeyPlayers: UILabel!
    @IBOutlet weak var lblPlayoffHistory: UILabel!
    @IBOutlet weak var picTeamPic: UIImageView!
    
    @IBAction func ticketBTN(_ sender: Any) {
        mySoundFile.play()
        if let url = URL(string: "https://www.mlb.com/tickets") {
                UIApplication.shared.open(url)
            }
    }
    
    var mySoundFile: AVAudioPlayer!

    // Variables
    var MLBobjectArray = [MLB2024]()
    var mlb2024 = MLB2024()
        
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
    
    // Functions
    func setLabels() {
        
        lblTeamName.text = mlb2024.TeamName
        lblTeamDivision.text = mlb2024.TeamDivision
        lblTeamStadium.text = mlb2024.TeamStadium
        TextTeamDesc.text = mlb2024.TeamDesc
        lblTeamRecord.text = mlb2024.TeamRecord
        lblTeamManager.text = mlb2024.TeamManager
        lblKeyPlayers.text = mlb2024.KeyPlayers
        lblPlayoffHistory.text = mlb2024.PlayoffHistory
        picTeamPic.image = PullImage(imagePath: mlb2024.TeamPhoto)
                
        // decorate boxes
        AreaOne.layer.cornerRadius = 10
        AreaOne.layer.borderWidth = 1
        AreaOne.layer.borderColor = UIColor.darkGray.cgColor
        
        AreaTwo.layer.cornerRadius = 10
        AreaTwo.layer.borderWidth = 1
        AreaTwo.layer.borderColor = UIColor.darkGray.cgColor
        
        AreaThree.layer.cornerRadius = 10
        AreaThree.layer.borderWidth = 1
        AreaThree.layer.borderColor = UIColor.darkGray.cgColor
        
        AreaFour.layer.cornerRadius = 10
        AreaFour.layer.borderWidth = 1
        AreaFour.layer.borderColor = UIColor.darkGray.cgColor
        
        AreaFive.layer.cornerRadius = 10
        AreaFive.layer.borderWidth = 1
        AreaFive.layer.borderColor = UIColor.darkGray.cgColor
        
        TextTeamDesc.layer.cornerRadius = 10
        TextTeamDesc.layer.borderWidth = 1
        TextTeamDesc.layer.borderColor = UIColor.darkGray.cgColor
        
        picTeamPic.layer.cornerRadius = 10
        picTeamPic.layer.borderWidth = 1
        picTeamPic.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let soundURL = URL(fileURLWithPath: Bundle.main.path(forResource:"play_ball", ofType:"wav")!)
        mySoundFile = try? AVAudioPlayer(contentsOf: soundURL)
        setLabels()
    }
}
