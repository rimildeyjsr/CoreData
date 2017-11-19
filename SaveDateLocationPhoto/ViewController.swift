//
//  ViewController.swift
//  SaveDateLocationPhoto
//
//  Created by Rimil Dey on 13/11/17.
//  Copyright © 2017 Rimil Dey. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{

    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputAccessoryView = toolBar
        textView.becomeFirstResponder()
        locationManager.delegate = self
        loadCurrentDateAndTime()
    }
    
    // MARK: - outlets
    
    @IBOutlet var toolBar: UIView!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    // MARK: - interactions
    @IBAction func tapLocationButton(_ sender: UIButton) {
        getLocation()
    }
    
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        saveEntry()
    }
    
    
    @IBAction func tapCameraButton(_ sender: UIButton) {
        launchCameraRoll()
    }
    
    
    // MARK: - core data
    
    func saveEntry() {
        if textView.text.characters.count > 0 {
            
            //lets access core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entries = NSEntityDescription.insertNewObject(forEntityName: "Entries", into: context) as! Entries
            
            //pass values to core data
            entries.entry = textView.text
            entries.date = currrentDate as NSDate?
            if let locationText = locationLabel.text {
                entries.location = locationText
            }
            
            if let selectedImage = selectedImageView.image {
                entries.image = UIImageJPEGRepresentation(selectedImage, 0.75) as NSData?
            }
            
            //save data to core data
            appDelegate.saveContext()
            
        }
        
        let _ = navigationController?.popToRootViewController(animated: true)
        //core data path
        //let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print("core data path:\n \(path)")
    }
    
    
    
    
    // MARK: - camera roll
    
    func launchCameraRoll(){
        let imagepicker = UIImagePickerController()
        present(imagepicker, animated: true, completion: nil)
        imagepicker.delegate = self

    }
    
    // MARK:  UIImageControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        textView.becomeFirstResponder()
    }
    
    
    // MARK: - core location
    let locationManager = CLLocationManager()
    
    // MARK:  location functions
    
    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    // MARK:  CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if let placemarksData = placemarks {
                let locationData = placemarksData[0]
                
                let city = locationData.locality!
                let state = locationData.administrativeArea!
                let zipCode = locationData.postalCode!
                let country = locationData.isoCountryCode!
                let location = "\(city), \(state), \(zipCode), \(country)"
                
                self.locationLabel.text = location
                
                self.locationManager.stopUpdatingLocation()
                
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // MARK: - date and time
    
    var currrentDate : Date?
    
       func loadCurrentDateAndTime() {
        currrentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY 'at' h:mm a"
        
        dateLabel.text = dateFormatter.string(from: currrentDate!)
    }

    

    
    
}

