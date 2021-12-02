//
//  Created by Павел Чернышев on 13.03.2021
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(email: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func refreshToken(completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
