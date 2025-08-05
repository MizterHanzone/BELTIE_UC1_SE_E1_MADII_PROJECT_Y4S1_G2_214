@extends('layouts.admin')
@section('title', 'Addresses')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Addresses</h3>
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
                        <div class="text-tiny">Addresses</div>
                    </li>
                </ul>
            </div>

            <div class="wg-box">
                <div class="flex items-center justify-between gap10 flex-wrap">
                    {{-- Search by name --}}
                    <div class="wg-filter flex-grow">
                        <form class="form-search" method="GET" action="">
                            <fieldset class="search">
                                <input type="text" placeholder="Search by name..." name="search"
                                    value="{{ request('search') }}">
                            </fieldset>
                            <div class="button-submit">
                                <button type="submit"><i class="icon-search"></i></button>
                            </div>
                        </form>
                    </div>

                    {{-- Province filter --}}
                    <div class="wg-filter flex-grow">
                        <form class="form-search" method="GET" action="">
                            <fieldset class="category">
                                <div class="select">
                                    <select class="category-select" name="province_id" onchange="this.form.submit()">
                                        <option value="">All Provinces</option>
                                        @foreach ($provinces as $province)
                                            <option value="{{ $province->id }}"
                                                {{ request('province_id') == $province->id ? 'selected' : '' }}>
                                                {{ $province->name }}
                                            </option>
                                        @endforeach
                                    </select>
                                    {{-- Preserve other filters --}}
                                    <input type="hidden" name="search" value="{{ request('search') }}">
                                    <input type="hidden" name="district_id" value="{{ request('district_id') }}">
                                    <input type="hidden" name="commune_id" value="{{ request('commune_id') }}">
                                </div>
                            </fieldset>
                        </form>
                    </div>

                    {{-- District filter --}}
                    <div class="wg-filter flex-grow">
                        <form class="form-search" method="GET" action="">
                            <fieldset class="category">
                                <div class="select">
                                    <select class="category-select" name="district_id" onchange="this.form.submit()">
                                        <option value="">All Districts</option>
                                        @foreach ($districts as $district)
                                            @if (!request('province_id') || $district->province_id == request('province_id'))
                                                <option value="{{ $district->id }}"
                                                    {{ request('district_id') == $district->id ? 'selected' : '' }}>
                                                    {{ $district->name }}
                                                </option>
                                            @endif
                                        @endforeach
                                    </select>
                                    {{-- Preserve other filters --}}
                                    <input type="hidden" name="search" value="{{ request('search') }}">
                                    <input type="hidden" name="province_id" value="{{ request('province_id') }}">
                                    <input type="hidden" name="commune_id" value="{{ request('commune_id') }}">
                                </div>
                            </fieldset>
                        </form>
                    </div>

                    {{-- Commune filter --}}
                    <div class="wg-filter flex-grow">
                        <form class="form-search" method="GET" action="">
                            <fieldset class="category">
                                <div class="select">
                                    <select class="category-select" name="commune_id" onchange="this.form.submit()">
                                        <option value="">All Communes</option>
                                        @foreach ($communes as $commune)
                                            @if (!request('district_id') || $commune->district_id == request('district_id'))
                                                <option value="{{ $commune->id }}"
                                                    {{ request('commune_id') == $commune->id ? 'selected' : '' }}>
                                                    {{ $commune->name }}
                                                </option>
                                            @endif
                                        @endforeach
                                    </select>
                                    {{-- Preserve other filters --}}
                                    <input type="hidden" name="search" value="{{ request('search') }}">
                                    <input type="hidden" name="province_id" value="{{ request('province_id') }}">
                                    <input type="hidden" name="district_id" value="{{ request('district_id') }}">
                                </div>
                            </fieldset>
                        </form>
                    </div>

                    {{-- Clear button --}}
                    <a class="tf-button style-1 w208" href="{{ route('addresses.index') }}">
                        Clear
                    </a>
                </div>

                <div class="wg-box">
                    <div class="wg-table table-all-user">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                @if (Session::has('status'))
                                    <p class="alert alert-success">{{ Session::get('status') }}</p>
                                @endif
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>User</th>
                                        <th>Province</th>
                                        <th>District</th>
                                        <th>Commune</th>
                                        <th>Village</th>
                                        <th>Street</th>
                                        <th>House No.</th>
                                        <th>Map</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($addresses as $address)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ $address->user->first_name . ' ' . $address->user->last_name ?? 'N/A' }}
                                            </td>
                                            <td>{{ $address->province->name ?? '—' }}</td>
                                            <td>{{ $address->district->name ?? '—' }}</td>
                                            <td>{{ $address->commune->name ?? '—' }}</td>
                                            <td>{{ $address->village ?? '—' }}</td>
                                            <td>{{ $address->street ?? '—' }}</td>
                                            <td>{{ $address->house_number ?? '—' }}</td>
                                            <td>
                                                @if ($address->latitude && $address->longitude)
                                                    <a href="https://maps.google.com/?q={{ $address->latitude }},{{ $address->longitude }}"
                                                        target="_blank">
                                                        <p>Map</p>
                                                    </a>
                                                @else
                                                    —
                                                @endif
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="11" class="text-center">No addresses found.</td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        <div class="divider"></div>
                        <div class="flex items-center justify-between flex-wrap gap10 wgp-pagination">
                            {{ $addresses->links('pagination::bootstrap-5') }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    {{-- SweetAlert CDN --}}
    <script src="https://cdn.jsdelivr.net/npm/sweetalert"></script>

    <script>
        $(document).ready(function() {
            $('.delete').on('click', function(e) {
                e.preventDefault();
                const form = $(this).closest('form');

                swal({
                    title: 'Are you sure?',
                    text: 'Once deleted, you will not be able to recover this category!',
                    icon: 'warning',
                    buttons: ['Cancel', 'Yes, delete it!'],
                    dangerMode: true,
                }).then(function(willDelete) {
                    if (willDelete) {
                        form.submit();
                    }
                });
            });
        });
    </script>
@endpush
