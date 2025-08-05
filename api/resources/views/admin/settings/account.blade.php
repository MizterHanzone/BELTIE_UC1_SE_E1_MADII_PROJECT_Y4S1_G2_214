@extends('layouts.admin')
@section('title', 'Product')
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
                            @if (@Session::has('status'))
                                <p class="alert alert-success">{{ Session::get('status') }}</p>
                            @endif
                            <form name="account_edit_form" action="#" method="GET"
                                class="form-new-product form-style-1 needs-validation" novalidate>

                                {{-- Photo --}}
                                <fieldset>
                                    <div class="body-title">Photo <span class="tf-color-1">*</span></div>
                                    <div class="upload-image flex-grow">
                                        @if ($user->photo)
                                            <div class="item" id="imgpreview" style="display:block">
                                                <img src="{{ asset('storage/' . $user->photo) }}" class="effect8"
                                                    alt="">
                                            </div>
                                        @else
                                            <div class="item" id="imgpreview" style="display:none">
                                                <img src="" class="effect8" alt="">
                                            </div>
                                        @endif
                                    </div>
                                </fieldset>

                                {{-- First Name --}}
                                <fieldset class="name">
                                    <div class="body-title">First Name <span class="tf-color-1">*</span></div>
                                    <input class="flex-grow" type="text" placeholder="First Name" name="first_name"
                                        value="{{ old('first_name', $user->first_name) }}" required>
                                </fieldset>

                                {{-- Last Name --}}
                                <fieldset class="name">
                                    <div class="body-title">Last Name <span class="tf-color-1">*</span></div>
                                    <input class="flex-grow" type="text" placeholder="Last Name" name="last_name"
                                        value="{{ old('last_name', $user->last_name) }}" required>
                                </fieldset>

                                {{-- Email --}}
                                <fieldset class="name">
                                    <div class="body-title">Email <span class="tf-color-1">*</span></div>
                                    <input class="flex-grow" type="email" placeholder="Email" name="email"
                                        value="{{ old('email', $user->email) }}" required>
                                </fieldset>

                                {{-- Mobile Number --}}
                                <fieldset class="name">
                                    <div class="body-title">Mobile Number <span class="tf-color-1">*</span></div>
                                    <input class="flex-grow" type="text" placeholder="Mobile Number" name="phone"
                                        value="{{ old('phone', $user->phone) }}" required>
                                </fieldset>
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
