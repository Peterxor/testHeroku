import Vapor
import FluentSQLite

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // your code here
    let db = try app.make(DatabasesConfig.self)
    print("@@@@@@@@")
    print(db)
    print("@@@@@@@@")
}
