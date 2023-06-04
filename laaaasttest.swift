import Foundation

func sendToAWSLambda(base64String: String) {
    let urlString = "https://7hb5wxrmzqw7x4tuyeck2kgl5a0brzco.lambda-url.us-east-1.on.aws/"
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }

    let jsonData: [String: Any] = [
        "key": "0987654321",
        "audio": base64String
    ]

    do {
        let requestData = try JSONSerialization.data(withJSONObject: jsonData)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            // Handle the response from AWS Lambda
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                // Process the response as needed
            }
        }

        task.resume()
    } catch {
        print("Error serializing JSON: \(error.localizedDescription)")
    }
}

// Usage example
let base64String = "AAAAGGZ0eXBt"
sendToAWSLambda(base64String: base64String)
