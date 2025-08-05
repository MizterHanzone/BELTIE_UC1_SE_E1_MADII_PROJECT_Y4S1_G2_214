@extends('layouts.admin')
@section('title', 'Order Detail')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Order Details</h3>
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
                        <div class="text-tiny">Order Details</div>
                    </li>
                </ul>
            </div>
            <div class="wg-box">
                <div class="flex items-center justify-between gap10 flex-wrap">
                    <h5>Customer Info</h5>
                    <div class="wg-filter flex-grow">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-transaction">
                                <tbody>
                                    <tr>
                                        <th>Order No</th>
                                        <td>{{ $order->id }}</td>
                                        <th>Order Date</th>
                                        <td>{{ \Carbon\Carbon::parse($order->created_at)->format('d-F-Y h:iA') }}</td>
                                        <th>
                                            @if ($order->status == 'confirmed')
                                                Confirmed Date
                                            @elseif($order->status == 'preparing')
                                                Preparing Date
                                            @elseif($order->status == 'delivering')
                                                Delivering Date
                                            @elseif($order->status == 'delivered')
                                                Delivered Date
                                            @elseif($order->status == 'cancelled')
                                                Cancelled Date
                                            @endif
                                        </th>
                                        <td>{{ \Carbon\Carbon::parse($order->updated_at)->format('d-F-Y h:iA') }}</td>
                                    </tr>
                                    <tr>
                                        <th>Customer</th>
                                        <td>{{ $order->user->first_name }} {{ $order->user->last_name }}</td>
                                        <th>Email</th>
                                        <td>{{ $order->user->email }}</td>
                                        <th>Phone</th>
                                        <td>{{ $order->user->phone }}</td>
                                    </tr>
                                    <tr>
                                        <th>Order Status</th>
                                        <td colspan="5">
                                            @if ($order->status == 'confirmed')
                                                <span class="badge bg-warning">Confirmed</span>
                                            @elseif($order->status == 'preparing')
                                                <span class="badge bg-warning">Preparing</span>
                                            @elseif($order->status == 'delivering')
                                                <span class="badge bg-warning">Delivering</span>
                                            @elseif($order->status == 'delivered')
                                                <span class="badge bg-success">Delivered</span>
                                            @elseif($order->status == 'cancelled')
                                                <span class="badge bg-danger">Canceled</span>
                                            @endif
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div style="height: 20px"></div>
            <div class="wg-box">
                <div class="flex items-center justify-between gap10 flex-wrap mb-10">
                    <h5>Products Order</h5>
                    <div class="wg-filter flex-grow">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center">Image</th>
                                        <th class="text-center">name</th>
                                        <th class="text-center">Brand</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Quantity</th>
                                        <th class="text-center">UOM</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($order->cart->cartItems as $item)
                                        <tr>

                                            <td class="text-center">
                                                @if ($item->product->photo)
                                                    <img src="{{ asset('storage/' . $item->product->photo) }}"
                                                        alt="{{ $item->product->name }}" width="50" height="50">
                                                @else
                                                    N/A
                                                @endif
                                            </td>
                                            <td class="text-center">{{ $item->product->name }}</td>
                                            <td class="text-center">{{ $item->product->brand->name }}</td>
                                            <td class="text-center">${{ number_format($item->price, 2) }}</td>
                                            <td class="text-center">{{ $item->quantity }}</td>
                                            <td class="text-center">{{ $item->product->uom }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="wg-box mt-5">
                <h5>Shipping Address</h5>
                <div class="my-account__address-item col-md-6">
                    <div class="my-account__address-item__detail">
                        <p>{{ $order->address->province->name ?? 'N/A' }}</p>
                        <p>{{ $order->address->district->name ?? 'N/A' }}</p>
                        <p>{{ $order->address->commune->name ?? 'N/A' }}</p>
                        <p>{{ $order->address->village ?? 'N/A' }}</p>
                        <p>{{ $order->address->street ?? 'N/A' }}</p>
                        <p>
                            @if ($order->address->latitude && $order->address->longitude)
                                <a href="https://maps.google.com/?q={{ $order->address->latitude }},{{ $order->address->longitude }}"
                                    target="_blank">
                                    <p>Google Map</p>
                                </a>
                            @else
                                —
                            @endif
                        </p>
                        <br>
                        <p>Mobile : {{ $order->address->user->phone ?? 'N/A' }}</p>
                    </div>
                </div>
            </div>
            <div class="wg-box mt-5">
                <h5>Transactions</h5>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-transaction">
                        <tbody>
                            <tr>
                                <th>Subtotal</th>
                                <td>${{ $order->total_amount }}</td>
                                <th>Payment Mode</th>
                                <td>
                                    @if ($order->payment->paymentMethod->name == 'STRIPE')
                                        Online payment
                                    @else
                                        Cash payment
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <th>Total</th>
                                <td>${{ $order->total_amount }}</td>
                                <th>Status</th>
                                <td>
                                    @if ($order->payment && $order->payment->paymentMethod && $order->payment->paymentMethod->code === 'stripe')
                                        <span class="badge bg-success">Paid</span>
                                    @else
                                        {{-- For other payment methods --}}
                                        @if ($order->status == 'delivered')
                                            <span class="badge bg-success">Paid</span>
                                        @elseif ($order->status == 'cancelled')
                                            <span class="badge bg-danger">Canceled</span>
                                        @else
                                            <span class="badge bg-warning">Pending</span>
                                        @endif
                                    @endif
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection
