/*
Copyright (c) 2014-2016 halo. https://github.com/halo/macosvpn

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

//import Foundation
import Moderator

open class Arguments {

  public static var options = Options()
  public static var serviceConfigs: [VPNServiceConfig] = []
  public static var serviceNames: [String] = []

  public static func load() {
    // The first argument is the executable name, we ignore that one
    let arguments = Array(CommandLine.arguments.dropFirst())

    // Now let's parse all generic flags such as --version and --debug
    options = Options.Parser.parse(arguments)
    let serviceConfigArguments = options.unprocessedArguments

    guard options.command == .create else {
      return
    }

    // The remaining arguments should be service-config related, such as --l2tp --endpoint etc.
    serviceConfigs = VPNServiceConfig.Splitter.parse(serviceConfigArguments)
  }
}