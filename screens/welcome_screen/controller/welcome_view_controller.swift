//
//  welcome_view.swift
//  fsocial
//
//  Created by halil yılmaz on 27.04.2022.
//

import Foundation

struct WelcomeController {
    
    func getDataFromService(){
       ///
    }
}
struct UserListController{
    let userList : [User]
}
extension UserListController{
    func numberOfRowsInSection()-> Int {
        return self.userList.count
    }
    func userAtIndex(_ index: Int) -> UserController{
            let user = self.userList[index]
            return UserController(user: user)
            
    }
}


struct UserController{
    let user : User
}
extension UserController{
    var name : String {
        return self.user.name
    }
    var username : String {
        return self.user.username
    }
    var phone : String {
        return self.user.phone
    }
}



