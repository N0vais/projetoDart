<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Barbeiro extends Model
{
    use HasFactory;
        protected $fillable = [
            'barbeiro_id',
            'category',
            'clientes',
            'experiencia',
            'narrativas',
            'status',
        ];
        public function user(){
            return $this->belongsTo(User::class);
        }
}
