@extends('layouts.admin')
@section('title', 'Payment Method | Edit')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Payment Method Information</h3>
                <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                    <li><a href="{{ route('admin.index') }}">
                            <div class="text-tiny">Dashboard</div>
                        </a></li>
                    <li><i class="icon-chevron-right"></i></li>
                    <li><a href="{{ route('payment_methods.index') }}">
                            <div class="text-tiny">Payment Methods</div>
                        </a></li>
                    <li><i class="icon-chevron-right"></i></li>
                    <li>
                        <div class="text-tiny">Edit Payment Method</div>
                    </li>
                </ul>
            </div>

            <div class="wg-box">
                <form class="form-new-product form-style-1"
                    action="{{ route('payment_methods.update', ['payment_method' => $payment_method->id]) }}" method="POST"
                    enctype="multipart/form-data">
                    @csrf
                    @method('PUT')

                    <fieldset class="name">
                        <div class="body-title">Name <span class="tf-color-1">*</span></div>
                        <input class="flex-grow" type="text" name="name" placeholder="Name"
                            value="{{ old('name', $payment_method->name) }}" required>
                    </fieldset>
                    @error('name')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset class="name">
                        <div class="body-title">Code</div>
                        <input class="flex-grow" type="text" name="code" placeholder="Code"
                            value="{{ old('code', $payment_method->code) }}">
                    </fieldset>
                    @error('code')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset class="status">
                        <div class="body-title">Status <span class="tf-color-1">*</span></div>
                        <div class="flex-grow">
                            <select class="" name="status">
                                <option value="active"
                                    {{ old('status', $payment_method->is_active) == true ? 'selected' : '' }}>Active
                                </option>
                                <option value="inactive"
                                    {{ old('status', $payment_method->is_active) == false ? 'selected' : '' }}>Inactive
                                </option>
                            </select>
                        </div>
                    </fieldset>
                    @error('is_active')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset>
                        <div class="body-title">Upload Image</div>
                        <div class="upload-image flex-grow">
                            <div class="item" id="imgpreview">
                                @if ($payment_method->photo)
                                    <img src="{{ asset('storage/' . $payment_method->photo) }}" class="effect8"
                                        alt="{{ $payment_method->name }}">
                                @endif
                            </div>
                            <div id="upload-file" class="item up-load">
                                <label class="uploadfile" for="myFile">
                                    <span class="icon"><i class="icon-upload-cloud"></i></span>
                                    <span class="body-text">Drop your image here or <span class="tf-color">click to
                                            browse</span></span>
                                    <input type="file" id="myFile" name="photo" accept="image/*">
                                </label>
                            </div>
                        </div>
                    </fieldset>
                    @error('photo')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <div class="bot">
                        <div></div>
                        <button class="tf-button w208" type="submit">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        $(function() {
            $("#myFile").on("change", function() {
                const [file] = this.files;
                if (file) {
                    $("#imgpreview img").attr('src', URL.createObjectURL(file));
                    $("#imgpreview").show();
                }
            });
        });
    </script>
@endpush
