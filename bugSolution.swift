func fetchData() async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process data
    } catch {
        // Handle errors robustly.  Consider different error handling for different error types 
        if let urlError = error as? URLError {
            switch urlError.code {
            case .badServerResponse:  print("Bad Server Response")
            case .notConnectedToInternet: print("No internet connection")
            default: print("Other URL error: \(urlError)")
            }
        } else if let error = error as? DecodingError {
            // Handle Decoding Errors
            print("Decoding Error: \(error)")
        } else {
            print("An unexpected error occurred: \(error)")
        }
    }
}