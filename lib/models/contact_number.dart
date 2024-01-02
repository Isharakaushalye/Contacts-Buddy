// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactNumber {
  int? id;
  int? contactId;
  String? numberDefinition;
  String? phoneNumber;
  ContactNumber({
    this.id,
    this.contactId,
    this.numberDefinition,
    this.phoneNumber,
  });

  ContactNumber copyWith({
    int? id,
    int? contactId,
    String? numberDefinition,
    String? phoneNumber,
  }) {
    return ContactNumber(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      numberDefinition: numberDefinition ?? this.numberDefinition,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'contactId': contactId,
      'numberDefinition': numberDefinition,
      'phoneNumber': phoneNumber,
    };
    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }

  factory ContactNumber.fromMap(Map<dynamic, dynamic> map) {
    return ContactNumber(
      id: map['id'] != null ? map['id'] as int : null,
      contactId: map['contactId'] != null ? map['contactId'] as int : null,
      numberDefinition: map['numberDefinition'] != null ? map['numberDefinition'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactNumber.fromJson(String source) => ContactNumber.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactNumber(id: $id, contactId: $contactId, numberDefinition: $numberDefinition, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant ContactNumber other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.contactId == contactId &&
      other.numberDefinition == numberDefinition &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      contactId.hashCode ^
      numberDefinition.hashCode ^
      phoneNumber.hashCode;
  }
}
