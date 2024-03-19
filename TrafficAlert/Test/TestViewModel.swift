//
//  TestModel.swift
//  EasyForm
//
//  Created by csuftitan on 3/17/24.
//

import Foundation
import GooglePlaces

class TestViewModel: ObservableObject {
    
    @Published var origin = ""
    @Published var destination = ""
    @Published var distance = ""
    @Published var averageDuration = ""
    @Published var currentDuration = ""
    @Published var originAutos:[GMSAutocompletePrediction] = []
    @Published var destinationAutos:[GMSAutocompletePrediction] = []
    private var placesClient = GMSPlacesClient.shared()
    
    func autocompleteOrigin() {
        guard self.origin != "" else {
            self.originAutos = []
            return
        }
        placesClient.findAutocompletePredictions(fromQuery: self.origin, filter: nil, sessionToken: nil) { predictions, error in
            if predictions?[0].attributedFullText.string ?? ""==self.origin {
                return
            }
            self.originAutos = predictions ?? []
        }
    }
    func autocompleteDestination() {
        guard self.destination != "" else {
            self.destinationAutos = []
            return
        }
        placesClient.findAutocompletePredictions(fromQuery: self.destination, filter: nil, sessionToken: nil) { predictions, error in
            if predictions?[0].attributedFullText.string ?? ""==self.destination {
                return
            }
            self.destinationAutos = predictions ?? []
        }
    }
    
    func getTrafficInfo() {
        // Creates a URL for fetching data from the Hacker News API
        if
            let api = trafficInfoAPI(from: origin, to: destination),
            let url = URL(string: api) {
            // Creates a URLSession for network data tasks
            let session = URLSession(configuration: .default)
            
            // Initiates a data task to fetch data from the given URL
            let task = session.dataTask(with: url) { data, response, error in
                // Handles errors, if any, during the data task
                if error == nil {
                    // Initializes a JSONDecoder for decoding JSON data
                    let decoder = JSONDecoder()
                    
                    // Safely unwraps and checks if valid data has been received
                    if let safeData = data {
                        do {
                            // Decodes the JSON data into a Results object using the defined structure
                            let results = try decoder.decode(Results.self, from: safeData)

                            // Updates the 'posts' array with the fetched 'hits' from the Results object
                            DispatchQueue.main.async {
                                self.origin = results.origin_addresses[0]
                                self.destination = results.destination_addresses[0]
                                self.distance = results.rows[0].elements[0].distance.text
                                self.averageDuration = results.rows[0].elements[0].duration.text
                                self.currentDuration = results.rows[0].elements[0].duration_in_traffic.text
                            }
                        } catch {
                            print(error) // Prints any decoding errors encountered
                        }
                    }
                }
            }
            task.resume() // Resumes the task, initiating data fetching
        }
    }
}
