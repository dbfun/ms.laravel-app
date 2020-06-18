<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class HealthChecker extends Controller
{
    public function check(Request $request)
    {
        try {
            DB::connection('mysql')->table(DB::raw('migrations'))->first([DB::raw(1)]);
        } catch (\Exception $e) {
            return response()->json([
                'result' => 'fail',
                'message' => $e->getMessage(),
            ], 500);
        }

        return response()->json([
            'result' => 'ok'
        ]);
    }
}
