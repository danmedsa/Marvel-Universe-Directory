//
//  HeroDetailsViewController.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/2/21.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: CachingImageView!
    @IBOutlet weak var bio: UITextView!
    
    static let identifier = "HeroDetailsController"
    
    var viewModel: HeroDetailsViewModel?
    
    func configure(with viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        name.text = viewModel?.character.name ?? ""
        guard let description = viewModel?.character.description else {
            bio.isHidden = true
            return
        }
        bio.text = description
        if let thumbnail = viewModel?.character.thumbnail {
            image.setImage(thumbnail: thumbnail)
        }
    }
}
