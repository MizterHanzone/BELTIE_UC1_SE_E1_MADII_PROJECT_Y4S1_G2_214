@extends('layouts.admin')
@section('title', 'Advertisement | Update')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Advertisement infomation</h3>
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
                        <a href="{{ route('advertisements.index') }}">
                            <div class="text-tiny">Advertisement</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <div class="text-tiny">Edit Advertisement</div>
                    </li>
                </ul>
            </div>
            <!-- new-category -->
            <div class="wg-box">
                <form class="form-new-product form-style-1" action="{{ route('advertisements.update', $advertisement->id) }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    @method('PUT')
                    <fieldset class="name">
                        <div class="body-title">Title <span class="tf-color-1">*</span></div>
                        <input class="flex-grow" type="text" placeholder="Title" name="title" tabindex="0"
                            value="{{ old('title', $advertisement->title) }}" aria-required="true" required="">
                    </fieldset>
                    @error('title')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset class="name">
                        <div class="body-title">Description <span class="tf-color-1">*</span></div>
                        <input class="flex-grow" type="text" placeholder="Description" name="description" tabindex="0"
                            value="{{ old('description', $advertisement->description) }}" aria-required="true" required="">
                    </fieldset>
                    @error('description')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset class="name">
                        <div class="body-title">Link <span class="tf-color-1">*</span></div>
                        <input class="flex-grow" type="text" placeholder="Link" name="link" tabindex="0"
                            value="{{ old('link', $advertisement->link) }}" aria-required="true" required="">
                    </fieldset>
                    @error('link')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset class="status">
                        <div class="body-title">Status <span class="tf-color-1">*</span></div>
                        <div class="flex-grow">
                            <select class="" name="status">
                                <option value="active" {{ old('status', $advertisement->status) == 'active' ? 'selected' : '' }}>Active</option>
                                <option value="inactive" {{ old('status', $advertisement->status) == 'inactive' ? 'selected' : '' }}>Inactive</option>
                            </select>
                        </div>
                    </fieldset>
                    @error('status')
                        <span class="alert danger-text text-center">{{ $message }}</span>
                    @enderror

                    <fieldset>
                        <div class="body-title">Upload images <span class="tf-color-1">*</span>
                        </div>
                        <div class="upload-image flex-grow">
                            <div class="item" id="imgpreview" style="{{ $advertisement->photo ? '' : 'display:none' }}">
                                <img src="{{ $advertisement->photo ? asset('storage/' . $advertisement->photo) : '' }}" class="effect8" alt="Current Image">
                            </div>
                            <div id="upload-file" class="item up-load">
                                <label class="uploadfile" for="myFile">
                                    <span class="icon">
                                        <i class="icon-upload-cloud"></i>
                                    </span>
                                    <span class="body-text">Drop your images here or select <span class="tf-color">click to
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
