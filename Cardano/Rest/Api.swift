//
//  Api.swift
//  Cardano
//
//  Created by Ivan Manov on 8/16/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

public extension Cardano.Rest {
    class Api: CatalystNet.Api {
        public var client: RestClient!

        public func load<T, E>(_ resource: Resource<T, E>,
                               multitasking: Bool = false,
                               completion: @escaping (Result<Any, E>) -> Void) {
            var resource = resource

            resource.headers += ["Content-Type": "application/json"]

            super.load(resource, self.client, multitasking: multitasking, completion: completion)
        }
    }
}
