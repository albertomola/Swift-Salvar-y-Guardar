//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by alberto on 12/4/24.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    //private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-in First"]
    @EnvironmentObject var settingStore: SettingStore
    @State private var selectedOrder =  DisplayOrderType.alphabetical
        //@State private var selectedOrder = 0
        @State private var showCheckInOnly = false
        @State private var maxPriceLevel = 5
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $selectedOrder, label: Text("Orden")) {
                    ForEach(DisplayOrderType.allCases, id: \.self){
                        orderType in
                        Text(orderType.text)
                            }
                        }
                    }
                Section(header: Text("ELIGE TU FILTRO")) {
                    Toggle(isOn: $showCheckInOnly) {
                           Text("Solo los visitados")
                       }
                    Stepper(onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    }, onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                } }) {
                Text("Mostrar \(String(repeating: "$", count: maxPriceLevel)) o menos")
                    
                }
                    
                }
                    
            }
            
            
            .navigationBarTitle("Settings")
            .navigationBarItems(leading:
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label:{
                Text("Cancel")
                    .foregroundColor(.black)
            })
                                
            , trailing:
            Button(action: {
            self.settingStore.showCheckInOnly = self.showCheckInOnly
                
                self.settingStore.displayOrder = self.selectedOrder
                
                self.settingStore.maxPriceLevel = self.maxPriceLevel
                
                self.presentationMode.wrappedValue.dismiss()
                
            }, label:{
                Text("Save")
                    .foregroundColor(.black)
            })
            
            
            )
            
        }
    
        .onAppear {
            self.selectedOrder = self.settingStore.displayOrder
            
            self.showCheckInOnly = self.settingStore.showCheckInOnly

            self.maxPriceLevel = self.settingStore.maxPriceLevel
        }
    }
    
}
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(SettingStore())    }
}

