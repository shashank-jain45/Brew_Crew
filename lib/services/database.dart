import 'package:brew_crew/model/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  DataBaseService({this.uid});

  Future updateUserData(String sugars, int strength, String name) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'strength': strength,
      'name': name,
    });
  }

  List<Brew> _brewsFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (e) => Brew(
            name: e.data().toString().contains('name') ? e.get('name') : '',
            sugar:
                e.data().toString().contains('sugars') ? e.get('sugars') : '',
            strength: e.data().toString().contains('strength')
                ? e.get('strength')
                : 100,
          ),
        )
        .toList();
  }

  Brew _userDataFromSnapshots(DocumentSnapshot snapshot) {
    print("printing name in database ${snapshot.get('name')}");
    return Brew(
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      sugar: snapshot.data().toString().contains('sugars')
          ? snapshot.get('sugars')
          : '',
      strength: snapshot.data().toString().contains('strength')
          ? snapshot.get('strength')
          : 100,
    );
  }

  Stream<Brew> get userData {
    print(uid);
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshots);
  }

  Stream<List<Brew>> get brew {
    return brewCollection.snapshots().map(_brewsFromSnapshots);
  }
}
