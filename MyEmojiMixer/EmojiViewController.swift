//
//  ViewController.swift
//  MyEmojiMixer
//
//  Created by Toto Tsipun on 09.11.2023.
//

import UIKit

final class EmojiViewController: UIViewController {
    
    private var visibleEmojies: [String] = []
    
    let collectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
    }()
    
    // Отображаем в коллекции ячеек
    private let emojies = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        configureConstraints()
        
        //MARK: - Регистрируем ячейку
        collectionView.register(EmojiesCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let navigationBar = navigationController?.navigationBar {
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmoji))
            navigationBar.topItem?.setRightBarButton(addButton, animated: false)
            let removeButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(removeLastEmoji))
            navigationBar.topItem?.setLeftBarButton(removeButton, animated: false)
        }
    }
    
    @objc private func addEmoji() {
        guard visibleEmojies.count < emojies.count else { return }
        let nextEmojiesIndex = visibleEmojies.count
        visibleEmojies.append(emojies[nextEmojiesIndex])
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: nextEmojiesIndex, section: 0)])
        }
    }
    
    @objc private func removeLastEmoji() {
        guard !visibleEmojies.isEmpty else { return }
        
        let lastEmojies = visibleEmojies.count - 1
        visibleEmojies.removeLast()
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [IndexPath(item: lastEmojies, section: 0)])
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension EmojiViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension EmojiViewController: UICollectionViewDataSource {
    // Реализуем протокол UICollectionViewDataSource для отображения данных в ячейках.
    
    // кол-во ячеек в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        visibleEmojies.count
    }
    
    // настройка и возвращение ячеек для отображения в UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //возвращаем переиспользуемую ячейку с заданным идентификатором ("cell") для указанного индекса позиции
        // Важно, чтобы идентификатор "cell" совпадал с тем, который был использован при регистрации ячейки
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiesCell else {
            return UICollectionViewCell()
        }
        cell.labelForCell.text = emojies[indexPath.row]
        
        return cell
    }
    
}

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    //MARK: - Размеры ячеек. Исходя из контента:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width/2, height: 50)
    }
    //MARK: - Размеры ячеек. Убрать отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

