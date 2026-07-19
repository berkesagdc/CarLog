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

    private var formIsValid: Bool {
        !marka.trimmingCharacters(in: .whitespaces).isEmpty &&
        !model.trimmingCharacters(in: .whitespaces).isEmpty &&
        !modelYili.trimmingCharacters(in: .whitespaces).isEmpty &&
        !plaka.trimmingCharacters(in: .whitespaces).isEmpty &&
        Int(kilometre) != nil
    }

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
            }
            .navigationTitle("Araç Ekle")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("İptal") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kaydet") {

                        let newCar = Car(
                            brand: marka,
                            model: model,
                            year: modelYili,
                            plate: plaka,
                            mileage: kilometre
                        )

                        modelContext.insert(newCar)

                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Kayıt hatası:", error)
                        }
                    }
                    .disabled(!formIsValid)
                }
            }
        }
    }
}

#Preview {
    AddCarView()
}
