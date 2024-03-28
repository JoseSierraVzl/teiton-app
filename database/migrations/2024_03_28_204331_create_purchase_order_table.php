<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('purchase_order', function (Blueprint $table) {
            $table->id()->primary();
            $table->bigInteger('number_order');
            $table->timestamp('request_date');
            $table->timestamp('realization_date');
            $table->timestamp('availability_date');
            $table->decimal('total_amount', 13, 4);
            $table->integer('product_quantity');
            $table->foreignUuid('user_id')->constrained()
                ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_order');
    }
};
