<?php

namespace Database\Seeders;

use App\Models\Province;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProvinceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $provinces = [
            'Banteay Meanchey',
            'Battambang',
            'Kampong Cham',
            'Kampong Chhnang',
            'Kampong Speu',
            'Kampong Thom',
            'Kampot',
            'Kandal',
            'Kep',
            'Koh Kong',
            'Kratie',
            'Mondulkiri',
            'Phnom Penh',
            'Preah Vihear',
            'Prey Veng',
            'Pursat',
            'Ratanakiri',
            'Siem Reap',
            'Preah Sihanouk',
            'Stung Treng',
            'Svay Rieng',
            'Takeo',
            'Oddar Meanchey',
            'Pailin',
            'Tboung Khmum',
        ];

        foreach ($provinces as $province) {
            Province::create(['name' => $province]);
        }
    }
}
