//
//  HeroTableViewCell.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/1/21.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet weak var heroImage: CachingImageView!
    
    private(set) var character: Character?
    
    static let cellIdentifier = "HeroDirectoryCell"
    
    /// Congfigure TableView Cell with `Character`
    func configure(with character: Character) {
        self.character = character
        title.text = character.name
        heroImage.setImage(thumbnail: character.thumbnail)
        let accessibilityId = character.name.replacingOccurrences(of: " ", with: "")
        self.accessibilityIdentifier = "cell.\(accessibilityId)"
        self.heroImage.accessibilityIdentifier = "imageView.\(accessibilityId)"
    }
}
