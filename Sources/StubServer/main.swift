import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Read configuration
let configurationManager = ConfigurationManager(reader: DefaultConfigurationReader())

// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = configurationManager.configureRoutes()

// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

configureServer(server)

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
