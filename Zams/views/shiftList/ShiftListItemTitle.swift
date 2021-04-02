//
//  ShiftListItemTitle.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct ShiftListItemTitle: View {
    var body: some View {
        HStack {
            
            Text("dd/mm/yyyy")
            
            Spacer()
            
            Text("Hours")
            
            Spacer()
            
            Text("Rate")
            
            Spacer()
            
            Text("Pay")
                .foregroundColor(.green)
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxHeight: 50)
        .background(Color.ashphalt)
        .cornerRadius(12)
    }
}

struct ShiftListItemTitle_Previews: PreviewProvider {
    static var previews: some View {
        ShiftListItemTitle()
    }
}
