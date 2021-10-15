//
//  ReaderBaseVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 02.11.2020.
//

import UIKit

class ReaderBaseVC: UITabBarController {
    
    // MARK: - Свойства
    private var currentTabBarIndex: Int = 0
    
    private let newsVC = NewsVC()
    private let sourceVC = SourceListVC()
    
    // MARK: - Функции
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        sourceVC.delegate = newsVC
        configureViewController()
    }
    
    override func viewDidLayoutSubviews() {
        setupTabBar()
    }
    
    // MARK: - Расстановка UI элементов
    /// Настраиваем все страницы Tab Bar на необходимые контроллеры представления
    private func configureViewController() {
        
        guard let rssImage = UIImage(named: "rss"),
              let sourceImage = UIImage(named: "bookmark") else { return }
        
        let news = constructNavController(unselectedImage: rssImage, rootViewController: newsVC, navTitle: "Главная", tabBarTag: 0)
        let source = constructNavController(unselectedImage: sourceImage, rootViewController: sourceVC, navTitle: "Источники", tabBarTag: 1)
        
        viewControllers = [news, source]
    }
    
    /// Установка TabBar
    private func setupTabBar() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let tabItems = tabBar.items else { return }

        let numberOfItems = CGFloat(tabItems.count)
        var safeAreaInset: CGFloat = 0.0

        if window?.safeAreaInsets.bottom != nil {
            safeAreaInset = 6
        }
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems + 10, height: tabBar.frame.height + 10 + safeAreaInset)
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: ThemeManager.Color.sberColor, size: tabBarItemSize)
        
        tabBar.tintColor = .white
    }
    
    /// Настраивает контроллер навигации
    ///
    /// - Parameters:
    ///     - unselectedImage: Изображение которое представляет текущую страницу
    ///     - rootViewController: Родительский экран
    ///     - containerColor: Цвет контейнера, где лежат все элементы
    ///     - navTitle: Заголовок NavigationController
    ///     - tabBarTag: Порядковый номер в Tab Bar
    /// - Returns:
    ///     Созданный контроллер навигации
    private func constructNavController(unselectedImage: UIImage, rootViewController: UIViewController, navTitle: String, tabBarTag: Int) -> UINavigationController {
        
        // Создаем контроллер навигации с необходимыми настройками
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.title = navTitle
        navController.tabBarItem.tag = tabBarTag
        
        navController.viewControllers.first?.navigationItem.title = navTitle
        
        return navController
    }
}

extension ReaderBaseVC: UITabBarControllerDelegate {
    
}

