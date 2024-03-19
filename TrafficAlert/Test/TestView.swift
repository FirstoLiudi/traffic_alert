//
//  TestView.swift
//  EasyForm
//
//  Created by csuftitan on 3/17/24.
//

import SwiftUI
import GooglePlaces

struct KeyValueView: View {
    let key:String
    let value:String
    var body: some View {
        HStack{
            Text(key)
            Spacer()
            Text(value).multilineTextAlignment(.trailing)
        }
    }
}

struct TestView: View {
    @ObservedObject var viewModel=TestViewModel()

    @State private var originFocused = false
    @State private var destinationFocused = false
    
    var body: some View {
        Form {
            Section{
                TextField("Origin", text: $viewModel.origin, onEditingChanged: { isFocus in
                    originFocused=isFocus
                })
                    .onChange(of: viewModel.origin) { newValue in
                        viewModel.autocompleteOrigin()
                    }
                if originFocused, viewModel.originAutos.count > 0 {
                    ForEach(viewModel.originAutos, id: \.placeID){ item in
                        Button("\(item.attributedPrimaryText.string)\n\(item.attributedSecondaryText?.string ?? "")") {
                            viewModel.origin=item.attributedFullText.string
                            viewModel.originAutos=[]
                        }
                    }
                }
            
                TextField("Destination", text: $viewModel.destination, onEditingChanged: { isFocus in
                    destinationFocused=isFocus
                })
                    .onChange(of: viewModel.destination) { newValue in
                        viewModel.autocompleteDestination()
                    }
                if destinationFocused, viewModel.destinationAutos.count > 0 {
                    ForEach(viewModel.destinationAutos, id: \.placeID){ item in
                        Button("\(item.attributedPrimaryText.string)\n\(item.attributedSecondaryText?.string ?? "")") {
                            viewModel.destination=item.attributedFullText.string
                            viewModel.destinationAutos=[]
                        }
                    }
                }
            }
            Section{
                KeyValueView(key: "Origin", value: viewModel.origin)
                KeyValueView(key: "Destination", value: viewModel.destination)
                KeyValueView(key: "Distance", value: viewModel.distance)
                KeyValueView(key: "Duration (average)", value: viewModel.averageDuration)
                KeyValueView(key: "Duration (traffic)", value: viewModel.currentDuration)
            }
            Section{
                Button("Get Traffic Info", action: viewModel.getTrafficInfo)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
