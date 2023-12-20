//
//  ViewController.swift
//  MyEmojiMixer
//
//  Created by Toto Tsipun on 09.11.2023.
//

import UIKit

final class EmojiViewController: UIViewController {
    private let emojiMixerFactory = EmojiMixerFactory()
    private let emojiMixStore = EmojiMixStore()
    
    private var visibleEmojiesMix: [EmojiMix] = []
    
    let collectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
    }()
    
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
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmojiMixer))
            navigationBar.topItem?.setRightBarButton(addButton, animated: false)
        }
        visibleEmojiesMix = try! emojiMixStore.fetchEmojiMixes()
    }
    
    @objc private func addNewEmojiMixer() {
        let newEmojiMix = emojiMixerFactory.makeNewMix()
        let newtEmojiesIndex = visibleEmojiesMix.count
        try! emojiMixStore.addNewEmojiMix(newEmojiMix)
        visibleEmojiesMix = try! emojiMixStore.fetchEmojiMixes()
//        visibleEmojiesMix.append(newEmojiMix)
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: newtEmojiesIndex, section: 0)])
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        visibleEmojiesMix.count
    }
    
    // настройка и возвращение ячеек для отображения в UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //возвращаем переиспользуемую ячейку с заданным идентификатором ("cell") для указанного индекса позиции
        // Важно, чтобы идентификатор "cell" совпадал с тем, который был использован при регистрации ячейки
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiesCell else {
            return UICollectionViewCell()
        }
        let emojiMix = visibleEmojiesMix[indexPath.row]
        cell.labelForCell.text = emojiMix.emoji
        cell.contentView.backgroundColor = emojiMix.colorBackground
        return cell
    }
    
}

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    //MARK: - Размеры ячеек. Исходя из контента:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inSet = collectionView.contentInset //Получение отступов от краев коллекции.
        let vailableWidth = collectionView.bounds.width - inSet.left - inSet.right //Вычисление доступной ширины для ячейки, учитывая отступы.
        let minSpacing = 10.0 //Определение минимального расстояния между ячейками.
        let itemsPerRow = 2.0 //Определение количества элементов в строке.
        let itemWidth = (vailableWidth - (itemsPerRow - 1) * minSpacing) / itemsPerRow //вычисление ширины каждой ячейки. Рассчитывается как доступная ширина за вычетом промежутков между ячейками, деленная на количество элементов в строке.
        return CGSize(width: itemWidth, height: itemWidth)
    }
    //MARK: - Убрать или указать размер отступа (минимальное расстояние между элементами (ячейками) внутри одной секции )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }
}

