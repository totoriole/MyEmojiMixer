//
//  EmojiMixStore.swift
//  MyEmojiMixer
//
//  Created by Bumbie on 19.12.2023.
//

import UIKit
import CoreData

final class EmojiMixStore {
    let appDelegate = AppDelegate()
    let uiColorMarshalling = UIColorMarshalling()
    
    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let emogiMixCoreData = EmojiMixCoreData(context: appDelegate.context)
        updateExistingEmojiMix(emogiMixCoreData, with: emojiMix)
        appDelegate.saveContext()
    }
    
    func updateExistingEmojiMix(_ emojiMixCoreData: EmojiMixCoreData, with mix: EmojiMix) {
        emojiMixCoreData.emojis = mix.emoji
        emojiMixCoreData.colorHex = uiColorMarshalling.colorToHexString(from: mix.colorBackground)
    }
    
}
