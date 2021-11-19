//
//  JSONDecoder+.swift
//  Que
//
//  Created by Adel Radwan on 8/31/19.
//  Copyright © 2019 Adel Radwan. All rights reserved.
//

import UIKit

extension JSONDecoder {
    
    func implement<T:Decodable>(type: T.Type, data: Data,_ completion:(_ s: T)->() = { _ in }){
        self.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let s = try self.decode(T.self, from: data)
            completion(s)
        }catch{
            log(type: .error, error)
        }
    }
    
    
}
