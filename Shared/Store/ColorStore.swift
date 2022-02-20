//
//  ColorStore.swift
//  DETimeLog
//
//  Created by martinhartl on 19.02.22.
//

import Foundation

final class ColorStore {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func colors(for categories: [Category]) -> [Category: CGColor] {
        categories.reduce(into: [Category: CGColor]()) { partialResult, category in
            partialResult[category] = color(for: category)
        }
    }

    func color(for category: Category) -> CGColor {
        let color = userDefaults.colorByCategory[category]
        if let color = color {
            return CGColor.color(hex: color.hex)
        } else {
            let randomColorHex = CGColor(gray: 0.2, alpha: 1.0)
            let newColor = Color(hex: randomColorHex.hexString)
            var colors = userDefaults.colorByCategory
            colors[category] = newColor
            userDefaults.colorByCategory = colors
            return CGColor(gray: 0.2, alpha: 1.0)
        }
    }

    func set(color: CGColor, for category: Category) {
        userDefaults.colorByCategory[category] = Color(hex: color.hexString)
    }
}

extension UserDefaults {
    var colorByCategory: [Category: Color] {
        get {
            guard let data = data(forKey: #function),
                  let tags = try? PropertyListDecoder().decode([Category: Color].self, from: data) else {
                      return [:]
                }
            return tags
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else {
                return
            }

            set(data, forKey: #function)
        }
    }
}
