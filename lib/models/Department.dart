
class Department{
  final int id;
   final String name;

  Department(this.id, this.name);

  static Department fromMap(Map<String,dynamic> map){
    int  id=int.tryParse(map['id'].toString())??10;
   String name = map['name'].toString();

    return Department(id,name);
  }

}