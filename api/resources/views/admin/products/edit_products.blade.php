@extends('layouts.admin')
@section('title', 'Product | Edit')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Edit Product</h3>
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
                        <a href="{{ route('products.index') }}">
                            <div class="text-tiny">Products</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <div class="text-tiny">Edit Product</div>
                    </li>
                </ul>
            </div>
            <!-- new-category -->
            <div class="wg-box">
                <form class="tf-section-2 form-add-product1" action="{{ route('products.update', $product->id) }}"
                    method="POST" enctype="multipart/form-data">
                    @csrf
                    @method('PUT')
                    <input type="hidden" name="id" value="{{ $product->id }}" autocomplete="">
                    <div class="wg-box">
                        <fieldset class="category">
                            <div class="body-title mb-10">Category <span class="tf-color-1">*</span></div>
                            <div class="select">
                                <select class="" name="category_id">
                                    @foreach ($categories as $category)
                                        <option value="{{ $category->id }}"
                                            {{ $category->id == $product->category_id ? 'selected' : '' }}>
                                            {{ $category->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </fieldset>
                        @error('category_id')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                        <fieldset class="brand">
                            <div class="body-title mb-10">Brand <span class="tf-color-1">*</span></div>
                            <div class="select">
                                <select class="" name="brand_id">
                                    @foreach ($brands as $brand)
                                        <option value="{{ $brand->id }}"
                                            {{ $brand->id == $product->brand_id ? 'selected' : '' }}>
                                            {{ $brand->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </fieldset>
                        @error('brand_id')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                        <fieldset class="name">
                            <div class="body-title mb-10">Name <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="text" placeholder="Name" name="name" tabindex="0"
                                value="{{ old('name', $product->name) }}" aria-required="true" required="">
                        </fieldset>
                        @error('name')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror

                        <fieldset class="name">
                            <div class="body-title mb-10">Description <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="text" placeholder="Description" name="description"
                                tabindex="0" value="{{ old('description', $product->description) }}" aria-required="true"
                                required="">
                        </fieldset>
                        @error('description')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="wg-box">
                        <fieldset class="name">
                            <div class="body-title mb-10">Status <span class="tf-color-1">*</span></div>
                            <select class="flex-grow" name="is_active" tabindex="0" required="">
                                <option value="1" {{ old('is_active', $product->is_active) == 1 ? 'selected' : '' }}>
                                    Active</option>
                                <option value="0" {{ old('is_active', $product->is_active) == 0 ? 'selected' : '' }}>
                                    Inactive</option>
                            </select>
                        </fieldset>
                        @error('is_active')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                        <fieldset class="name">
                            <div class="body-title mb-10">Price <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="number" placeholder="Price" name="price" tabindex="0"
                                value="{{ old('price', $product->price) }}" aria-required="true" required="">
                        </fieldset>
                        @error('price')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror

                        <fieldset>
                            <div class="body-title">Upload images <span class="tf-color-1">*</span>
                            </div>
                            <div class="upload-image flex-grow">
                                <div class="item" id="imgpreview">
                                    <img src="{{ asset('storage/' . $product->photo) }}" class="effect8" alt=""
                                        style="display:block">
                                </div>
                                <div id="upload-file" class="item up-load">
                                    <label class="uploadfile" for="myFile">
                                        <span class="icon">
                                            <i class="icon-upload-cloud"></i>
                                        </span>
                                        <span class="body-text">Drop your images here or select <span
                                                class="tf-color">click to
                                                browse</span></span>
                                        <input type="file" id="myFile" name="photo" accept="image/*">
                                    </label>
                                </div>
                            </div>
                        </fieldset>
                        @error('photo')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                    </div>
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
