// lib/models/barber.dart

class Barber {
  final int id;
  final int barbeiroId;
  final String category;
  final int? clientes;
  final int experiencia;
  final String narrativas;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String barbeiroName;
  final String barbeiroProfile;

  Barber({
    required this.id,
    required this.barbeiroId,
    required this.category,
    this.clientes,
    required this.experiencia,
    required this.narrativas,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.barbeiroName,
    required this.barbeiroProfile,
  });

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['id'],
      barbeiroId: json['barbeiro_id'],
      category: json['category'],
      clientes: json['clientes'],
      experiencia: json['experiencia'],
      narrativas: json['narrativas'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      barbeiroName: json['barbeiro_name'],
      barbeiroProfile: json['barbeiro_profile'],
    );
  }
}
