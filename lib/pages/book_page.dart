import 'dart:io';

import 'package:notepad/book.dart';
import 'package:flutter/material.dart';
import 'package:notepad/main.dart';

class BookPage extends StatefulWidget {
  Book book;
  BookPage({this.book});
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        centerTitle: true,
      ),
      body: Container(
        color: bgColor,
        child: ListView.builder(
          itemCount: widget.book.notList.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: CircleAvatar(child: Text((i + 1).toString())),
              title: Text(widget.book.notList[i].title),
              subtitle: Text("Sayfa " + widget.book.notList[i].page),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.book.notList.removeAt(i);
                  });
                },
              ),
              onTap: () {
                TextEditingController baslikCont = TextEditingController();
                TextEditingController notCont = TextEditingController();
                TextEditingController sayfCont = TextEditingController();

                baslikCont.text = widget.book.notList[i].title;
                notCont.text = widget.book.notList[i].content;
                sayfCont.text = widget.book.notList[i].page;
                showDialog(
                    context: context,
                    child: Material(
                      child: Container(
                        height: 100,
                        color: bgColor,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              textAlign: TextAlign.center,
                              controller: baslikCont,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Başlık'),
                              style: TextStyle(fontSize: 24),
                            ),
                            TextField(
                              maxLines: 20,
                              textAlign: TextAlign.start,
                              controller: notCont,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Not'),
                              style: TextStyle(fontSize: 18),
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              controller: sayfCont,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Sayfa'),
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            ListTile(
                              leading: MaterialButton(
                                  color: Colors.red,
                                  child: Text("İptal"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              title: MaterialButton(
                                color: Colors.green,
                                child: Text("Kaydet"),
                                onPressed: () {
                                  if (baslikCont.text != "" ||
                                      notCont.text != "" ||
                                      sayfCont.text != "") {
                                    setState(() {
                                      widget.book.notList[i] = (Note(
                                          title: baslikCont.text,
                                          content: notCont.text,
                                          page: sayfCont.text));
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TextEditingController baslikCont = TextEditingController();
          TextEditingController notCont = TextEditingController();
          TextEditingController sayfCont = TextEditingController();
          showDialog(
              context: context,
              child: Material(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  color: bgColor,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        textAlign: TextAlign.center,
                        controller: baslikCont,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Başlık'),
                        style: TextStyle(fontSize: 24),
                      ),
                      TextField(
                        maxLines: 20,
                        textAlign: TextAlign.start,
                        controller: notCont,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Not'),
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: sayfCont,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Sayfa'),
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      ListTile(
                        leading: MaterialButton(
                            color: Colors.red,
                            child: Text("İptal"),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        title: MaterialButton(
                          color: Colors.green,
                          child: Text("Kaydet"),
                          onPressed: () {
                            if (baslikCont.text != "" ||
                                notCont.text != "" ||
                                sayfCont.text != "") {
                              setState(() {
                                widget.book.notList.add(Note(
                                    title: baslikCont.text,
                                    content: notCont.text,
                                    page: sayfCont.text));
                              });
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
