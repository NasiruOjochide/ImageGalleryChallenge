//
//  FullImageView.swift
//  ImageGalleryChallenge
//
//  Created by Danjuma Nasiru on 25/02/2023.
//
import CoreLocation
import MapKit
import SwiftUI

struct FullImageView: View {
    
    var image : ImageDesc
    @State var location : MKCoordinateRegion
    @State private var trackingMode : MapUserTrackingMode = .follow
    
    var body: some View {
        
            VStack{
                image.image.resizable().scaledToFit()
                
                Map(coordinateRegion: $location, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode)
            }
                .toolbar(content: {
                    Button("Save Image"){
                        save()
                    }
                })
        
    }
    
    func getAppDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0].appendingPathComponent(image.name)
    }
    
    func save(){
        if let data = image.uiImage.jpegData(compressionQuality: 0.8){
            try? data.write(to: getAppDirectory(), options: [.atomic, .completeFileProtection])
            print("success")
        }
    }
    
}

//struct FullImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullImageView()
//    }
//}
