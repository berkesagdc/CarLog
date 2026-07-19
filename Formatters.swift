import Foundation

enum Formatters {

    static func kilometer(_ value: String) -> String {

        guard let number = Int(value) else {
            return value
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "tr_TR")

        return "\(formatter.string(from: NSNumber(value: number)) ?? value) km"
    }

    static func currency(_ value: String) -> String {

        guard let number = Double(value) else {
            return value
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.currencySymbol = "₺"

        return formatter.string(from: NSNumber(value: number)) ?? value
    }

    static func consumption(_ value: Double) -> String {

        String(format: "%.2f L / 100 km", value)
    }
}
