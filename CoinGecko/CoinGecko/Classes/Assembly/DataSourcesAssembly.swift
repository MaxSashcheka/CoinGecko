//
//  DataSourcesAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Core
import Utils

final class DataSourcesAssembly: Assembly {
    static func makeCoreDataSource() -> CoreDataSource {
        // TODO: - Implement fetching dbFileURL for current user when it will be implemented on backend
        let userId = "some"
        let databaseName = userId + "_data_base"
        
        let coreBundle = Bundle(for: CoreDataSource.self)

        guard let modelURL = coreBundle.url(forResource: Constants.dataModel,
                                            withExtension: "momd") else {
            fatalError("Unable to find data model with name: \(Constants.dataModel)")
        }
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else {
            fatalError("Unable to find documentsDirectory")
        }
        let dataBaseFileURL = documentsDirectory.appendingPathComponent(Constants.directoryName).appendingPathComponent(databaseName)
        
        return CoreDataSource(modelURL: modelURL, databaseURL: dataBaseFileURL)
    }
}

private extension DataSourcesAssembly {
    enum Constants {
        static let dataModel = "DataBaseDataModel"
        static let `extension` = "momd"
        static let directoryName = "CoreData"
    }
}

extension CoreDataSource: Resolvable { }
