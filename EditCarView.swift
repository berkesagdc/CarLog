import SwiftUI
import SwiftData

struct EditCarView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let car: Car

    @State private var brand = ""
    @State private var model = ""
    @State private var year = ""
    @State private var plate = ""
    @State private var mileage = ""

    private var formIsValid: Bool {
        !brand.trimmingCharacters(in: .whitespaces).isEmpty &&
        !model.trimmingCharacters(in: .whitespaces).isEmpty &&
        !year.trimmingCharacters(in: .whitespaces).isEmpty &&
        !plate.trimmingCharacters(in: .whitespaces).isEmpty &&
        Int(mileage) != nil
    }

    var body: some View {

        NavigationStack {

            Form {

                Section("Araç Bilgileri") {

                    TextField("Marka", text: $brand)

                    TextField("Model", text: $model)

                    TextField("Model Yılı", text: $year)

                    TextField("Plaka", text: $plate)

                    TextField("Kilometre", text: $mileage)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Araç Düzenle")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("İptal") {

                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kaydet") {

                        car.brand = brand
                        car.model = model
                        car.year = year
                        car.plate = plate
                        car.mileage = mileage

                        try? modelContext.save()

                        dismiss()
                    }
                    .disabled(!formIsValid)
                }
            }
            .onAppear {

                brand = car.brand
                model = car.model
                year = car.year
                plate = car.plate
                mileage = car.mileage
            }
        }
    }
}

#Preview {
    Text("Preview")
}
