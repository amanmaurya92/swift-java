//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift.org project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of Swift.org project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import JExtractSwiftLib
import Testing

@Suite
struct FFMClosureTests {

  @Test
  func sendableClosure_javaBindings() throws {
    let source =
      """
      public func executeTask(task: @escaping @Sendable () -> Void) {}
      """

    try assertOutput(
      input: source,
      .ffm,
      .java,
      expectedChunks: [
        """
        private static class $task {
          @ThreadSafe // Sendable
          @FunctionalInterface
          public interface Function {
            void apply();
          }
        """
      ]
    )
  }
}
