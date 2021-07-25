import Foundation

// MARK: - AccountVerificationRemote
//
class AccountVerificationRemote: Remote {
    /// Send verification request for specified email address
    ///
    func verify(email: String, completion: @escaping (_ result: Result) -> Void) {
        guard let request = verificationURLRequest(with: email) else {
            completion(.failure(0, nil))
            return
        }

        performDataTask(with: request, completion: completion)
    }

    private func verificationURLRequest(with email: String) -> URLRequest? {
        guard let base64EncodedEmail = email.data(using: .utf8)?.base64EncodedString(),
              let verificationURL = URL(string: SimplenoteConstants.simplenoteVerificationURL) else {
            return nil
        }

        var request = URLRequest(url: verificationURL.appendingPathComponent(base64EncodedEmail),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: RemoteConstants.timeout)
        request.httpMethod = RemoteConstants.Method.GET

        return request
    }
}
