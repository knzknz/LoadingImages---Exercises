//
//  PersonDetailViewController.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    //@IBOutlet weak var otherNumberlabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var clickedPerson: PersonDetails!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(clickedPerson.name.first) " + "\(clickedPerson.name.last)"
        ageLabel.text = clickedPerson.dob
        cellLabel.text = clickedPerson.cell
        locationLabel.text = "\(clickedPerson.location.street)"
        loadImage()
    }
    
    //Need to call the completion handler for the large image
    func loadImage() {
        guard let imageURLStr = clickedPerson.picture?.large else {
            return
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.largeImage.image = onlineImage
            self.largeImage.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageURLStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
    }
}
