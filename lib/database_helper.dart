import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:notepad/book.dart';

import 'dart:async';
import 'dart:io';
/*
class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String articleTable = 'article_table';
  String colID = 'id';
  String colTitle = 'title';
  String colImageUrl = 'imageUrl';
  String colHtml = 'htmlText';
  String colDate = 'date';
  String colAuthorName = 'authorName';
  String colAuthorImage = 'authorImageUrl';
  String colPostUrl = 'postUrl';
  String colFormat = 'format';
  String colIsFavorited = 'isFavorited';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'articles.db';

    Database articlesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return articlesDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    String sqlCommand = 'CREATE TABLE $articleTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colImageUrl TEXT, $colHtml TEXT, $colDate TEXT, $colAuthorName TEXT,$colAuthorImage TEXT, $colPostUrl TEXT, $colFormat TEXT, $colIsFavorited INTEGER)';
    await db.execute(sqlCommand);
  }

  Future<List<Map<String, dynamic>>> getArticleMapList() async{
    Database db = await this.database;

    String sqlQueryCommand = 'Select * From $articleTable order by $colDate DESC';
    var result = await db.rawQuery(sqlQueryCommand);
  
    return result;
  }

  Future<List<Article>> getArticleList() async{
    var articleMapList = await getArticleMapList();
    int count = articleMapList.length;

    List<Article> articleList = List<Article>();

    for (int i = 0; i < count; i++) {
      articleList.add(Article.fromMapObject(articleMapList[i]));
    }

    return articleList;
  }

  Future<int> insertArticle(Article article) async{
    Database db = await this.database;

    var result = await db.insert(articleTable, article.toMap());
    return result;
  }

  Future<int> updateArticle(Article article) async{
    Database db = await this.database;

    var result = await db.update(articleTable, article.toMap(), where: '$colID = ?', whereArgs: [article.id]);
    return result;
  }

  Future<int> deleteArticle(int id) async{
      Database db = await this.database;
      
      var result = await db.rawDelete('DELETE FROM $articleTable WHERE $colID = $id');
      return result;
  }

  Future<int> getCount() async{
      Database db = await this.database;
      List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $articleTable');
      
      int result = Sqflite.firstIntValue(x);
      return result;
  }

  Future<bool> doesExist(String url) async{
      Database db = await this.database;
      List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $articleTable WHERE $colPostUrl = "' + url + '"');
      
      int result = Sqflite.firstIntValue(x);
      if(result != 0)   return true;
      else              return false;
  }

  
  Future<Article> getArticleByUrl(String url) async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $articleTable WHERE $colPostUrl = "' + url + '"');
    Article article = Article.fromMapObject(x[0]);
    return article;  
  }

  void saveToDatabase(List dataList) async {
    DatabaseHelper helper = new DatabaseHelper();
    int maxCacheSize = 25;
    int count = maxCacheSize < dataList.length ? maxCacheSize : dataList.length;
    for (int i = 0; i < count; i++) {
        

      String date = dataList[i]['date'];
      String newAnaMetin = dataList[i]["content"]["rendered"];
      String imageUrl = dataList[i]["_embedded"]["wp:featuredmedia"][0]["source_url"];

      String author = dataList[i]["_embedded"]["author"][0]["name"];
      String authorImageUrl = dataList[i]["_embedded"]["author"][0]["avatar_urls"]["96"].toString();

      String title = dataList[i]["title"]["rendered"].toString();
      String postUrl = dataList[i]["link"].toString();
      String format = dataList[i]["format"].toString();
 
      title = title.replaceAll('&#8217;', "\'");
      title = title.replaceAll('&#8221;', "\"");
      title = title.replaceAll('&#8220;', '“');
      title = title.replaceAll('&nbsp;', ' ');
      title = title.replaceAll('&#8211;', '–');

      Article myArticle = new Article(title, imageUrl, newAnaMetin, date, author, authorImageUrl, postUrl, format, 0);
      

      int result;
      
          bool exist = false;
          exist = await doesExist(myArticle.postUrl);
          if(exist){
            print('Article Updated : ' + myArticle.title.toString());
            Article temp = await getArticleByUrl(myArticle.postUrl);
            result = await helper.updateArticle(temp);
          }else{
            print('Article Added : ' + myArticle.title.toString());
            result = await helper.insertArticle(myArticle);
          
        

        if (result != 0) {  // Success
        } else {  // Failure
        }
      }
    }
    print('Finished');
  }
}

*/