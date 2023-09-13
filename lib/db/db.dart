





import '../main.dart';


Future<List> getfavorates()async{
  List<Map> list = await database.rawQuery('SELECT * FROM favorates ');
  print(list);
  return list;
}



void insertfavorate(String cat,String desc,String pid,String name,String price,String img)async {
  await database.rawInsert(
      'INSERT INTO favorates(cat_id ,desc , pid  , name  , price , img)'
          'VALUES(?,?,?,?,?,?)',
      [cat,desc,pid,name,price,img]);
}





void removefavs(String tid)async {
  await database.rawDelete(
      "DELETE FROM favorates WHERE pid = $tid");
}


Future<bool> isfavorate(String tid)async {
  List<Map> list = await database.rawQuery(
      "SELECT * FROM favorates WHERE pid = $tid");
  bool k;
  if(list.length>0){
    k= true;
  }
  else{
    k= false;
  }
return k;
}
