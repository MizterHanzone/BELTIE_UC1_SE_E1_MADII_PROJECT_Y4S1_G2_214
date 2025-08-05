@extends('layouts.admin')
@section('title', 'Track Order | Edit')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Order infomation</h3>
                <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                    <li>
                        <a href="{{ route('admin.index') }}">
                            <div class="text-tiny">Dashboard</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <a href="{{ route('orders.index') }}">
                            <div class="text-tiny">Order</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <div class="text-tiny">Track Order</div>
                    </li>
                </ul>
            </div>
            <!-- new-category -->
            <div class="wg-box">
                <form class="form-style-1" action="{{ route('orders.update', $order->id) }}" method="POST">
                    @csrf
                    @method('PUT')

                    <fieldset class="name">
                        <div class="body-title">Order ID</div>
                        <input type="text" value="#{{ $order->id }}" readonly>
                    </fieldset>

                    <fieldset class="name">
                        <div class="body-title">Customer</div>
                        <input type="text" value="{{ $order->user->first_name }} {{ $order->user->last_name }}" readonly>
                    </fieldset>

                    <fieldset class="name">
                        <div class="body-title">Total Amount</div>
                        <input type="text" value="${{ $order->total_amount }}" readonly>
                    </fieldset>

                    <fieldset class="name">
                        <div class="body-title">Order Status <span class="tf-color-1">*</span></div>
                        <select name="status" required>
                            @if ($order->status == 'confirmed')
                                @foreach (['preparing', 'delivering', 'delivered', 'cancelled'] as $status)
                                    <option value="{{ $status }}" {{ $order->status === $status ? 'selected' : '' }}>
                                        {{ ucfirst($status) }}
                                    </option>
                                @endforeach
                            @elseif($order->status == 'preparing')
                                @foreach (['delivering', 'delivered', 'cancelled'] as $status)
                                    <option value="{{ $status }}"
                                        {{ $order->status === $status ? 'selected' : '' }}>
                                        {{ ucfirst($status) }}
                                    </option>
                                @endforeach
                            @elseif($order->status == 'delivering')
                                @foreach (['delivered', 'cancelled'] as $status)
                                    <option value="{{ $status }}"
                                        {{ $order->status === $status ? 'selected' : '' }}>
                                        {{ ucfirst($status) }}
                                    </option>
                                @endforeach
                            @elseif($order->status == 'delivered')
                                @foreach (['cancelled'] as $status)
                                    <option value="{{ $status }}"
                                        {{ $order->status === $status ? 'selected' : '' }}>
                                        {{ ucfirst($status) }}
                                    </option>
                                @endforeach
                            @endif
                        </select>
                    </fieldset>
                    @error('status')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <div class="bot">
                        <div></div>
                        <button class="tf-button w208" type="submit">Update Status</button>
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
