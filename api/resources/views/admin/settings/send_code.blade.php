@extends('layouts.admin')
@section('title', 'Change Password')
@section('content')

    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Settings</h3>
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
                        <div class="text-tiny">Settings</div>
                    </li>
                </ul>
            </div>

            <div class="wg-box">
                <div class="col-lg-12">
                    <div class="page-content my-account__edit">
                        <div class="my-account__edit-form">
                            <form action="{{ route('admin.send_code') }}" method="POST"
                                class="form-new-product form-style-1 needs-validation" novalidate>
                                @csrf

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="my-3">
                                            <h5 class="text-uppercase mb-0">Password Change</h5>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <fieldset class="name">
                                            <div class="body-title pb-3">Enter email <span class="tf-color-1">*</span>
                                            </div>
                                            <input class="flex-grow" type="email" placeholder="Enter email"
                                                id="email" name="email" required>
                                            @error('email')
                                                <div class="text-danger">{{ $message }}</div>
                                            @enderror
                                        </fieldset>
                                    </div>

                                    {{-- Submit Button --}}
                                    <div class="col-md-12">
                                        <div class="my-3">
                                            <button type="submit" class="btn btn-primary tf-button w208">Send</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
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
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.querySelector('.category-select');
            const statusSelect = document.querySelector('.status-select');

            function handleFilterChange(selectElement) {
                const form = selectElement.closest('form');
                form.submit();
            }

            if (categorySelect) {
                categorySelect.addEventListener('change', function() {
                    handleFilterChange(this);
                });
            }

            if (statusSelect) {
                statusSelect.addEventListener('change', function() {
                    handleFilterChange(this);
                });
            }
        });
    </script>

    <script>
        $(document).ready(function() {
            $('.delete').on('click', function(e) {
                e.preventDefault();
                const form = $(this).closest('form');

                swal({
                    title: 'Are you sure?',
                    text: 'Once deleted, you will not be able to recover this product!',
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
@endpush
