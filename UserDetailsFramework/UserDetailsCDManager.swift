//
//  UserDetailsCDManager.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 12/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation
import CoreData

public class UserDetailsCDManager {
    
    public static let shared = UserDetailsCDManager()
    let bundleIdentifier = "com.assign.UserDetailsFramework"
    let cdModel: String = "UserDetailsCDModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(identifier: self.bundleIdentifier)
        let cdModelUrl = bundle!.url(forResource: self.cdModel, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: cdModelUrl)
        
        let container = NSPersistentContainer(name: self.cdModel, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let responseError = error {
                fatalError("can not load store \(responseError)")
            }
        }
        return container
    }()
    
    public func storeUserDetail(storeUserInfo: UserInfo) {
        let moContext = persistentContainer.viewContext
        let userDetail = NSEntityDescription.insertNewObject(forEntityName: "UserDetails", into: moContext) as! UserDetails
        
        userDetail.seed = storeUserInfo.userId
        userDetail.name = storeUserInfo.fullName
        userDetail.gender = storeUserInfo.gender
        userDetail.age = storeUserInfo.age
        userDetail.dob = storeUserInfo.dob
        userDetail.email = storeUserInfo.email
        if moContext.hasChanges {
            do {
                try moContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func fetchUserDetail() -> [UserInfo] {
        let moContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserDetails>(entityName: "UserDetails")
        
        var fetchStoredInfoAll: [UserInfo] = [UserInfo]()
        do {
            let userDetails = try moContext.fetch(fetchRequest)
            for (_, user) in userDetails.enumerated() {
                let fetchStoredInfo: UserInfo = UserInfo()
                fetchStoredInfo.userId = user.seed ?? ""
                fetchStoredInfo.fullName = user.name ?? ""
                fetchStoredInfo.gender = user.gender ?? ""
                fetchStoredInfo.age = user.age ?? ""
                fetchStoredInfo.dob = user.dob ?? ""
                fetchStoredInfo.email = user.email ?? ""
                fetchStoredInfoAll.append(fetchStoredInfo)                
            }
        } catch let fetchError {
            print("can not fetch \(fetchError)")
        }
        return fetchStoredInfoAll
    }
    
    public func deleteUserDetail(userInfo: UserInfo) {
        
        let moContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserDetails>(entityName: "UserDetails")
        let predicate = NSPredicate(format: "seed == %@", "\(userInfo.userId)")
        fetchRequest.predicate = predicate
        do {
            let userDetails = try moContext.fetch(fetchRequest)
            for (_, user) in userDetails.enumerated() {
                moContext.delete(user)
                print("user id : \(userInfo.userId) is deleted")
            }
        } catch let fetchError {
            print("can not fetch \(fetchError)")
        }
        if moContext.hasChanges {
            do {
                try moContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

