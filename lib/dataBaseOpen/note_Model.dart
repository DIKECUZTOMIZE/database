
/// Modale classs
class NoteModel {
  int? id;
  String title;
  String desc;
  String createdAt;



  NoteModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.createdAt});
}
