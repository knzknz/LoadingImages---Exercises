//
//  PersonViewController.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
//TO ASK: Ask how to change the thumbnail image sizes
class PersonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var personArr = [PersonDetails]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 100
        loadPersonData()
    }

//call the completion handler to load all the random people
func loadPersonData() {
    let urlStr = "https://randomuser.me/api/?results=50"
    let setPersonToOnlinePerson: ([PersonDetails]) -> Void = {(onlinePerson: [PersonDetails]) in
        self.personArr = onlinePerson
    }
    PersonAPIClient.manager.getPerson(from: urlStr,
                                      completionHandler: setPersonToOnlinePerson,
                                      errorHandler: {print($0)})
}
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PersonDetailViewController {
    
            destination.clickedPerson = personArr[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Person Detail Segue", sender: indexPath)
    }
    
}


extension PersonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = personArr[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Person Cell", for: indexPath) as! PersonTableViewCell
        cell.nameLabel.text = "Name: \(person.name.first)"
        cell.ageLabel.text = "Age: \(person.dob)"
        cell.cellPhoneLabel.text = "Cell:\(person.cell)"
        //Call the completion handler to load the theumbnail image from the url
        guard let imageUrlStr = person.picture?.thumbnail else {
            return cell
        }
        //Below the closure is being defined but its not running yet
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout() //Makes the image load as soon as it's ready
        }
        //Now we are passing the closure down. The closure above can only run if it passes all of the errors. in the api client and the network helper.
        //Api client first the network helper
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return cell
    }
}




