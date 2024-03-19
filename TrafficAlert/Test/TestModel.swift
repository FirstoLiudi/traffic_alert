//
//  TestModel.swift
//  TrafficAlert
//
//  Created by csuftitan on 3/18/24.
//

import Foundation

let API_KEY = "AIzaSyA1yKSWF8uT-6w4JTMdyv9CkbpRTYWzkfA"

func trafficInfoAPI(from origin:String,to destination:String) -> String?{
    guard origin != "", destination != "" else {return nil}
    if
        let o = origin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let d = destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        return "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=\(d)&origins=\(o)&key=\(API_KEY)"
    } else {
        return nil
    }
}

struct Results: Decodable{
    let destination_addresses:[String]
    let origin_addresses:[String]
    let rows:[Row]
}
struct Row: Decodable{
    let elements:[Element]
}
struct Element: Decodable{
    let distance:TextAndValue
    let duration:TextAndValue
    let duration_in_traffic:TextAndValue
}
struct TextAndValue: Decodable{
    let text:String
    let value:Int
}
