//
//  HeroListViewModel.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/29/21.
//

import Foundation

protocol HeroListViewModelProtocol {
    func getHero(for index: Int) -> Character?
    func getHeroList(text: String?, completionHandler: @escaping (ServiceError?)->())
}

class HeroListViewModel {
    
    var characterList: CharacterList?
    var characterDataSource = [Character]()
    var webservice: ServiceHandling = ServiceHandler()
    var page = 0
    
    var characterListSize: Int {
        characterDataSource.count
    }
    
    init(webservice: ServiceHandling) {
        self.webservice = webservice
    }
    
    func getHero(for index: Int) -> Character? {
        guard !characterDataSource.isEmpty, index < characterDataSource.count else { return nil }
        return characterDataSource[index]
    }
    
    func fetchNewPage(for index: Int) {
        if let elementsLoaded = characterList?.data.results.count,
           index == elementsLoaded - 1 { // is Last Element
        }
    }
    
    /// Makes service call to get `Character`s data
    func getHeroList(text: String?, page: Int, completionHandler: @escaping (ServiceError?)->()) {
        webservice.fetchHeroList(text: text, page: page) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let characterList):
                self.page += 1
                self.characterList = characterList
                self.characterDataSource.append(contentsOf: characterList.data.results)
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
                if let text = text, !text.isEmpty, error == ServiceError.searchUnavailable {
                    self.getHeroList(text: nil, page: page, completionHandler: {_ in })
                }
            }
        }
    }
    
    func clearListData() {
        characterDataSource = []
        page = 0
    }
}
