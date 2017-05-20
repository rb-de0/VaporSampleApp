import HTTP

extension Response {
    
    convenience init(foundRedirect location: String) {
        self.init(status: .found, headers: ["Location": location])
    }
}
