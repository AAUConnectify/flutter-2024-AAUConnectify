
import 'package:jwt_decode/jwt_decode.dart';
class TokenM{
  final String token;
  TokenM(this.token); 

  String getRole(){
    try{
      final Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      return decodedToken['role'];
    }catch(e){
      rethrow;
    }
  }

  bool isExpired(){
    try{
      return Jwt.isExpired(token);
    }catch(e){
      rethrow;
    }
  }
  }