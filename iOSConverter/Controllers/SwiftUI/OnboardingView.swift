//
//  OnboardingView.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-05.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.presentationMode) private var mode
    @State private var tabViewSelection = 0
    
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .multilineTextAlignment(.leading)
                    .font(.custom(UIFont.ralewayLight, size: 25))
                    .foregroundColor(Color(UIColor.navyBlue))
                Text("Capita")
                    .multilineTextAlignment(.leading)
                    .font(.custom(UIFont.ralewaySemiBold, size: 36))
                    .foregroundColor(Color(UIColor.navyBlue))
            }
            .padding()
            TabView(selection: $tabViewSelection) {
                Group{
                    Image("star1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .tag(0)
                    Image("star2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .tag(1)
                    Image("star3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .tag(2)
                }
            }
            .tabViewStyle(.page)
            .disabled(true)
            Button {
                if tabViewSelection == 2 {
                    UserDefaults.standard.set(true, forKey: K.Keys.DidOnboard)
                    mode.wrappedValue.dismiss()
                } else {
                    withAnimation(.easeInOut(duration: 2)) {
                        tabViewSelection += 1
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(UIColor.navyBlue).opacity(0.2))
                    HStack {
                        Text("NEXT")
                            .font(.custom(UIFont.ralewaySemiBold, size: 24))
                            .foregroundColor(Color(UIColor.navyBlue))
                        Spacer()
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    .padding()
                }
            }
            .frame(height: 60)
            .padding()
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {
            
        }
    }
}
#endif
