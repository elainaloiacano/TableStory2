//
//  ViewController.swift
//  TableStory
//
//  Created by Loiacano, Elaina on 3/20/24.
//

import UIKit

import MapKit

//array objects of our data.
let data = [
    Item(name: "Ballet Austin", neighborhood: "Downtown", desc: "This dance studio offers dance and fitness classes for adults and has a company ballet program for pre-professionals.", lat: 30.266623903411805, long:-97.74909539055025, imageName: "studio1"),
    Item(name: "ElectrikCITY Dance Movement", neighborhood: "Downtown", desc: "A dance studio for all ages 7 and up that offers classes that are mainly hiphop based.", lat: 30.3351078731657, long: -97.71820481753235, imageName: "studio2"),
    Item(name: "Evenground Dance Studio", neighborhood: "North", desc: "This studio is open to students 13 and older, but is more adult based and maily offers hiphop classes.", lat: 30.35187083316567, long: -97.71623304636753, imageName: "studio3"),
    Item(name: "Dance Austin", neighborhood: "North", desc: "This studio is more for adults with limited youth classes and offers a range of classes. ", lat: 30.371631404026886, long: -97.72457337705349, imageName: "studio4"),
    Item(name: "DivaDance", neighborhood: "East", desc: "This studio is only for adults and is a franchise and they host parties as well.", lat: 30.288794610885233, long: -97.70659353287763, imageName: "studio5")
   
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        //Add image references
        let image = UIImage(named: item.imageName)
        cell?.imageView?.image = image
        cell?.imageView?.layer.cornerRadius = 10
        cell?.imageView?.layer.borderWidth = 5
        cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    
    // add this function to original ViewController
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 30.35187083316567, longitude: -97.71820481753235)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

    }


}

