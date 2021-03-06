//
//  DataViewModel.swift
//  TaskPryaniki
//
//  Created by Nikita Entin on 28.07.2021.
//

import Foundation

// Вью модель для обработки данных из сети
final class DataViewModel {
    
    private let apiManager = ApiManager()
    private var model: DataModel?
    
    var textBlock: String? {
        model?.data[0].data.text
    }
    
    var pictureURL: URL? {
        URL(string: model?.data[1].data.url ?? "")
    }
    var namesByOrder: [String] {
        model?.view ?? []
    }
    var itemsName: [String] {
        model?.data.map { $0.name } ?? []
    }
    
    var pictureText: String {
        model?.data[1].data.text ?? ""
    }
    
    var selector: [String] {
        model?.data[2].data.variants?.map { $0.text } ?? []
    }
    
    var count: Int {
        model?.view.count ?? 0
    }
    
    func getData(completion: @escaping () -> Void, errorBlock: @escaping () -> Void) {
        apiManager.fetch { (model: DataModel) in
            self.model = model
            completion()
        } errorHandler: { _ in
            errorBlock()
        }

    }
    
}
