//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by 王怡珺 on 2019/4/17.
//  Copyright © 2019 Yijun Wang. All rights reserved.
//

import UIKit
import AVFoundation

class Animal: CustomStringConvertible{
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    var description: String {
        return "Animal: name = \(name), species = \(species), age = \(age)"
    }
    
    init(_ name: String, _ species: String, _ age: Int,  _ image: UIImage, _ soundPath: String){
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
}

class ViewController: UIViewController {
    var animals : Array<Animal> = Array()
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: animals array
        let cat = Animal("Miao", "Cat", 3, UIImage(named: "cat")!, "cat")
        let dog = Animal("Wang", "Dog", 2, UIImage(named: "dog")!, "dog")
        let bird = Animal("Nini", "Bird", 1, UIImage(named: "bird")!, "bird")
        
        animals.append(cat)
        animals.append(dog)
        animals.append(bird)
        
        // Shuffle the array after adding the animals to it
        animals.shuffle()
        
        // MARK: scrollView
        self.scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1125, height:500)
        
        // MARK: button
        for i in 0...2{
            let button = UIButton(type: .system)
            button.setTitle(animals[i].name, for: .normal) // set the title to be the current animal’s name.
            button.tag = i // tag is the index of the animal
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.frame = CGRect(x: 375*i, y: 40, width: 375, height: 60)
            scrollView.addSubview(button)
        }
        
        // MARK: image scroll
        for i in 0...2{
            let imageView = UIImageView()
            let x = self.view.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.image = animals[i].image
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
        
        // label show the first species
        label.textAlignment = .center
        label.text = animals[0].species
        
    }
    
    // MARK: buttonTapped
    @objc func buttonTapped(sender: UIButton){
        // get the current animal
        let animalId = sender.tag
        let animal : Animal = animals[animalId]
        
        // alert info
        var yearOrS : String
        // decide year or years
        if (animal.age == 1){
            yearOrS = "year"
        }
        else{
            yearOrS = "years"
        }
        let animalInfo = UIAlertController(title: animal.name, message: "This \(animal.species) is \(animal.age) \(yearOrS) old.", preferredStyle: .alert)
        animalInfo.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(animalInfo, animated: true, completion: nil)
        print(animal.description)
        
        // MARK: AVAudioPlayer
        
        let soundURL = Bundle.main.url(forResource: animal.soundPath, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            
        } catch  {
            print(error)
        }
        audioPlayer.play() // playing sound
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //set the view controller as the scroll view’s delegate
        scrollView.delegate = self
        
        // set the label accroding to the page and animal species
        label.textAlignment = .center
        let pageNum = round(scrollView.contentOffset.x/view.frame.width)
        let animal : Animal = animals[Int(pageNum)]
        label.text = animal.species
        
        // transparency
        label.alpha = abs((scrollView.contentOffset.x/view.frame.width).truncatingRemainder(dividingBy: 1) - 0.5) * 2
    }
}
