//
//  PBTimestamp.swift
//  
//
//  Created by Alexandre Hauber on 29/07/21.
//

import SwiftUI

public struct PBTimestamp: View {
    let timestamp: Date
    let amPmStyle: AmPmStyle
    let showDate: Bool
    let showTimeZone: Bool
    let showUser: Bool
    let text: String?
    let timeZone: String?
    let variant: Variant

    public init(
        _ timestamp: Date,
        amPmStyle: AmPmStyle = .short,
        showDate: Bool = true,
        showTimeZone: Bool = false,
        showUser: Bool = false,
        text: String? = nil,
        timeZone: String? = nil,
        variant: Variant = .standard
    ) {
        self.timestamp = timestamp
        self.amPmStyle = amPmStyle
        self.showDate = showDate
        self.showTimeZone = showTimeZone
        self.showUser = showUser
        self.text = text
        self.timeZone = timeZone
        self.variant = variant
    }

    var editedTimestamp: String {
        var text = " "
        switch variant {
        case .elapsed: text = "Last updated \(userDisplay)\(formattedElapsed)"
        case .updated: text = "Last updated \(userDisplay)on \(formattedUpdated)"
        default: text = formattedDefault
        }
        return text
    }

    var formattedDefault: String {
        let formatter = DateFormatter()

        if showDate {
            let inputDate = Calendar.current.dateComponents([.year], from: timestamp)
            let currentDate = Calendar.current.dateComponents([.year], from: Date())

            if let inputYear = inputDate.year, let currentYear = currentDate.year, inputYear > currentYear {
                formatter.dateFormat = "MMM d, YYYY \u{00b7} h:mma"
            } else {
                formatter.dateFormat = "MMM d \u{00b7} h:mma"
            }
        } else {
            formatter.dateFormat = "h:mma"
        }

        if let timeZone = timeZone, showTimeZone {
            formatter.timeZone = TimeZone(identifier: timeZone)
            formatter.dateFormat.append(" z")
        }

        if amPmStyle == .short {
            formatter.amSymbol = "a"
            formatter.pmSymbol = "p"
        } else {
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
        }

        return formatter.string(from: timestamp)
    }

    var formattedElapsed: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full

        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }

    var formattedUpdated: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d 'at' h:mma"

        if amPmStyle == .short {
            formatter.amSymbol = "a"
            formatter.pmSymbol = "p"
        } else {
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
        }

        return formatter.string(from: timestamp)
    }

    var userDisplay: String {
        if let text = text, showUser {
            return "by \(text) "
        } else {
            return ""
        }
    }

    public var body: some View {
        Text(editedTimestamp).pbFont(.subcaption)
    }
}

public extension PBTimestamp {
    enum AmPmStyle {
        case short
        case full
    }

    enum Variant {
        case elapsed
        case standard
        case updated
    }
}

struct PBTimestamp_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()
        let timeInterval: TimeInterval = 31536000
        let minWidth: CGFloat = 0

        return List {
            Section("Default") {
                VStack(alignment: .leading, spacing: nil) {
                    PBTimestamp(Date(), showDate: false)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date())
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date().addingTimeInterval(timeInterval))
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                }
            }

            Section("Alignments") {
                VStack(alignment: .leading, spacing: nil) {
                    PBTimestamp(Date(), showDate: false)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date())
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date().addingTimeInterval(timeInterval))
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

                    PBTimestamp(Date(), showDate: false)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
                    PBTimestamp(Date())
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
                    PBTimestamp(Date().addingTimeInterval(timeInterval))
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

                    PBTimestamp(Date(), showDate: false)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
                    PBTimestamp(Date())
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
                    PBTimestamp(Date().addingTimeInterval(timeInterval))
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
                }
            }

            Section("Timezones") {
                VStack(alignment: .leading, spacing: nil) {
                    PBTimestamp(Date(), showDate: false, showTimeZone: true, timeZone: "America/New_York")
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date(), showTimeZone: true, timeZone: "America/New_York")
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(
                        Date().addingTimeInterval(timeInterval),
                        showTimeZone: true,
                        timeZone: "America/New_York"
                    )
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

                    PBTimestamp(Date(), showDate: false, showTimeZone: true, timeZone: "Asia/Hong_Kong")
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date(), showTimeZone: true, timeZone: "Asia/Hong_Kong")
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date().addingTimeInterval(timeInterval), showTimeZone: true, timeZone: "Asia/Hong_Kong")
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                }
            }

            Section("Last Updated By") {
                VStack(alignment: .leading, spacing: nil) {
                    PBTimestamp(
                        Date().addingTimeInterval(-12),
                        showUser: true,
                        text: "Andrew Koeckler",
                        variant: .updated
                    )
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date().addingTimeInterval(-12), variant: .updated)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                }
            }

            Section("Time Ago") {
                VStack(alignment: .leading, spacing: nil) {
                    PBTimestamp(
                        Date().addingTimeInterval(-10),
                        showUser: true,
                        text: "Andrew Koeckler",
                        variant: .elapsed
                    )
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                    PBTimestamp(Date().addingTimeInterval(-88000), variant: .elapsed)
                        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
