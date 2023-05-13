//
//  VTClient.swift
//  VirtualTouristRaz
//
//  Created by pc on 10/05/2023.
//

import Foundation
import UIKit

class VTClient {
    
    
    static let apiKey = "4ae427ed429adde9b99b121f695e628a"
    static let secret = "260ebf994ad756c2"
    
    static let base = "https://www.flickr.com/services/rest/"
    static let apiKeyParam = "&api_key=\(VTClient.apiKey)"
    

    enum Endpoints {
        case imageByLocation(Double, Double, Int)
        case getImage(Int, String, String, String)
        
        var stringValue: String {
        switch self {
        case let .imageByLocation(lat, lon, per_page):
            return VTClient.base + "?method=flickr.photos.search" + VTClient.apiKeyParam + "&lat=\(lat)&lon=\(lon)&page=\(Int.random(in: 1..<20))&per_page=\(per_page)&format=json&nojsoncallback=1"
        case let .getImage(farm, server, id, secret):
            return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getPhotos(latitude: Double, longitude: Double, numberOfImage: Int, completion: @escaping ([Photo],Error?) -> () ) {
        let task = URLSession.shared.dataTask(with: Endpoints.imageByLocation(latitude, longitude, numberOfImage).url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let responseObj = try JSONDecoder().decode(SearchPhotosResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObj.photos.photo,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
                print("cant get data \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    class func getPhoto(photo: Photo, image: Image, completion: @escaping (Image, Data?, Error?)->Void){
        let request = URLRequest(url: Endpoints.getImage(photo.farm, photo.server, photo.id, photo.secret).url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, data != nil else{
                 completion(image, nil, error)
                return
            }
            
            completion(image, data, nil)
        }
        
        task.resume()
    }
}
