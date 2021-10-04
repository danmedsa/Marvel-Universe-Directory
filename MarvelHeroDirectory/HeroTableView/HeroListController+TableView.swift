//
//  HeroListController+TableView.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/29/21.
//

import UIKit

extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    private var loadedCharacters: Int {
        viewModel.characterListSize
    }
    
    private var totalCharacters: Int {
        viewModel.characterList?.data.total ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.cellIdentifier) as? HeroTableViewCell,
              let character = viewModel.getHero(for: index)
                else { return UITableViewCell() }
        
        loadNextPageIfNeeded(at: index, for: cell)
        
        cell.configure(with: character)
        return cell
    }
    
    /// Makes a request for the next page of characters once the en of the `tableView` is reached
    func loadNextPageIfNeeded(at index: Int, for cell: HeroTableViewCell) {
        // Load More another page of Characters when loading last index
        if index == loadedCharacters - 1,
           !listFitsInScreen(with: cell.bounds.height),
           !isLastElementLoaded(at: index),
           lastServiceRequestCell != cell { // avoid spamming requests when no internet connection and trying to load new page
            lastServiceRequestCell = cell
            getHeroList(text: searchText, page: viewModel.page)
        }
    }
    
    /// Determines de amount of cell that fin in the device screen
    // to avoid trying to get a new page when all elements fit in a screen
    func listFitsInScreen(with height: CGFloat) -> Bool {
        let cellsInScreen = (tableView.frame.height / height).rounded(.up)
        return viewModel.characterDataSource.count < Int(cellsInScreen)
    }
    
    func isLastElementLoaded(at index: Int) -> Bool {
        index >= totalCharacters - 1
    }
}
