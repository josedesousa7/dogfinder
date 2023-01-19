//
//  DogListViewModel.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

protocol DogListViewModelProtocol {
    var state: DogListState { get set }
    func requestDogList(page: Int)
}

class DogListViewModel: ObservableObject {
    private var repository: DogListRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var state: DogListState = .initialLoading
    @Published var availableDogs: [DogListModel] = []
    @Published var searchResults: [DogListModel] = []
    @Published var showErrorMessage = false
    var response: [DogListModel] = []
    var totalPages = 10
    var page = 0

    init(repository: DogListRepositoryProtocol = DogListRepository()) {
        self.repository = repository
        requestDogList(page: page)
    }

    func loadMore(item: DogListModel) {
        let treshold = self.availableDogs.index(self.availableDogs.endIndex, offsetBy: -1)
        let itemIndex = self.availableDogs.firstIndex { $0.id ==  item.id }
        if treshold == itemIndex && page <= totalPages {
            page += 1
            state = .loading
            requestDogList(page: page)
        }
    }

    func filterResultsFor(_ keyword: String) {
        self.searchResults = availableDogs.filter { $0.breedName.contains(keyword) }
    }

    func sortListOfdogs() {
        let sortedResult = availableDogs.sorted(by: { $0.breedName < $1.breedName })
        availableDogs = sortedResult
    }
}

extension DogListViewModel: DogListViewModelProtocol {
    
    func requestDogList(page: Int) {
        repository.dogList(page: page)
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .failure(let error):
                    self.state = .error
                    self.showErrorMessage = true
                    print (error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.showErrorMessage = false
                let dogs = value.compactMap { $0 }
                let response = dogs.map { DogListModel(id: UUID().uuidString,
                                                       breedName: $0.breeds.compactMap { $0.name }.first ?? "",
                                                       imageUrl: $0.url ?? "",
                                                       group: $0.breeds.compactMap { $0.group }.first ?? "",
                                                       origin: $0.breeds.compactMap { $0.origin }.first ?? "Unknown",
                                                       category: $0.breeds.compactMap{ $0.category }.first ??  "Unknown",
                                                       temperament: $0.breeds.compactMap{ $0.temperament }.first ??  "Unknown")}
                self.response = response
                let formatedArray = self.response.removeDuplicates()
                self.availableDogs.append(contentsOf: formatedArray)
                self.state = .ready
            }
            .store(in: &cancellables)
    }
}

enum DogListState {
    case loading
    case error
    case ready
    case initialLoading

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    func removeDuplicates() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
