// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:contacts_buddy/models/contact_number.dart';
import 'package:flutter/foundation.dart';

class Contact {
  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? email;
  String? address;
  String? notes;
  int? isFavorite;
  String? lastCalled;
  List<ContactNumber>? numbers;
  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.email,
    this.address,
    this.notes,
    this.isFavorite,
    this.lastCalled,
    this.numbers,
  });

  Contact copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? company,
    String? email,
    String? address,
    String? notes,
    int? isFavorite,
    String? lastCalled,
    List<ContactNumber>? numbers,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      isFavorite: isFavorite ?? this.isFavorite,
      lastCalled: lastCalled ?? this.lastCalled,
      numbers: numbers ?? this.numbers,
    );
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'company': company,
      'email': email,
      'address': address,
      'notes': notes,
      'isFavorite': isFavorite,
      'lastCalled': lastCalled,
    };
return map;
  }

  factory Contact.fromMap(Map<dynamic, Object?> map) {
    return Contact(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      company: map['company'] != null ? map['company'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as int : null,
      lastCalled: map['lastCalled'] != null ? map['lastCalled'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, firstName: $firstName, lastName: $lastName, company: $company, email: $email, address: $address, notes: $notes, isFavorite: $isFavorite, lastCalled: $lastCalled, numbers: $numbers)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.company == company &&
        other.email == email &&
        other.address == address &&
        other.notes == notes &&
        other.isFavorite == isFavorite &&
        other.lastCalled == lastCalled &&
        listEquals(other.numbers, numbers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        company.hashCode ^
        email.hashCode ^
        address.hashCode ^
        notes.hashCode ^
        isFavorite.hashCode ^
        lastCalled.hashCode ^
        numbers.hashCode;
  }
}
