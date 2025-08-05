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
                        <div class="text-tiny">Update password</div>
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
                            <form action="{{ route('admin.verify_code.update_password') }}" method="POST"
                                class="form-new-product form-style-1 needs-validation" novalidate>
                                @csrf

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="my-12">
                                            <h5 class="text-uppercase mb-0" style="white-space: nowrap;">Verify Code & Change Password</h5>
                                        </div>
                                    </div>

                                    {{-- Verification Code --}}
                                    <div class="col-md-12">
                                        <fieldset class="name">
                                            <div class="body-title pb-3">Verification Code <span class="tf-color-1">*</span>
                                            </div>
                                            <input type="text" name="code" placeholder="Enter 6-digit code" required>
                                            @error('code')
                                                <div class="text-danger">{{ $message }}</div>
                                            @enderror
                                        </fieldset>
                                    </div>

                                    {{-- New Password --}}
                                    <div class="col-md-12">
                                        <fieldset class="name">
                                            <div class="body-title pb-3">New Password <span class="tf-color-1">*</span>
                                            </div>
                                            <input type="password" name="new_password" placeholder="New password" required>
                                            @error('new_password')
                                                <div class="text-danger">{{ $message }}</div>
                                            @enderror
                                        </fieldset>
                                    </div>

                                    {{-- Confirm New Password --}}
                                    <div class="col-md-12">
                                        <fieldset class="name">
                                            <div class="body-title pb-3">Confirm New Password <span
                                                    class="tf-color-1">*</span></div>
                                            <input type="password" name="new_password_confirmation"
                                                placeholder="Confirm new password" required>
                                        </fieldset>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="my-3">
                                            <button type="submit" class="btn btn-success tf-button w208">Update
                                                Password</button>
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
