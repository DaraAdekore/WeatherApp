//
//  DataManager.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-21.
//

import Foundation
import UIKit

class DataManager {
    
    let userDefaults = UserDefaults.standard
    private init(){}
    func saveDataLoginState(){
        if userDefaults.bool(forKey: "loggedIn"){
            let state = userDefaults.bool(forKey: "loggedIn")
            userDefaults.set(!state, forKey: "loggedIn")
        }
        
        
    }
    func logIn(username:String, password:String){
        if let database = userDefaults.object(forKey: "database") as? [String:String]{
            if let usersPassword = database[username]{
                if password == usersPassword{
                    saveDataLoginState()
                }
            }
            else {
                var ac = UIAlertController(title: "Registering you now", message: "", preferredStyle: .alert)
                ac.addTextField()
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "Submit", style: .cancel))
                if let username = ac.textFields?[0].text,
                   let password = ac.textFields?[1].text {
                    register(username: username, password: password)
                }
                
                
            }
        }
        else {
            register(username: username, password: password)
        }
       
    }
    
    func register(username:String,password:String){
        if var database = userDefaults.object(forKey: "database") as? [String:String]{
            database[username] = password
            userDefaults.set(database, forKey: "database")
        }
        else{
            userDefaults.set([username:password], forKey: "database")
        }
    }
}
