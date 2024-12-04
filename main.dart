import 'dart:async';

Stream<int> getNumbers() async* {
  for (int i = 0; i < 5; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));

    if (i == 2) {
      throw Exception('2 oldu hata çıktı');
    }
  }
}

void main(List<String> args) {
  //subscriptonIslemleri();
  broadCasStream();
}

void subscriptonIslemleri() {
  var subscription = getNumbers().listen(
    (event) {
      print(event);
    },
  );
  subscription.onData(
    (data) {
      print("OnData verisi :" + data.toString());
    },
  );

  subscription.onError((err) {
    print("2 oldu hata oldu ");
  });

  subscription.onDone(
    () {
      print("Stream sonlandı yield edşlen değer kalmadı");
    },
  );
}

Future<void> broadCasStream() async {
  final myStream = getNumbers().asBroadcastStream();

  myStream.listen(
    (event) {
      print("1. listen $event");
    },
  );
  myStream.listen(
    (event) {
      print("2. listen $event");
    },
  );

  print("First kullanımı  " + (await myStream.first).toString());

  print("Last kullanımı  " + (await myStream.last).toString());

  print("Lenght kullanımı  " + (await myStream.length).toString());

  print("Single kullanımı  " + (await myStream.single).toString());

  print("Contain kullanımı  " + (await myStream.contains(2)).toString());

  print("EmenetAt kullanımı  " + (await myStream.elementAt(2)).toString());

  print("Any kullanımı  " +
      (await myStream.any(
        (element) => element == 2,
      ))
          .toString());

  print("Join kullanımı  " + (await myStream.join(' , ')).toString());
}