//
//  DogListViewModel.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

public typealias DogListViewModelOutput<T: Codable> = (_ output: T?, _ error: Error?) -> Void

protocol DogListViewModelProtocol {
    var state: DogListState { get set }
    func requestDogList(page: Int)
}

class DogListViewModel: ObservableObject {
    private var repository: DogListRepository
    private var cancellables = Set<AnyCancellable>()
    @Published var state: DogListState = .loading
    @Published var availableDogs: [DogListModel] = []
    private var response: [DogListModel] = []
    var totalPages = 10
    var page = 0

    init(repository: DogListRepository = DogListRepository()) {
        self.repository = repository
        requestDogList(page: page)
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
                    print (error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                let dogs = value.compactMap { $0 }
                let response = dogs.map { DogListModel(id: UUID().uuidString,
                                                       name: $0.breeds.compactMap { $0.name }.first ?? "",
                                                       imageUrl: $0.url ?? "")}
                self.response.append(contentsOf: response)
                let formateddArray = self.response.removeDuplicates()
                self.availableDogs = formateddArray
                self.state = .ready
            }
            .store(in: &cancellables)
    }

    func loadMore(item: DogListModel) {
        let lastItemId = availableDogs.last?.id
        if let lastItemId {
            if item.id == lastItemId, (page + 1) <= totalPages {
                page += 1
                state = .loading
                requestDogList(page: page)
                print("page:\(page)")
            }
        }
    }
}

enum DogListState {
    case loading
    case error
    case ready

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
