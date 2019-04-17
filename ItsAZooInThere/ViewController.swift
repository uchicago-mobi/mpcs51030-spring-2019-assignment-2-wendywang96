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
        //self.scrollView.delegate = self as! UIScrollViewDelegate
        scrollView.contentSize = CGSize(width: 1125, height:500)
        
        // MARK: button
        for i in 0...2{
            let button = UIButton(type: .system)
            button.setTitle(animals[i].name, for: .normal) // set the title to be the current animal’s name.
            button.tag = i // tag is the index of the animal
            button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
            button.frame = CGRect(x: 375*i, y: 40, width: 375, height: 60)
            scrollView.addSubview(button)
        }
    }


}

