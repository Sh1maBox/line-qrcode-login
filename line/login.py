from talk.ttypes import *
from talk.SecondaryQrCodeLoginService import Client as LoginClient
from talk.LoginPermitNoticeService import Client as CertClient
from thrift.protocol import TCompactProtocol
from thrift.protocol import TBinaryProtocol
from thrift.transport import THttpClient
from httpx import Client


def main():
    host = "legy-jp-addr.line.naver.jp"
    qrcode_login_path = "/acct/lgn/sq/v1"
    login_permit_notice_path = "/acct/lp/lgn/sq/v1"
    headers = {
        "X-Line-Application": "CHROMEOS	2.3.7\tChrome_OS\t1",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36",
    }
    http_client = THttpClient.THttpClient(f"https://{host+qrcode_login_path}")
    http_client.setCustomHeaders(headers)
    protocol = TCompactProtocol.TCompactProtocol(http_client)
    client = LoginClient(iprot=protocol)

    session_id = client.createSession(
        LoginQrCode_CreateQrSessionRequest()
    ).authSessionId
    print(session_id)
    url = client.createQrCode(LoginQrCode_CreateQrCodeRequest(session_id)).callbackUrl
    print(url)

    # b
    http_client = THttpClient.THttpClient(f"https://{host+login_permit_notice_path}")
    headers["X-Line-Access"] = session_id
    http_client.setCustomHeaders(headers)
    protocol = TCompactProtocol.TCompactProtocol(http_client)
    cert_client = CertClient(iprot=protocol)

    cert_client.checkQrCodeVerified(LoginQrCode_CheckQrCodeVerifiedRequest(session_id))
    # cert_client.checkPinCodeVerified(
    #     LoginQrCode_CheckPinCodeVerifiedRequest(session_id)
    # )
    # cert_client = Client(base_url=f"https://{host}")
    # a = cert_client.get("/Q", headers=headers)
    # print(a)

    l = client.qrCodeLogin(LoginQrCode_QrCodeLoginRequest(session_id, "pyne", False))
    print(l)
