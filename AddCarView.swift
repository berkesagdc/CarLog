//
//  AddCarView.swift
//  CarLog2
//
//  Created by Berke Sağdıç on 11.07.2026.
//
import SwiftUI
import SwiftData

struct AddCarView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var marka = ""
       @State private var model = ""
       @State private var modelYili = ""
       @State private var plaka = ""
    @State private var kilometre = ""

    var body: some View {
        NavigationStack {
            Form {

                Section("Araç Bilgileri") {

                    TextField("Marka", text: $marka)

                    TextField("Model", text: $model)
                    
                    TextField("Model Yılı", text: $modelYili)
                    
                    TextField("Plaka", text: $plaka)
                    TextField("Kilometre", text: $kilometre)
                        .keyboardType(.numberPad)
                }

                Button("Kaydet") {

                    let yeniArac = Car(
                        brand: marka,
                        model: model,
                        year: modelYili,
                        plate: plaka,
                        mileage: kilometre
                    )

                    modelContext.insert(yeniArac)

                    dismiss()
                }
            }
            .navigationTitle("Araç Ekle")
        }
    }
}

#Preview {
    AddCarView()
}
