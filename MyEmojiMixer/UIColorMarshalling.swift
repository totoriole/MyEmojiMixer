//
//  UIColorMarshalling.swift
//  MyEmojiMixer
//
//  Created by Bumbie on 19.12.2023.
//

import UIKit

final class UIColorMarshalling {
    
    func colorToHexString (from color: UIColor) -> String {
        // Получаем компоненты цвета из его цветового пространства
        let components = color.cgColor.components
        // Извлекаем значения красной, зеленой и синей компонент цвета
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        // Форматируем значения компонент цвета в строку шестнадцатеричного кода
        return String.init(format: "%02lX%02lX%02lX",
        lroundf(Float(r*255)),
        lroundf(Float(g*255)),
        lroundf(Float(b*255))
        )
    }
    
    func hexStringToColor (from hex: String) -> UIColor {
        var rgbvalue: UInt64 = 0
        // Извлекаем целочисленное значение из строки шестнадцатеричного кода
        Scanner(string: hex).scanHexInt64(&rgbvalue)
        // Разбиваем значение на отдельные компоненты (красный, зеленый, синий)
        return UIColor(red: CGFloat((rgbvalue & 0xFF0000)>>16) / 255.0,
                       green: CGFloat((rgbvalue & 0x00FF00)>>8) / 255.0,
                       blue: CGFloat(rgbvalue & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
}
