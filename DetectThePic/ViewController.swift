//
//  ViewController.swift
//  DetectThePic
//
//  Created by Patty Harris on 8/22/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,
                    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    var observations : [VNClassificationObservation] = []

    let resnetModel = Resnet50()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewSetup()
        
    } // End viewDidLoad
    
    // Process the image picked.  This was originally in viewDidLoad where
    // we tested the hotdog image.
    func processPic(image: UIImage) {
        
        if let model = try? VNCoreMLModel(for: resnetModel.model) {
            
            // I used "coreRequest" instead of "request" to make it clearer in the
            // code...
            
            let coreRequest = VNCoreMLRequest(model: model, completionHandler: {
                (request, error) in
                
                // Check for results
                if let results = request.results as? [VNClassificationObservation] {
                    
                    self.observations = results
                    self.tableView.reloadData()
                    
                    /* Instead of printing out the results, we add it to our array
                     of observations...
                    for result in results {
                        print("ID: \(result.identifier) Confidence: \(result.confidence)")
                    } */
                    
                }
            })
            
            // Test with the hot dog image
            // if let image = UIImage(named: "hot-dog") {
                
                // We want the JPEG representation
                if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                    
                    // Now request a handler - we are using an emp[ty options dictionary
                    let handler = VNImageRequestHandler(data: imageData, options: [:])
                    
                    // Use the handler to perform the request - the results will be processed
                    // in the above closure.
                    try? handler.perform([coreRequest])
                }
            // }
        }

    } // End processPic
    
    @IBAction func photoLibraryButtonDidTap(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonDidTap(_ sender: Any) {
        // As with the Collector app, this only works on a real phone.
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate
    
    // This is called after the picker closes with the data picked.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The dictionary contains the data for what was picked.
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = chosenImage
            imagePicker.dismiss(animated: true, completion: nil)
            
            // And then proces the image - note that the results are iffy at best...
            // My hot dog only rated 48% confidence = e.g. 0.0481207
            processPic(image: chosenImage)
        }
        
        // I don't think we have the code yet for picking a photo taken using
        // the phone camera.
        
    }
}

// I added these as extensions, since I think it's cleaner...

// MARK: - Setup
extension ViewController {
    
    func tableViewSetup() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
        
        // NOTE: - Registering the cell programmatically - not needed with
        // the custom cell class we added at the end.
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ObservationCell")
    }
    
}

// MARK: UITableViewDelegte
extension ViewController : UITableViewDelegate {

}

// MARK: UITTableViewDataSource
extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ObservationCell", for: indexPath)
            as? ObservationTableViewCell {
        
            // Configure the cell...
            let observation = observations[indexPath.row]
            
            /* With a custom cell...
            cell.textLabel?.text = "\(observation.identifier) Confidence: \(observation.confidence * 100.0)%"
             */

            cell.cellLabel.text = "\(observation.identifier) Confidence: \(observation.confidence * 100.0)%"

            return cell
        }
        
        return UITableViewCell()
    
    }
}


