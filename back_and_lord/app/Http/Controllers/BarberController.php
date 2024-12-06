<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Appointments;
use App\Models\Reviews;

class BarberController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $barbeiro = Auth::user();
        $appointments = Appointments::where('barbeiro_id', $barbeiro->id)->where('status', 'upcoming')->get();
        $reviews = Reviews::where('barbeiro_id', $barbeiro->id)->where('status', 'active')->get();

        //retorna os dados para os dashboard
        return view('dashboard')->with(['barbeiro'=>$barbeiro, 'appointments'=>$appointments, 'reviews'=>$reviews]);
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
        $reviews = new Reviews;
        $appointments = Appointments::where('id', $request->get('appointment-id'))->first();

        $reviews ->user_id = Auth::user()->id;
        $reviews->barbeiro_id = $request->get('barbeiro_id');
        $reviews->avaliacoes = $request->get('avaliacoes');
        $reviews->reviews = $request->get('reviews');
        $reviews->reviewed_by = Auth::user()->name;
        $reviews->status = 'active';
        $reviews->save()

        $appointment->status = 'complete';
        $appointment->save();

        return response()->json([
            'sucesso'=>'o seu agendamento'
        ], 200);
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
