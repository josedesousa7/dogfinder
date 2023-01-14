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
    func requestDogList()
}

class DogListViewModel: ObservableObject {
    private var repository: DogListRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: DogListRepository = DogListRepository()) {
        self.repository = repository
        requestDogList()
    }
}

extension DogListViewModel: DogListViewModelProtocol {

    func requestDogList() {
        repository.dogList()
            .sink { [weak self] response in
                switch response {
                case .failure(let error):
                    print (error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                let dog = value.first
                print("dog breed: \(dog?.breeds.first?.category)")

                //self.state.value = .ready(model)
            }
            .store(in: &cancellables)
    }
}
