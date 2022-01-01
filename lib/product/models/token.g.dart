// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokensAdapter extends TypeAdapter<Tokens> {
  @override
  final int typeId = 1;

  @override
  Tokens read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tokens(
      access: fields[0] as Access,
      refresh: fields[1] as Access,
    );
  }

  @override
  void write(BinaryWriter writer, Tokens obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.access)
      ..writeByte(1)
      ..write(obj.refresh);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokensAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccessAdapter extends TypeAdapter<Access> {
  @override
  final int typeId = 2;

  @override
  Access read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Access(
      token: fields[0] as String,
      expires: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Access obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tokens _$TokensFromJson(Map<String, dynamic> json) => Tokens(
      access: Access.fromJson(json['access'] as Map<String, dynamic>),
      refresh: Access.fromJson(json['refresh'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
      'access': instance.access.toJson(),
      'refresh': instance.refresh.toJson(),
    };

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      token: json['token'] as String,
      expires: json['expires'] as String,
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires,
    };
