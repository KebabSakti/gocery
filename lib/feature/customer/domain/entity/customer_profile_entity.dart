abstract class CustomerProfileEntity {
  CustomerProfileEntity({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.picture,
  });

  final String? uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? picture;
}
