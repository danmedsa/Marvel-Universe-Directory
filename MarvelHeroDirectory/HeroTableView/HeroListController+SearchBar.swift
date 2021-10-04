//
//  HeroListController+SearchBar.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/30/21.
//

import UIKit

extension HeroListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadAllCharacters()
    }
    
    func loadAllCharacters() {
        viewModel.clearListData()
        searchBar.endEditing(true)
        searchText = searchBar.text
        getHeroList(text: searchText)
    }
}
