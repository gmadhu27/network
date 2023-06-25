import 'package:network/src/interceptor.dart';
import 'package:network/src/methods.dart';
import 'package:network/src/request.dart';
import 'package:network/src/response.dart';

Future<Request> eachInterceptorRequests(
  Set<Interceptor> middleware,
  Request request,
) async {
  final interceptor =
      middleware.fold(null, (previousValue, interceptor) => interceptor);
  if (interceptor?.onRequest != null) {
    final finalRequest = await interceptor!.onRequest!(request);
    return finalRequest;
  } else {
    return request;
  }
}

Future<Response> eachInterceptorResponses(
  Set<Interceptor> middleware,
  Response response,
) async {
  final interceptor =
      middleware.fold(null, (previousValue, interceptor) => interceptor);
  if (interceptor?.onResponse != null) {
    final finalRequest = await interceptor!.onResponse!(response);
    return finalRequest;
  } else {
    return response;
  }
}

Object eachInterceptorErrors(
  Set<Interceptor> middleware,
  Object error, {
  required HttpMethod on,
}) {
  return middleware.fold<Object>(
    error,
    (err, middleware) {
      if ((middleware.on?.contains(on) ?? true) && middleware.onError != null) {
        return middleware.onError!(err);
      } else {
        return err;
      }
    },
  );
}
