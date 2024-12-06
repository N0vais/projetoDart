<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Appointments;
use Illuminate\Http\Request;

class AppointmentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // Autenticação do usuário
            $user = Auth::user();
            if (!$user) {
                return response()->json(['error' => 'Usuário não autenticado'], 401);
            }

            // Obter agendamentos e barbeiros
            $agendamento = Appointments::where('user_id', $user->id)->get();
            $barbeiro = User::where('type', 'barbeiro')->get();

            // Verificar dados de barbeiros
            foreach($agendamento as $data){
                foreach($barbeiro as $info){
                    $details = $info->barbeiro;
                    if($data['barbeiro_id'] == $info['id']){
                        $data['barbeiro_name'] = $info['name'];
                        $data['barbeiro_profile'] = $info['profile_photo_url'];
                        $data['category'] = $details['category'];
                    }
                }
            }

            // Retornar os dados do agendamento com barbeiros
            return response()->json($agendamento);
        } catch (\Exception $e) {
            // Log de erro para diagnóstico
            \Log::error('Erro ao processar solicitação: ' . $e->getMessage());
            return response()->json(['error' => 'Erro no servidor', 'message' => $e->getMessage()], 500);
        }
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        \Log::info('Recebendo dados:', $request->all());

        // Validação dos dados recebidos
        $validated = $request->validate([
            'barbeiro_id' => 'required|integer',
            'date' => 'required|date',
            'day' => 'required|string',
            'time' => 'required|string',
        ]);

        try {
            $appointments = new Appointments();
            $appointments->user_id = Auth::user()->id;
            $appointments->barbeiro_id = $validated['barbeiro_id'];
            $appointments->date = $validated['date'];
            $appointments->day = $validated['day'];
            $appointments->time = $validated['time'];
            $appointments->status = 'upcoming';
            $appointments->save();

            return response()->json([
               'Sucesso' => 'Um novo agendamento foi feito.'
            ], 200);
        } catch (\Exception $e) {
            \Log::error('Erro ao fazer o agendamento:', ['message' => $e->getMessage()]);
            return response()->json(['error' => 'Internal Server Error'], 500);
        }
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
