//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Mac on 6/29/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @Binding var draftProfile: Profile
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary(profile: draftProfile)
        }.padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        EditProfile(profile: $draftProfile)
                    }, label:  {
                        Image(systemName: "pencil")
                            .font(.system(size: 20, weight: .bold))
                    })
                }
            }
    }
}

//#Preview {
//    ProfileHost()
//}
