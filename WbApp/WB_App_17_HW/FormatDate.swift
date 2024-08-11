import Foundation

func formatDate(date: Date, with format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let currentDate = date
    
    let formattedDate = dateFormatter.string(from: currentDate)
    return formattedDate
}
