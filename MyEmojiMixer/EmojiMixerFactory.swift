//
//  EmojiMixerFactory.swift
//  MyEmojiMixer
//
//  Created by Bumbie on 18.12.2023.
//

import UIKit

struct EmojiMix {
    let emoji: String
    let colorBackground: UIColor
}

final class EmojiMixerFactory {
    // Отображаем в коллекции ячеек
    let emojies = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    func makeNewMix() -> EmojiMix {
        let first = emojies.randomElement()!
        let second = emojies.randomElement()!
        let third = emojies.randomElement()!
        let newThreeEmojies = (first, second, third)
        
        return EmojiMix(emoji: ("\(first)\(second)\(third)"), colorBackground: makeColor(newThreeEmojies))
    }
    
    private func makeColor(_ emojies: (String, String, String)) -> UIColor {
        func cgFloat256(_ t: String) -> CGFloat {
            let value = t.unicodeScalars.reduce(Int(0)) { r,t in
                r + Int(t.value)
            }
            return CGFloat(value % 128) / 255 + 0.25
        }
        return UIColor (
            red: cgFloat256(emojies.0),
            green: cgFloat256(emojies.1),
            blue: cgFloat256(emojies.2),
            alpha: 1
        )
    }
}
