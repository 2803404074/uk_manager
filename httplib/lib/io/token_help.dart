
import 'sp_util.dart';

class TokenHelp{

  static TokenHelp? _tokenHelp;

  static TokenHelp getInstance(){
    _tokenHelp ??= TokenHelp();
    return _tokenHelp!;
  }

  String? _token;

  String? getToken(){
    _token ??= SpUtils.getString('token');
    return _token;
  }

  Future<void> setToken(String? newToken)async{
    if(newToken == null)return;
    await SpUtils.putString('token', newToken);
    _token = newToken;
  }

  Future<bool> removeToken()async{
    _token = null;
    return SpUtils.removeValue('token');
  }
}