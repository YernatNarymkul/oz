//
//  OnboardingViewController.swift
//  ozinsheDemo4
//
//  Created by Ернат on 23.09.2023.
//

// Импорт библиотеки UIKit для работы с пользовательским интерфейсом
import UIKit

// Объявление класса OnboardingViewController, который наследуется от базового класса UIViewController и реализует протоколы UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
class OnboardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Объявление UI элементов: коллекция слайдов и индикатор слайдов
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
 //   @IBOutlet weak var welcomeLabel: UILabel!
    // Объявление массива слайдов
    var arraySlides = [["firstSlide", "ÖZINŞE-ге қош келдің!", "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"],
                       ["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"],
                       ["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    // Объявление текущего слайда, при изменении его значения мы обновляем индекс текущей страницы компонента pageControl
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    // Метод, который вызывается после загрузки представления, но перед тем как пользователь увидит это
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Задать делегата и источник данных для collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // Метод, который вызывается перед тем, как представление появляется на экране
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Скрыть навигационную панель
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Метод, который вызывается перед тем, как представление исчезнет с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Показать навигационную панель
        navigationController?.setNavigationBarHidden(false, animated: animated)
        // Установить заголовок навигационной панели в пробел (" ")
        navigationItem.title = " "
    }
    
    // Метод, который будет вызываться при нажатии на кнопку
    @objc func nextButtonTouched() {
        // Приводим UIViewController к типу SingInViewController
        if let singInViewController = storyboard?.instantiateViewController(withIdentifier: "SingInViewController") {
            // Показываем SingInViewController
            navigationController?.show(singInViewController, sender: self)
        }
    }
    
    // MARK: - collectionView
    // Указываем количество элементов в коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlides.count
    }
    
    // Указываем содержание каждого элемента коллекции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Получаем ячейку по идентификатору "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if let imageview = cell.viewWithTag(1000) as? UIImageView {
            imageview.image = UIImage(named: arraySlides[indexPath.row][0])
        }
        
        if let titleLabel = cell.viewWithTag(1001) as? UILabel {
            titleLabel.text = arraySlides[indexPath.row][1]
        }
        
        if let descriptionLabel = cell.viewWithTag(1002) as? UILabel {
            descriptionLabel.text = arraySlides[indexPath.row][2]
        }
        
        if let button = cell.viewWithTag(1003) as? UIButton {
            button.layer.cornerRadius = 8
            if indexPath.row == 2 {
                button.isHidden = true
            }
            button.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        }
        
        if let nextbutton = cell.viewWithTag(1004) as? UIButton {
            nextbutton.layer.cornerRadius = 12
            if indexPath.row != 2 {
                nextbutton.isHidden = true
            }
            nextbutton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
     layout collectionViewLayout: UICollectionViewLayout,
     insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

