//
//  CountryMapAnnotationView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import SwiftUI

struct CountryMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack (spacing: 0) {
                    Image(systemName: "map.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(accentColor)
                        .cornerRadius(38)
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(accentColor)
                        .frame(width: 10, height: 10)
                        .rotationEffect(Angle(degrees: 180))
                        .offset(y: -3)
                        .padding(.bottom, 40)
                }
    }
}

struct CountryMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        CountryMapAnnotationView()
    }
}
