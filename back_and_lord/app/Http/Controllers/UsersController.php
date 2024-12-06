<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Barbeiro;
use App\Models\UserDetails;
use App\Models\Appointments; // Adicionado importação da classe Appointments

class UsersController extends Controller
{
    public function index()
    {
        // Obtém o usuário autenticado
        $user = Auth::user();
        // Verifica se o usuário está autenticado
        if (!$user) {
            return response()->json(['error' => 'Usuário não autenticado'], 401);
        }
        // Obtém os barbeiros e os dados dos barbeiros
        $barbeiros = User::where('type', 'barbeiro')->get();
        $barbeiroData = Barbeiro::all();
        $date = now()->format('m/d/y');
        $agendamento = Appointments::where('date', $date)->first();

        // Cria um mapa para facilitar a associação de barbeiros
        $barbeirosMap = $barbeiros->keyBy('id');

        foreach ($barbeiroData as $data) {
            if (isset($barbeirosMap[$data['barbeiro_id']])) {
                $barbeiro = $barbeirosMap[$data['barbeiro_id']];
                $data['barbeiro_name'] = $barbeiro['name'];
                $data['barbeiro_profile'] = $barbeiro['profile_photo_url'];

                if (isset($agendamento) && $agendamento['barbeiro_id'] == $barbeiro['id']) {
                    $data['appointments'] = $agendamento;
                }
            }
        }

        // Adiciona os dados dos barbeiros ao usuário
        $user['barbeiro'] = $barbeiroData;

        // Retorna os dados do usuário
        return response()->json($user);
    }

    // Mostrar formulário para criar novo recurso
    public function create()
    {
        //
    }

    // Login
    public function login(Request $request)
    {
        // Validar entradas recebidas
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Verificar o usuário correspondente
        $user = User::where('email', $request->email)->first();

        // Check password
        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['login inválido!!!'],
            ]);
        }

        // Retorna o token gerado
        return $user->createToken($request->email)->plainTextToken;
    }

    // Registrar
    public function register(Request $request)
    {
        // Validar entradas recebidas
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Criar novo usuário
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'type' => 'user',
            'password' => Hash::make($request->password)
        ]);

        // Criar detalhes do usuário
        $userInfo = UserDetails::create([
            'user_id' => $user->id,
            'status' => 'active',
        ]);

        return response()->json($user, 201); // Retorna a resposta com código 201 (Criado)
    }

    // Armazenar um novo recurso
    public function store(Request $request)
    {
        //
    }

    // Exibir recurso especificado
    public function show(string $id)
    {
        //
    }

    // Mostrar formulário para editar recurso especificado
    public function edit(string $id)
    {
        //
    }

    // Atualizar recurso especificado
    public function update(Request $request, string $id)
    {
        //
    }

    // Remover recurso especificado
    public function destroy(string $id)
    {
        //
    }
}
