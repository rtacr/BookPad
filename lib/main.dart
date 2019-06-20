import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:notepad/book.dart';
import 'package:notepad/pages/book_page.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

Color bgColor = Color.fromRGBO(40, 40, 40, 1);
// Color bgColor = Colors.white;
Book temp;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _crossAxisCount = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notlarım",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: (){
              setState(() {
                if(_crossAxisCount == 2)  _crossAxisCount = 1;
                else if(_crossAxisCount == 1)  _crossAxisCount = 2;                 
              });
            },
          )
        ],
      ),
      body: Container(
          color: bgColor,
          padding: EdgeInsets.all(24),
          child: bookList.length == 0
              ? Center(
                  child: Text("Kitap Ekleyin"),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookPage(book: bookList[index])),
                        );
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  height: 200,
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text("Sil"),
                                        onTap: () {
                                          setState(() {
                                            bookList.remove(bookList[index]);
                                          });
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                      },
                      child: Container(
                        child: GridTile(
                          // footer: Container(
                          //   height: 50,
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         begin: Alignment.bottomCenter,
                          //         end: Alignment.topCenter,
                          //         colors: [
                          //           Color.fromRGBO(0, 0, 0, 1),
                          //           Color.fromRGBO(0, 0, 0, 0)
                          //         ]
                          //       )
                          //     ),
                          //     padding: EdgeInsets.only(top: 10),
                          //     alignment: Alignment.topCenter,
                          //     child: Text(book.title,
                          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          //     )),
                          child: Container(
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(30.0),
                                    child: bookList[index].url == null
                                        ? Image.file(File.fromUri(
                                            Uri.parse(bookList[index].imagePath)))
                                        : Image.network(bookList[index].url))),
                          ),
                        ),
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        shape: ContinuousRectangleBorder(
            borderRadius: (BorderRadius.circular(15))),
        child: Icon(Icons.add),
        onPressed: () async {
          //bottomSheet(context);
          final result = await showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => ModalBottomSheet());
          print(result);
          if (result == "Success") {
            if (temp != null) {
              setState(() {
                bookList.add(temp);
                temp = null;
              });
            }
          }
        },
      ),
    );
  }
}

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  Future<File> bookImage;
  String imgPath = "";
  TextEditingController kitapAdiCont = TextEditingController();
  TextEditingController yazarAdiCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: (){},
              child: Container(
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(
                      fit: BoxFit.cover,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              bookImage = ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                            });
                          },
                          child: Container(
                            color: Colors.black,
                            child: Center(
                              child: FutureBuilder(
                                  future: bookImage,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<File> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.data != null) {
                                      imgPath = snapshot.data.path;
                                      return Image.file(
                                        snapshot.data,
                                      );
                                    } else if (snapshot.error != null) {
                                      return const Text(
                                        'Error Picking Image',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.photo,
                                        color: bgColor,
                                        size: 50,
                                      );
                                    }
                                  }),
                            ),
                            height: 200,
                            width: 130,
                          ),
                        ),
                      )),
                  Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          controller: kitapAdiCont,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Kitap Adı'),
                        ),
                        TextField(
                          controller: yazarAdiCont,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Yazar Adı'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              MaterialButton(
                minWidth: 100,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Color.fromRGBO(80, 80, 80, 1),
                child: Text("Kaydet"),
                onPressed: () {
                  if (kitapAdiCont.text != "" || bookImage != null) {
                    temp = (Book(title: kitapAdiCont.text, imagePath: imgPath, notList: []));
                    Navigator.pop(context, "Success");
                  } else {
                    Navigator.pop(context, "Fail");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
