@extends('layouts.admin')
@section('title', 'Stock | Add Stock')

@section('content')
<div class="main-content-inner">
    <div class="main-content-wrap">
        <div class="flex items-center flex-wrap justify-between gap20 mb-27">
            <h3>Update Stock</h3>
            <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                <li><a href="{{ route('admin.index') }}"><div class="text-tiny">Dashboard</div></a></li>
                <li><i class="icon-chevron-right"></i></li>
                <li><a href="{{ route('products.index') }}"><div class="text-tiny">Products</div></a></li>
                <li><i class="icon-chevron-right"></i></li>
                <li><div class="text-tiny">Add Stock</div></li>
            </ul>
        </div>

        <div class="wg-box">
            <form class="tf-section-2 form-add-product1" action="{{ route('update-quantity.store') }}" method="POST">
                @csrf

                <div class="wg-box">
                    <fieldset class="category">
                        <div class="body-title mb-10">Product <span class="tf-color-1">*</span></div>
                        <div class="select">
                            <select name="product_id" required>
                                <option value="">-- Select Product --</option>
                                @foreach ($products as $product)
                                    <option value="{{ $product->id }}">
                                        {{ $product->name }} (Current Qty: {{ $product->quantity }})
                                    </option>
                                @endforeach
                            </select>
                        </div>
                        @error('product_id')
                            <span class="alert danger-text text-center d-block">{{ $message }}</span>
                        @enderror
                    </fieldset>
                </div>

                <div class="wg-box">
                    <fieldset class="name">
                        <div class="body-title">Quantity<span class="tf-color-1">*</span></div>
                        <input class="flex-grow" type="number" name="add_quantity" placeholder="Enter quantity to add" min="1" required>
                        @error('add_quantity')
                            <span class="alert danger-text text-center d-block">{{ $message }}</span>
                        @enderror
                    </fieldset>
                </div>

                <div class="bot">
                    <div></div>
                    <button class="tf-button w208" type="submit">Update Stock</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection


@push('scripts')
    <script>
        $(function() {
            $("#myFile").on("change", function(e) {
                const photoInp = $("#myFile");
                const [file] = this.files;
                if (file) {
                    $("#imgpreview img").attr('src', URL.createObjectURL(file));
                    $("#imgpreview").show();
                }
            });

            $("input[name='name']").on("change", function() {
                $("input[name='slug']").val(StringToSlug($(this).val()));
            })
        })

        function StringToSlug(Text) {
            return Text.ToLowerCase()
                .replace(/[^\w ]+/g, "")
                .replace(/ +/g, "-");
        }
    </script>
@endpush
