
# Network

<p align="center">Package including hooks for easy works with http package in</p>

## Key Features

* Simple hooks for all http methods
* Interceptors witch handling requests, responses and errors
* Decode json from response (`Response.json()` / `Response.asMap` / `Response.asList`) 
* Browser support

## Getting Started

```dart
import 'package:network/network.dart';


// Client
final client = NetworkClient();
client.get(...);
client.post(...);
client.close();
``` 

Get request Blob:
```dart
final blobResponse = await 'https://via.placeholder.com/300'.get();
print(blobResponse.bytes);
```

Post request to API:
```dart
final postResponse = await 'https://jsonplaceholder.typicode.com/todos'.post(
  body: {'title': 'test'},
);
print(postResponse.asMap['id']);
```

Handle exceptions:
```dart
try {
  await 'https://jsonplaceholder.typicode.com/todos/202'.get();
} on NetworkException catch (error) {
  print('Network exception called, status code: ${error.code}');
}
```

Add middleware:
```dart
import 'package:network/interceptors.dart';

 final interceptor = Interceptor(
    onRequest: (request) {
      print('request on: ${request.url}');
      return request.copyWith(
        url: request.url + '/additional-link',
      );
    },
    onResponse: (response) {
      print('response status code: ${response.statusCode}');
      return response;
    },
    onError: (error) {
      if (error is UnauthorizedException) {
        signOut();
      }

      return error;
    },
  )
final client = Network()..interceptors.add(interceptor)

