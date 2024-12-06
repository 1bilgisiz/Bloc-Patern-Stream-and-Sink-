import 'dart:async';

Stream<int> getNumbers() async* {
  for (int i = 0; i < 5; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));

    // if (i == 2) {
    //   throw Exception('2 oldu hata çıktı');
    // }
  }
}

StreamController<int> _controller = StreamController<int>.broadcast();
Stream<int> get myStream => _controller.stream;
Sink<int> get mySink => _controller.sink;

void main(List<String> args) {
  //subscriptonIslemleri();
  // broadCasStream();
  //streamMetotlariKullanimi();
  StreamControllerKullanim();
}

void StreamControllerKullanim() {
  myStream
      .map(
    (event) => event * 2,
  )
      .listen(
    (event) {
      print("Çoklu Stream Controller" + event.toString());
    },
  );

  myStream.listen(
    (event) {
      print(event);
    },
  );
  veriEkle();
}

void veriEkle() async {
  mySink.add(5);
  await Future.delayed(Duration(seconds: 1));
  mySink.add(10);
  await Future.delayed(Duration(seconds: 1));
  mySink.add(15);
  await Future.delayed(Duration(seconds: 1));
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

void streamMetotlariKullanimi() {
  final mystream = getNumbers();

  // mystream.expand((element) => [element, element * 2, 99]).listen(
  //   (event) {
  //     print("Elemenların her birinin denişlemiş hali : " + event.toString());
  //   },
  // );

  // mystream
  //     .map(
  //   (event) => event * 5,
  // )
  //     .listen(
  //   (event) {
  //     print("listeyi başka listeye dönüşmüş hali:" + event.toString());
  //   },
  // );

  // mystream
  //     .where(
  //   (event) => event % 2 == 0,
  // )
  //     .listen(
  //   (event) {
  //     print("Şartlı ifade: " + event.toString());
  //   },
  // );

  // mystream.take(2).listen(
  //   (event) {
  //     print("Counta göre alınan elemanları" + event.toString());
  //   },
  // );

  // mystream.distinct().listen(
  //   (event) {
  //     print("farklı olan elemanlar : " + event.toString());
  //   },
  // );

  mystream
      .map(
        (event) => event * 2,
      )
      .where(
        (event) => event % 3 == 0,
      )
      .distinct()
      .listen(
    (event) {
      print("Çoklu Stream : " + event.toString());
    },
  );
}
