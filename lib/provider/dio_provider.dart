import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  final Dio _dio;

  DioProvider() : _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/',
    connectTimeout: const Duration(milliseconds: 20000),
    receiveTimeout: const Duration(milliseconds: 20000),
    sendTimeout: const Duration(milliseconds: 20000),
  )
  );

  // Busca o token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await _dio.post('login',
          data: {'email': email, 'password': password});

      // Se a resposta for bem-sucedida, retorna true
      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefz = await SharedPreferences.getInstance();
        await prefz.setString('token', response.data);

        //print('Token recebido: ${response.data}');
        return true;
      } else {
        //print('Erro ao obter token: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      //print('Erro na solicitação: ${e.message}');
      return false;
    } catch (error) {
      //print('Erro inesperado: $error');
      return false;
    }
  }

  // Pega os dados do usuário
  Future<dynamic> getUser(String token) async {
    try {
      var user = await _dio.get('user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (user.statusCode == 200 && user.data != '') {
        //print('Dados do usuário recebidos: ${user.data}');
        return jsonEncode(user.data);
      } else {
        //print('Erro ao obter dados do usuário: ${user.statusCode}');
        return null;
      }
    } on DioError catch (e) {
      //print('Erro na solicitação: ${e.message}');
      return null;
    } catch (error) {
      //print('Erro inesperado: $error');
      return null;
    }
  }

  // Adiciona um novo registro.
  Future<bool?> registerUser(String username, String email, String password) async {
    try {
      var user = await _dio.post('register',
          data: {'name': username, 'email': email, 'password': password});

      if (user.statusCode == 201 && user.data != '') {
        //print('Dados do usuário recebidos: ${user.data}');
        return true;
      } else {
        //print('Erro ao obter dados do usuário: ${user.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      //print('Erro na solicitação: ${e.message}');
      return false;
    } catch (error) {
      //print('Erro inesperado: $error');
      return false;
    }
  }

  //detalhes do agendamento
  Future<dynamic>bookingAgenda(String date, String day,String time,int barbeiro, String token) async {
    try {

      //print('Enviando dados para o servidor:');
      //print('Date: $date, Day: $day, Time: $time, Barbeiro ID: $barbeiro, Token: $token');

      var response = await _dio.post('bokin',
          data: {
            'date': date,
            'day': day,
            'time': time,
            'barbeiro_id': barbeiro,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      //print('Resposta do servidor: ${response.statusCode}, ${response.data}');

      if (response.statusCode == 200 && response.data != 'data') {
        return response.statusCode;
      }else{
        return'ERROR';
      }
    }catch(error){
      //print('Erro ao fazer a solicitação: $error');
      return error;
    }
  }

  //retornado o agendamento
  Future<dynamic>getAgenda(String token) async {
    try {
      //print('recebendo dados do servidor:');

      var response = await _dio.get('agendamento',
      options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      print('Resposta do seria esta servidor: ${response.statusCode}, ${response.data}');

      if (response.statusCode == 200 && response.data != '') {
        return response.data;
      }else{
        return'ERROR';
      }
    }catch(error){
      //print('Erro ao fazer a solicitação: $error');
      return 'ERROR';
    }
  }
}

