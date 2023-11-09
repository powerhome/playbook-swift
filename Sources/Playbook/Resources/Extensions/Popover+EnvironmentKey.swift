//
//  Popover+EnvironmentKey
//  
//
//  Created by Isis Silva on 09/11/23.
//

import SwiftUI

private struct PopoverEnvironmentKey: EnvironmentKey {
  static let defaultValue: AnyView? = nil
}

extension EnvironmentValues {
  var popoverValue: AnyView? {
    get { self[PopoverEnvironmentKey.self] }
    set { self[PopoverEnvironmentKey.self] = newValue }
  }
}
