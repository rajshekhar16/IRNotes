//
//  IRCoreDataManager.swift
//  IRNotes
//
//  Created by Diro Dev on 01/12/2018.
//  Copyright © 2018 Diro Dev. All rights reserved.
//

import CoreData
import UIKit
final class IRCoreDataManager: NSObject {
    
    private let modelName: String
    
    init(modelName: String)
    {
        self.modelName = modelName
        super.init()
        setupNotificationHandling()
    }
    
    
    // Setting up Core Data Stack
    private(set) lazy var managedObjectContext:NSManagedObjectContext = {
        
        //Initialize managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentSroreCoordinator
        
        return managedObjectContext
        
    } ()
    
    private lazy var persistentSroreCoordinator:NSPersistentStoreCoordinator = {
        
        //Initialize managed Object Context
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileMgr = FileManager.default
        
        let storeName = "\(self.modelName).sqlite"
        
        let documentDirectoryURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // Sqlite Store URL
        let storeURL = documentDirectoryURL.appendingPathComponent(storeName)
        
        do
        {
            // Adding persistent store coordinator
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        }
        catch
        {
            fatalError("Unable to add persistent store")
        }
        
        return persistentStoreCoordinator
        
    } ()
    
    private lazy var managedObjectModel:NSManagedObjectModel = {
        
        //Data Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else
        {
            fatalError("Unable to find data model")
        }
        
        //Initialize managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else
        {
            fatalError("Unable to load data model")
        }
        
        return managedObjectModel
        
        
    }()
    
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges(_:)),
                                       name: UIApplication.willTerminateNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges(_:)),
                                       name: UIApplication.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    @objc func saveChanges(_ notification: Notification) {
        saveChanges()
    }
    
    private func saveChanges() {
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to Save Managed Object Context")
            print("\(error), \(error.localizedDescription)")
        }
    }
    
}
