//
//  CoreDataSource.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.11.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import CoreData
import Utils

public final class CoreDataSource: NSObject {
    private let persistentContainer: NSPersistentContainer
    private let accessQueue: DispatchQueue
    
    public init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.loadPersistentStores { (_, error) in
            guard let error = error else { return }
            assertionFailure("Error at loadPersistentStores \(error)" )
        }
        
        let accessQueueLabel = String(format: "core_data_access_queue-%08x-%08x", arc4random(), arc4random())
        self.accessQueue = DispatchQueue(label: accessQueueLabel, attributes: [.concurrent])
        
        super.init()
    }
    
    convenience public init(modelURL: URL, databaseURL: URL) {
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create core data model)")
        }
        
        self.init(databaseURL: databaseURL, managedObjectModel: mom)
    }
    
    convenience public init(databaseURL: URL, managedObjectModel: NSManagedObjectModel) {
        let persistentContainer = NSPersistentContainer(name: databaseURL.lastPathComponent, managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [NSPersistentStoreDescription(url: databaseURL)]
        
        self.init(persistentContainer: persistentContainer)
    }
}

private extension CoreDataSource {
    func unsafeRead<T>(_ action: (NSManagedObjectContext) throws -> T) -> Result<T, Error> {
        let context = persistentContainer.newBackgroundContext()
        context.name = Constants.readonlyContextLabel
        
        var result: Result<T, Error> = .failure(NSError(domain: "_PLACEHOLDER_", code: 500))
        
        context.performAndWait {
            do {
                let output = try action(context)
                result = .success(output)
            } catch {
                result = .failure(error)
            }
        }
        
        return result
    }
    
    func unsafeUpdate<T>(_ action: (NSManagedObjectContext) throws -> T) -> Result<T, Error> {
        let context = persistentContainer.newBackgroundContext()
        context.name = Constants.writeContextLabel
        
        var result: Result<T, Error> = .failure(NSError(domain: "_PLACEHOLDER_", code: 500))
        
        context.performAndWait {
            do {
                let output = try action(context)
                
                if context.hasChanges {
                    try context.save()
                }
                
                result = .success(output)
            } catch {
                result = .failure(error)
            }
        }
        
        return result
    }
}

// MARK: - CoreDataSource+SyncMethods
public extension CoreDataSource {
    func read<T>(_ action: (NSManagedObjectContext) throws -> T) -> Result<T, Error> {
        accessQueue.sync { unsafeRead(action) }
    }
    
    @discardableResult
    func update<T>(_ action: (NSManagedObjectContext) throws -> T) -> Result<T, Error> {
        accessQueue.sync(flags: [.barrier]) { unsafeUpdate(action) }
    }
}

// MARK: - CoreDataSource+AsyncMethods
public extension CoreDataSource {
    func read<Result>(_ action: @escaping (NSManagedObjectContext) throws -> Result,
                      resultQueue: DispatchQueue = .main,
                      success: @escaping (Result) -> Void,
                      failure: @escaping Closure.GeneralError) {
        accessQueue.async {
            let result = self.unsafeRead(action)
            
            switch result {
            case let .success(output):
                resultQueue.async { success(output) }
            case let .failure(error):
                resultQueue.async { failure(.coreDataError) }
            }
        }
    }
    
    func update<Result>(_ action: @escaping (NSManagedObjectContext) throws -> Result,
                        resultQueue: DispatchQueue = .main,
                        success: @escaping (Result) -> Void,
                        failure: @escaping Closure.GeneralError) {
        accessQueue.async(flags: [.barrier]) {
            let result = self.unsafeUpdate(action)
            
            switch result {
            case let .success(output):
                resultQueue.async { success(output) }
            case let .failure(error):
                resultQueue.async { failure(.coreDataError) }
            }
        }
    }
}

// MARK: - CoreDataSource+Constants
private extension CoreDataSource {
    enum Constants {
        static let readonlyContextLabel = "core_data.context.readonly"
        static let writeContextLabel = "core_data.context.write"
    }
}

