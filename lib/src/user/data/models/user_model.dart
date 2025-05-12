import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    super.updatedAt
  });

  const UserModel.empty()
      : this(
    id: "1",
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    updatedAt: 'empty.updatedAt'
  );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
    id: map['id'] as String,
    createdAt: map['createdAt'] as String,
    name: map['name'] as String,
    updatedAt: map['updatedAt'] as String,

  );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? updatedAt

  }) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name?? this.name,
      updatedAt: updatedAt ?? this.name
    );
  }

  DataMap toMap() => {
    'id': id,
    'createdAt': createdAt,
    'name': name,
    'updatedAt' : updatedAt
  };

  String toJson() => jsonEncode(toMap());
}



