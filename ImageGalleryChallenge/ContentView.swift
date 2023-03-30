//
//  ContentView.swift
//  ImageGalleryChallenge
//
//  Created by Danjuma Nasiru on 25/02/2023.
//
import CoreLocation
import MapKit
import SwiftUI

struct ContentView: View {
    
    let locationFetcher = LocationFetcher()
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var zaImage : Image?
    @State private var inputImage : UIImage?
    @State private var inputImageName = ""
    @State private var imageDescArray = [ImageDesc]()
    @State private var showNamePrompt = false
    @State private var showPhotoPickerSheet = false
//    @State private var images = [Image]()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]){
                        ForEach(imageDescArray,id: \.name){image in
                            NavigationLink{
                                FullImageView(image: image, location: location)
                            } label: {
                                image.image
                                    .resizable()
                                    .frame(height: 200)
                                    .scaledToFit()
                                    .overlay(RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(.blue, lineWidth: 2))
                            }
                        }.padding(5)
                    }
                    
                    if showNamePrompt{
                        VStack{
                            TextField("Input image name", text: $inputImageName)
                            if inputImageName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                                Text("Field Cannot be empty").foregroundColor(.red).font(.footnote)
                            }else{}
                            Button("Save"){
                                guard let inputImage = inputImage else{return}
                                let image = Image(uiImage: inputImage)
                                let imageDesc = ImageDesc(name: inputImageName, image: image, uiImage: inputImage)
                                guard let userlocation = locationFetcher.lastKnownLocation else {return}
                                location = userlocation
                                imageDescArray.append(imageDesc)
                                
                                showNamePrompt = false
                            }.disabled(inputImageName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding()
                        
                    }else{}
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Image"){
                        showPhotoPickerSheet = true
                    }
                }
            }
            .sheet(isPresented: $showPhotoPickerSheet, content: {ImagePicker(selectedImage: $inputImage)})
            .onChange(of: inputImage, perform: {image in
                showNamePrompt = true
                
            })
            .navigationTitle("Image Gallery")
        }.padding(3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


