//
//  MWDependencyService.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 20/02/25.
//

class MWDependencyService {
    static var shared = MWDependencyService()
    
    private var dependencies: [Any] = []
    
    init() {

    }
    
    func getDependency<T: AnyObject>(_ type: T.Type) -> T {
        for dependency in dependencies {
            if let matchedDependency = dependency as? T {
                return matchedDependency
            }
        }
        fatalError("The dependency doesn't exist")
    }
}
