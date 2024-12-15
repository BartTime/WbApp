//
//  editProfile.swift
//  Landmarks
//
//  Created by Alex on 03.07.2024.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct EditProfile: View {
    @Binding var profile: Profile
    @State private var temporaryProfile: Profile
    @Environment(\.presentationMode) var presentationMode
    
    init(profile: Binding<Profile>) {
        self._profile = profile
        self._temporaryProfile = State(initialValue: profile.wrappedValue)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TextField(
                "Username",
                text: $temporaryProfile.username
            )
            .textFieldStyle(.roundedBorder)
            
            Toggle(isOn: $temporaryProfile.prefersNotifications, label: {
                Text("Notifications")
            })
            
            Picker("Seasonal photo", selection: $temporaryProfile.seasonalPhoto) {
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            .pickerStyle(.segmented)
            
            DatePicker(
                "Goal date",
                selection: $temporaryProfile.goalDate,
                displayedComponents: [.date]
            )
            
            Spacer()
            
            Button(action: saveChanges) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Edit Profile")
    }
    
    private func saveChanges() {
        profile = temporaryProfile
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    EditProfile(profile: .default)
//        .environment(ModelData())
//}
