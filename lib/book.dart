import 'dart:io';

class Book {
  List<Note> notList = [];
  String title;
  String url;
  String imagePath;
  Book({this.title, this.url, this.imagePath, this.notList});
}

class Note {
  String title;
  String content;
  String page;
  Note({this.title, this.content, this.page});
}

List<Book> bookList = [   
  Book(
      title: "Mekke'ye Giden Yol",
      url:
          "https://i.idefix.com/cache/600x600-0/originals/0000000438654-1.jpg", notList: []),
  Book(
      title: "Cesur Yeni Dünya",
      url:
          "https://i.idefix.com/cache/600x600-0/originals/0000000066424-1.jpg", notList: []),
  Book(
      title: "Varlık Ve Zaman",
      url: "https://i.idefix.com/cache/600x600-0/originals/0001779950001-1.jpg", notList: [])
];
