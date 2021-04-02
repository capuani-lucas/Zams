//
//  ContentView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            JobScreenView()
            
           
            
        } // End Z stack
        .environmentObject(JobController(context: context))
    }
}

struct ContentViewPreview : View {
    @Environment(\.managedObjectContext) var context
    var body: some View {
        ContentView()
            .environmentObject(JobController(context: context))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPreview()
    }
}

extension Color {
    public static var header: Color {
        return Color(red: 236 / 255, green: 240 / 255, blue: 241 / 255)
    }
    
    public static var ashphalt: Color {
        return Color(red: 52 / 255, green: 73 / 255, blue: 94 / 255)
    }
    
    public static var money: Color {
        return Color(red: 39 / 255, green: 174 / 255, blue: 96 / 255)
    }
    
    public static var background: Color {
        return Color(red: 44 / 255, green: 62 / 255, blue: 80 / 255)
    }
    
}
