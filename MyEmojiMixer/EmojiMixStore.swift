//
//  EmojiMixStore.swift
//  MyEmojiMixer
//
//  Created by Bumbie on 19.12.2023.
//

import UIKit
import CoreData
enum EmojiMixStoreError: Error {
    case decodingErrorInvalidEmojies
    case decodingErrorInvalidColorHex
}

final class EmojiMixStore {
    let appDelegate = AppDelegate()
    let uiColorMarshalling = UIColorMarshalling()
    
    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let emogiMixCoreData = EmojiMixCoreData(context: appDelegate.context)
        updateExistingEmojiMix(emogiMixCoreData, with: emojiMix)
        appDelegate.saveContext()
    }
    
    func updateExistingEmojiMix(_ emojiMixCoreData: EmojiMixCoreData, with mix: EmojiMix) {
        emojiMixCoreData.emojies = mix.emoji
        emojiMixCoreData.colorHex = uiColorMarshalling.colorToHexString(from: mix.colorBackground)
    }
    
    func fetchEmojiMixes() throws -> [EmojiMix] {
        let fetchRequest = EmojiMixCoreData.fetchRequest()
        let emojiMixesFromCoreData = try appDelegate.context.fetch(fetchRequest)
        return try emojiMixesFromCoreData.map { try self.emojiMix(from: $0)}
    }
    
    func emojiMix(from emojiMixCoreData: EmojiMixCoreData) throws -> EmojiMix {
        guard let emojies = emojiMixCoreData.emojies else {
            throw EmojiMixStoreError.decodingErrorInvalidEmojies
        }
        guard let colorHex = emojiMixCoreData.colorHex else {
            throw EmojiMixStoreError.decodingErrorInvalidColorHex
        }
        return EmojiMix(emoji: emojies, colorBackground: uiColorMarshalling.hexStringToColor(from: colorHex))
    }
    
}
