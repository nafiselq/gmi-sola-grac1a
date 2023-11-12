import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/interceptor.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/key_value.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../routes/app_pages.dart';

bool isConnectionSecure = true;

class ApiServices {
  TokenInterceptors tokenInterceptors = TokenInterceptors();
  final box = GetStorage();
  final baseUrlMainApi = 'http://103.134.154.190:4000/api'; //dev

  Dio launch() {
    Dio dio = Dio();
    dio.interceptors.add(tokenInterceptors);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 1000));

    dio.options.followRedirects = true;
    dio.options.validateStatus = (s) {
      return (s != 401) && (s! < 500);
    };

    // dio.options.headers["accept"] = 'application/json';
    // dio.options.headers["social-media-login-secret"] = 'rahasiaajainimah';
    // if (box.read(KeyValue.keyToken) != null) {
    //   dio.options.headers["Authorization"] =
    //       'Bearer ${box.read(KeyValue.keyToken)}';
    // }

    // // Membuat interceptor untuk menangani status HTTP 401
    // dio.interceptors.add(InterceptorsWrapper(
    //   onError: (DioException error, handler) async {
    //     if (error.response?.statusCode == 401) {
    //       // Di sini Anda dapat melakukan tindakan yang sesuai, seperti mengambil token baru
    //       // atau mengarahkan pengguna ke halaman login.
    //       // Misalnya, Anda dapat memanggil metode refreshToken() untuk mendapatkan token baru.
    //       return Get.offAllNamed(Routes.MAIN_ONBOARDING);
    //     }
    //     return; // Kembalikan error aslinya jika bukan 401
    //   },
    // ));

    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   onHttpClientCreate: (client) {
    //     final certBytes = base64Decode(
    //         // "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZVRENDQkRpZ0F3SUJBZ0lTQTJuNDJQL1l3akRmRUYza09EV3U3YTUyTUEwR0NTcUdTSWIzRFFFQkN3VUEKTURJeEN6QUpCZ05WQkFZVEFsVlRNUll3RkFZRFZRUUtFdzFNWlhRbmN5QkZibU55ZVhCME1Rc3dDUVlEVlFRRApFd0pTTXpBZUZ3MHlNekEwTVRFd01qTTFNVGhhRncweU16QTNNVEF3TWpNMU1UZGFNREF4TGpBc0JnTlZCQU1UCkpYQnliM0JsY25SNUxXRmtkbWx6YjNKNUxYTjVjM1JsYlM1bVlXNXBiblJsYXk1amIyMHdnZ0VpTUEwR0NTcUcKU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRQ2tEblh4RDBqM2FUaFNVTzRweElzemhxWU42eFJibmxuYQppdktlL3hiQk5ScUw5OXdkU3h2VjAreVYxUmc4MHVMdEo5dmV0eDFhd1haS3N4ZGhIcU5sRVg4TkV3bmQxV29PCkdxSFZkNWFjMXhXam5RUDU3ZHMxRlFsR1ZrN3MySGk1U1BkajZIUkJkWTZxZ3FIc2Q5WTNRTGUvVUlCMXAzUXcKN2FUeHJhZlFCYUljK01jbEpVUHFrSmc4TUpOOGRjVjlDNUpSdEtkSWFKZzFFa2xhN0RSTW85MmtuenFPZlorVApqM1g2VjUxRzN5am4wUFZZTUlEN1QxbHgrK3p1U2NYTGgrbXdsOU9KOHhFcTR6dGZtcUkxbmpQQjNUQ05VTEZoCjFPc1RjOG9LK2o2d2I1L3FvUi9XOG5GSnI3WDBrYXlnak05NnViYnVhYmtWQUNJdmFqZWRBZ01CQUFHamdnSmcKTUlJQ1hEQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0hRWURWUjBsQkJZd0ZBWUlLd1lCQlFVSEF3RUdDQ3NHQVFVRgpCd01DTUF3R0ExVWRFd0VCL3dRQ01BQXdIUVlEVlIwT0JCWUVGTVhMY0xYY3NXejBxVVIzVklVclY3dW1SRTRvCk1COEdBMVVkSXdRWU1CYUFGQlF1c3hlM1dGYkxybEFKUU9ZZnI1MkxGTUxHTUZVR0NDc0dBUVVGQndFQkJFa3cKUnpBaEJnZ3JCZ0VGQlFjd0FZWVZhSFIwY0RvdkwzSXpMbTh1YkdWdVkzSXViM0puTUNJR0NDc0dBUVVGQnpBQwpoaFpvZEhSd09pOHZjak11YVM1c1pXNWpjaTV2Y21jdk1EQUdBMVVkRVFRcE1DZUNKWEJ5YjNCbGNuUjVMV0ZrCmRtbHpiM0o1TFhONWMzUmxiUzVtWVc1cGJuUmxheTVqYjIwd1RBWURWUjBnQkVVd1F6QUlCZ1puZ1F3QkFnRXcKTndZTEt3WUJCQUdDM3hNQkFRRXdLREFtQmdnckJnRUZCUWNDQVJZYWFIUjBjRG92TDJOd2N5NXNaWFJ6Wlc1agpjbmx3ZEM1dmNtY3dnZ0VFQmdvckJnRUVBZFo1QWdRQ0JJSDFCSUh5QVBBQWRnQjZNb3hVMkxjdHRpRHFPT0JTCkh1bUVGbkF5RTRWTk85SXJ3VHBYbzFMclVnQUFBWWR1WWRWVUFBQUVBd0JITUVVQ0lRQ0kvbWtFNDNieHg0ZUkKbEdiSWdtYkdDRkhQdWl3Y1JVREVXU0RUQklaL01BSWdkVVBhQlYvN3RmcmdYUVBwQkFuZkNxQW9tLzFNY1krUgpHN2V3VkFFZldLd0FkZ0N0OTc3NmZQOFF5SXVkUFp3ZVBoaHF0R2NwWGMreERDVEtoWVkwNjl5Q2lnQUFBWWR1CllkVm9BQUFFQXdCSE1FVUNJUURSWjc5NnF0RVl4cU4vcVIzZU5KZjdVL3NMSEtROWVPd01GdlhYWFVCaWxBSWcKYnZuOERnQUxlK2dZcmhsUFpLTjV3aDRzSHA1aFNHUDM4QncvTTA2K0VzTXdEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUY5bTlNR0xkd2hXV3h2djA4dGcwRGNqMHFIdlZVMDhQTXh0MjZpOFZ3eHZidDFpU1Z2di9qbjNDTDEwCk9yc0pBS0FpbFNsUkpXL3NOMDEyNEZtL2tnb2xmSnZqN1Rvb2VSK0wzelEydEVySlN3cjA1QlkwOHhCM0JXTm4KSjViWG8xanJHY2lHcWhTSGx4bEZEbGlyTGFoWXZ0T3Rad2t2UTRENnZJdDZLenpjUXA0ZGVDNEZ0K0FJZWFyQwpJbXd1QW01a1NNMnMxUXFxZkJlM2JiUkxjSnpWUzFOUTNIdHVIVjBZSzhtQStObUJEL3hjVGpzMEx0Mmg5aHg5CnB1QzVPQ2VCWVdMZVZDSndYSnhzOFN5WC9IMHhrTHJCVVF6SUFBc3YrU3J2VUdPUHZJcy9BMHh0ZWFOMFpTaWcKMDErL3AxUmZ0RlVKdkFoOUFySjNnd1NvZ09nPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0t"); // dev fan
    //         "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUcyRENDQmNDZ0F3SUJBZ0lRRHR4Ukh6bjNsRjdhSGFBVFBQdVp4REFOQmdrcWhraUc5dzBCQVFzRkFEQloKTVFzd0NRWURWUVFHRXdKVlV6RVZNQk1HQTFVRUNoTU1SR2xuYVVObGNuUWdTVzVqTVRNd01RWURWUVFERXlwRQphV2RwUTJWeWRDQkhiRzlpWVd3Z1J6SWdWRXhUSUZKVFFTQlRTRUV5TlRZZ01qQXlNQ0JEUVRFd0hoY05Nak13Ck5URXlNREF3TURBd1doY05NalF3TmpFeE1qTTFPVFU1V2pCbE1Rc3dDUVlEVlFRR0V3SkpSREVRTUE0R0ExVUUKQnhNSFNtRnJZWEowWVRFdU1Dd0dBMVVFQ2hNbFVGUWdRbUZ1YXlCVVlXSjFibWRoYmlCT1pXZGhjbUVnS0ZCbApjbk5sY204cElGUmlhekVVTUJJR0ExVUVBd3dMS2k1aWRHNHVZMjh1YVdRd2dnRWlNQTBHQ1NxR1NJYjNEUUVCCkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDNS9RNmtBZFN0dTZscnNKMlhtNDBGamtsaGR3WER6NGtxdWptYk9LbXgKZktIZnZUN0JOOTNKVjlmeHpxQ2dzbk1rNmNCUHd5UlpEWVRScVNIY2R4RVMxcFhTZTEwWURoOHIwa1BlTHkzNAphKzJQa3IwUDdJVGNLMUZCVkxGQ1VydzZsbW95elBzZW5lM1ptK2JoYUhta2hNN2dzZnoydkJZK3pzcnlLRWFIClhjV21oWlRhbnkrdTY2dzVwS25HT1k3Rk80UGg4RnI0YWd4VXoydzRXUllTZHhjdVE0SFRlV1Q4ZlVWMkF6dGEKalVucFdkQjU2T3RFQlpEVDNYeXIybktPK1liWjlId3pSZlo3S2JBOVpKK29ONHd1MmlERjdkM09BNi9HZ0tMSwo1ZlB4TUhwNm9RY3JWQnNpbW8xRndIY3BqcTJuYmovVFhoa2xJaExWUHJHZkFnTUJBQUdqZ2dPT01JSURpakFmCkJnTlZIU01FR0RBV2dCUjBoWURBWnNmZk45N1B2U2szcWdNZHZ1M05GekFkQmdOVkhRNEVGZ1FVbmNFVnNZSEEKV01NU285cDBwRHFkdHBzYjE0WXdJUVlEVlIwUkJCb3dHSUlMS2k1aWRHNHVZMjh1YVdTQ0NXSjBiaTVqYnk1cApaREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdIUVlEVlIwbEJCWXdGQVlJS3dZQkJRVUhBd0VHQ0NzR0FRVUZCd01DCk1JR2ZCZ05WSFI4RWdaY3dnWlF3U0tCR29FU0dRbWgwZEhBNkx5OWpjbXd6TG1ScFoybGpaWEowTG1OdmJTOUUKYVdkcFEyVnlkRWRzYjJKaGJFY3lWRXhUVWxOQlUwaEJNalUyTWpBeU1FTkJNUzB4TG1OeWJEQklvRWFnUklaQwphSFIwY0RvdkwyTnliRFF1WkdsbmFXTmxjblF1WTI5dEwwUnBaMmxEWlhKMFIyeHZZbUZzUnpKVVRGTlNVMEZUClNFRXlOVFl5TURJd1EwRXhMVEV1WTNKc01ENEdBMVVkSUFRM01EVXdNd1lHWjRFTUFRSUNNQ2t3SndZSUt3WUIKQlFVSEFnRVdHMmgwZEhBNkx5OTNkM2N1WkdsbmFXTmxjblF1WTI5dEwwTlFVekNCaHdZSUt3WUJCUVVIQVFFRQplekI1TUNRR0NDc0dBUVVGQnpBQmhoaG9kSFJ3T2k4dmIyTnpjQzVrYVdkcFkyVnlkQzVqYjIwd1VRWUlLd1lCCkJRVUhNQUtHUldoMGRIQTZMeTlqWVdObGNuUnpMbVJwWjJsalpYSjBMbU52YlM5RWFXZHBRMlZ5ZEVkc2IySmgKYkVjeVZFeFRVbE5CVTBoQk1qVTJNakF5TUVOQk1TMHhMbU55ZERBSkJnTlZIUk1FQWpBQU1JSUJmUVlLS3dZQgpCQUhXZVFJRUFnU0NBVzBFZ2dGcEFXY0FkZ0R1emRCazFkc2F6c1ZjdDUyMHpST2lNb2RHZkx6czNzTlJTRmxHCmNSKzFtd0FBQVlnTmtBN2VBQUFFQXdCSE1FVUNJUURUaGczNnZoWXBZS3Q1UzZIemdGbjRYZkIycVFaRlg1V3oKSFUxbllCbStSUUlnZDFYRUMrSnVGWDlFdVA0NU9CUGJVQy9sbnR2ZFdBU2I4eHFKUUlscmFrMEFkZ0JJc09OcgoycVpITkEvbGFnTDZuVERySEZJQnkxYmRMSUhadTcrck9kaUVjd0FBQVlnTmtBNzdBQUFFQXdCSE1FVUNJUUNaCkdCcE54RHRHM2w3OWVZRTZteWhzVHdVMVhWYkhFSUlNbUgzYzZSNkw1Z0lnV3R3eDFvMmZlcVBhNjdaT0dZN2QKZTlROVYzcDFVSW1BdWlRbUJORmk3dDhBZFFEYXRyOXJQN1cySXArYndydGNhK2h3a1hGc3UxR0VoVFM5cEQwdwpTTmY3cXdBQUFZZ05rQTZVQUFBRUF3QkdNRVFDSUE4WEhrSzFsSnFzZDg5S293WWM1T2g1U1ZsUllLcmRSZVJtCnBWaWtvZWNUQWlBNHNvTmtvamhKUUoxNkxPK3cwbUJTZjhpWWRPTW1yY1ZZQklSd0hOUjlrREFOQmdrcWhraUcKOXcwQkFRc0ZBQU9DQVFFQUdjS01ya1JhL1dZLzk2MjVlRlhjRlRtbllHd0lPZDU1aHcwdDkrbExHdUdvUGJjNQprZzJRazY2dUJ6aGVNalVVdStkUmRUZ1drMStid2VTNlM1dUVYZkdQNFRjbVdmNDB6dkFPT2RGYitLak94UFhhCnFhZUM0SkRKaldVTjdoYkU5WlVDci9Yc2I1eWVVdmppQlUwMzJUemxIUVlqVCtGdnBCdGhreUhBc284ZFJLdHMKdFFkaU84MTB3d2hlai95T1hCUEsyMEQ2WmdVVTVpSmZwbW9QNkFzdUo0cTUzWURyb2JHdzk0WmNmU0RSMHRESQpqa3A3cDgzSzd5UzlOU0s3YUFKOEhXQzl2NnFqM3hBV3JxNDhlM3FJVStEUHVFN0UyK1hxRTdsWTFiQUJ5OEtoCnUxYTR0bS9WM3NuOXJ4a3pyT1NRSjVJbmRFeU4wREh0Ujd2aWh3PT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="); // dev btn
    //     final SecurityContext context = SecurityContext();
    //     // return HttpClient(context: context);
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => false;
    //     context.setTrustedCertificatesBytes(certBytes);
    //     return HttpClient(context: context);
    //   },
    //   validateCertificate: (cert, host, port) {
    //     // return true;

    //     if (cert == null) return false;
    //     final f = sha256.convert(cert.der).toString();
    //     return fingerprint == f;
    //   },
    // );

    return dio;
  }
}
