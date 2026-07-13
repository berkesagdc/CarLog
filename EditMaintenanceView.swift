import SwiftUI
import SwiftData

struct EditMaintenanceView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let maintenance: Maintenance

    @State private var title = ""
    @State private var mileage = ""
    @State private var note = ""

    var body: some View {

        NavigationStack {

            Form {

                Section("Bakım") {

                    TextField("Bakım Adı", text: $title)

                    TextField("Kilometre", text: $mileage)

                    TextField("Not", text: $note)
                }
            }
            .navigationTitle("Bakımı Düzenle")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("İptal") {

                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kaydet") {

                        maintenance.title = title
                        maintenance.mileage = mileage
                        maintenance.note = note

                        try? modelContext.save()

                        dismiss()
                    }
                }
            }
            .onAppear {

                title = maintenance.title
                mileage = maintenance.mileage
                note = maintenance.note
            }
        }
    }
}

#Preview {
    Text("Preview")
}
