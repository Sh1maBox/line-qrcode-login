// Copyright (c) 2020 4masaka
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

enum LoginQrCode_ErrorCode {
    INTERNAL_ERROR = 0,
    ILLEGAL_ARGUMENT = 1,
    VERIFICATION_FAILED = 2,
    NOT_ALLOWED_QR_CODE_LOGIN = 3,
    VERIFICATION_NOTICE_FAILED = 4,
    RETRY_LATER = 5,
    INVALID_CONTEXT = 100,
    APP_UPGRADE_REQUIRED = 101
}


struct LoginQrCode_CreateQrSessionRequest {}
struct LoginQrCode_CreateQrSessionResponse {
    1: string authSessionId
}
struct LoginQrCode_CreateQrCodeRequest {
    1: string authSessionId
}
struct LoginQrCode_CreateQrCodeResponse {
    1: string callbackUrl
}
struct LoginQrCode_VerifyCertificateRequest {
    1: string authSessionId,
    2: string certificate
}
struct LoginQrCode_VerifyCertificateResponse {}
struct LoginQrCode_CreatePinCodeRequest {
    1: string authSessionId
}
struct LoginQrCode_CreatePinCodeResponse {
    1: string pinCode
}
struct LoginQrCode_QrCodeLoginRequest {
    1: string authSessionId,
    2: string systemName,
    3: bool autoLoginIsRequired
}
struct LoginQrCode_QrCodeLoginResponse {
    1: string certificate,
    2: string accessToken,
    3: string lastBindTimestamp,
    4: string metaData
}

struct LoginQrCode_CheckQrCodeVerifiedRequest {
    1: string authSessionId
}
struct LoginQrCode_CheckQrCodeVerifiedResponse {}
struct LoginQrCode_CheckPinCodeVerifiedRequest {
    1: string authSessionId
}
struct LoginQrCode_CheckPinCodeVerifiedResponse {}

exception SecondaryQrCodeException {
    1: i32 code,
    2: string alertMessage
}


service SecondaryQrCodeLoginService {
    LoginQrCode_CreateQrSessionResponse createSession(1:LoginQrCode_CreateQrSessionRequest request) throws (1:SecondaryQrCodeException e),
    LoginQrCode_CreateQrCodeResponse createQrCode(1:LoginQrCode_CreateQrCodeRequest request) throws (1:SecondaryQrCodeException e),
    LoginQrCode_VerifyCertificateResponse verifyCertificate(1:LoginQrCode_VerifyCertificateRequest request) throws (1:SecondaryQrCodeException e),
    LoginQrCode_CreatePinCodeResponse createPinCode(1:LoginQrCode_CreatePinCodeRequest request) throws (1:SecondaryQrCodeException e),
    LoginQrCode_QrCodeLoginResponse qrCodeLogin(1:LoginQrCode_QrCodeLoginRequest request) throws (1:SecondaryQrCodeException e)
}

service LoginPermitNoticeService {
    LoginQrCode_CheckQrCodeVerifiedResponse checkQrCodeVerified(1:LoginQrCode_CheckQrCodeVerifiedRequest request) throws (1:SecondaryQrCodeException e),
    LoginQrCode_CheckPinCodeVerifiedResponse checkPinCodeVerified(1:LoginQrCode_CheckPinCodeVerifiedRequest request) throws (1:SecondaryQrCodeException e),
}