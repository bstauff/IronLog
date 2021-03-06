//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/25/22.
//

import SwiftUI

struct AddLiftSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var liftCatalog: LiftCatalog
    
    @State private var name: String = ""
    @State private var trainingMax: Int?
    @State private var isError = false
    @State private var errorString = ""
    
    var body: some View {
        HStack {
            VStack {
                Text(
                    "Lift Name")
                TextField(
                    "Lift Name",
                    text: $name
                )
                Text("Training Max")
                TextField(
                    "Training Max",
                    value: $trainingMax,
                    format: .number
                ).keyboardType(.numberPad)
                Button("Save") {
                    saveClicked()
                }
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $isError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorString),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    private func saveClicked() {
        guard name != "" else {
            isError = true
            errorString = "lift name required"
            return
        }
        
        guard trainingMax != nil else {
            isError = true
            errorString = "training max required"
            return
        }
        let newLift = Lift(
            name: name,
            trainingMax: trainingMax!
        )
        liftCatalog.lifts.append(newLift)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        AddLiftSheetView(liftCatalog: liftCatalog)
    }
}
