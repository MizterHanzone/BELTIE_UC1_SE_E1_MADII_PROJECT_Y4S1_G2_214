@extends('layouts.admin')
@section('title', 'Advertise')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Advertisement</h3>
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
                        <div class="text-tiny">Advertise</div>
                    </li>
                </ul>
            </div>

            <div class="wg-box">
                <div class="flex items-center justify-between gap10 flex-wrap">
                    <div class="wg-filter flex-grow">
                        <form class="form-search" method="GET" action="">
                            <fieldset class="search">
                                <input type="text" placeholder="Search by name or description..." name="search"
                                    value="{{ request('search') }}">
                            </fieldset>
                            <div class="button-submit">
                                <button type="submit"><i class="icon-search"></i></button>
                            </div>
                        </form>
                    </div>
                    <a class="tf-button style-1 w208" href="{{ route('advertisements.index') }}">
                        Clear
                    </a>
                    <a class="tf-button style-1 w208" href="{{route('advertisements.create')}}">
                        <i class="icon-plus"></i> Add new
                    </a>
                </div>
                <div class="wg-table table-all-user">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                        @if (@Session::has('status'))
                            <p class="alert alert-success">{{Session::get('status')}}</p>
                        @endif
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($advertisements as $advertisement)
                                    <tr>
                                        <td>
                                            @if ($advertisements instanceof \Illuminate\Pagination\LengthAwarePaginator || $advertisements instanceof \Illuminate\Pagination\Paginator)
                                                {{ ($advertisements->currentPage() - 1) * $advertisements->perPage() + $loop->iteration }}
                                            @else
                                                {{ $loop->iteration }}
                                            @endif
                                        </td>
                                        <td>
                                            @if ($advertisement->photo)
                                                <img src="{{ asset('storage/' . $advertisement->photo) }}" alt="{{ $advertisement->name }}" width="50" height="50">
                                            @else
                                                N/A
                                            @endif
                                        </td>
                                        <td>{{ $advertisement->title }}</td>
                                        <td>{{ $advertisement->description }}</td>
                                        <td>{{ ucfirst($advertisement->status) }}</td>
                                        <td>
                                            <div class="list-icon-function">
                                                <a href="{{ route('advertisements.edit', $advertisement->id) }}">
                                                    <div class="item edit">
                                                        <i class="icon-edit-3"></i>
                                                    </div>
                                                </a>
                                                <form action="{{ route('advertisements.destroy', $advertisement->id) }}" method="POST" class="d-inline delete-form">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="submit" class="item text-danger delete" style="border: none; background: none;">
                                                        <i class="icon-trash-2"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="7" class="text-center">No advertisement found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="divider"></div>
                    @if ($advertisements instanceof \Illuminate\Pagination\LengthAwarePaginator || $advertisements instanceof \Illuminate\Pagination\Paginator)
                        <div class="flex items-center justify-between flex-wrap gap10 wgp-pagination">
                            {{ $advertisements->links('pagination::bootstrap-5') }}
                        </div>
                    @endif
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
