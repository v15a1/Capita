//
//  OnboardingView.swift
//  iOSConverter
//
//  Created by Visal Rajapakse on 2022-04-05.
//

import SwiftUI

/// Swift UI View for Onboarding
/// Has been ported to UIKit using `UIViewRepresentable`
struct OnboardingView: View {
    @Environment(\.presentationMode) private var mode
    @State private var tabViewSelection = 0
        
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
                    VStack {
                        (Text("Auto calculate your") + Text("\nfinances"))
                            .multilineTextAlignment(.center)
                            .font(.custom(UIFont.ralewaySemiBold, size: 26))
                            .padding()
                        Image("AutoCalculate")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 80)
                    }
                    .tag(0)
                    VStack {
                        (Text("Hard to keep everything in check?") + Text("\n\nDon't worry, we can save your data"))
                            .multilineTextAlignment(.center)
                            .font(.custom(UIFont.ralewaySemiBold, size: 26))
                            .padding()
                        Image("SaveData")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 80)
                    }
                    .tag(1)

                }
            }
            .tabViewStyle(.page)
            .disabled(true)
            Button {
                if tabViewSelection == 1 {
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
        OnboardingView()
    }
}
#endif
