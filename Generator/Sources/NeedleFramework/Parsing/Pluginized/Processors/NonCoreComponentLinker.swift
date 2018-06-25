//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

/// A processor that links non-core components to pluginizable components
/// based on type name.
class NonCoreComponentLinker: Processor {

    /// Initializer.
    ///
    /// - parameter pluginizableComponents: The pluginizable components to
    /// link with non-core components.
    /// - parameter nonCoreComponents: The non-core components to link.
    init(pluginizableComponents: [PluginizableASTComponent], nonCoreComponents: [ASTComponent]) {
        self.pluginizableComponents = pluginizableComponents
        self.nonCoreComponents = nonCoreComponents
    }

    /// Process the data models.
    ///
    /// - throws: `ProcessingError` if some pluginized components cannot
    /// find matching non-core components.
    func process() throws {
        var nonCoreMap = [String: ASTComponent]()
        for nonCoreComponent in nonCoreComponents {
            nonCoreMap[nonCoreComponent.name] = nonCoreComponent
        }

        for pluginizableComponent in pluginizableComponents {
            pluginizableComponent.nonCoreComponent = nonCoreMap[pluginizableComponent.nonCoreComponentType]
        }
    }

    // MARK: - Private

    private let pluginizableComponents: [PluginizableASTComponent]
    private let nonCoreComponents: [ASTComponent]
}