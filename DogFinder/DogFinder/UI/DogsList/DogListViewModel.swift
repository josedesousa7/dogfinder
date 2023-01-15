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
    var state: State { get set }
    func requestDogList()
}

class DogListViewModel: ObservableObject {
    private var repository: DogListRepository
    private var cancellables = Set<AnyCancellable>()
    @Published var state: State = .loading
    @Published var availableDogs: [DogListModel] = []

    init(repository: DogListRepository = DogListRepository()) {
        self.repository = repository
        requestDogList()
    }
}

extension DogListViewModel: DogListViewModelProtocol {

    func requestDogList() {
        repository.dogList()
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
                let response = dogs.map { DogListModel(name: $0.breeds.compactMap { $0.name }.first ?? "",
                                                       imageUrl: $0.url ?? "") }

                self.availableDogs.append(contentsOf: self.setupListOfDogs(dogList: response))
                self.state = .ready

                //self.state.value = .ready(model)
            }
            .store(in: &cancellables)
    }
    private func setupListOfDogs(dogList:[DogListModel]) -> [DogListModel] {
        return dogList.removingDuplicates { $0.name }

    }
}

enum State {
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


extension Array where Element: Hashable {
    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
         var result = [Element]()
         var seen = Set<T>()
         for value in self {
             if seen.insert(key(value)).inserted {
                 result.append(value)
             }
         }
         return result
     }
}
