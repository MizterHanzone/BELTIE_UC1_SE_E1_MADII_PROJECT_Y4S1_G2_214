@extends('layouts.admin')
@section('title', 'Product | Create')
@section('content')
    <div class="main-content-inner">
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                <h3>Product infomation</h3>
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
                        <div class="text-tiny">New Product</div>
                    </li>
                </ul>
            </div>
            <!-- new-category -->
            <div class="wg-box">
                <form class="tf-section-2 form-add-product1" action="{{ route('products.store') }}" method="POST"
                    enctype="multipart/form-data">
                    @csrf
                    <div class="wg-box">
                        <fieldset class="category">
                            <div class="body-title mb-10">Category <span class="tf-color-1">*</span></div>
                            <div class="select">
                                <select class="" name="category_id">
                                    @foreach ($categories as $category)
                                        <option value="{{$category->id}}">{{$category->name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </fieldset>
                        @error('category_id') <span class="alert danger-text text-center">{{$message}}</span> @enderror
                        <fieldset class="category">
                            <div class="body-title mb-10">Brand <span class="tf-color-1">*</span></div>
                            <div class="select">
                                <select class="" name="brand_id">
                                    @foreach ($brands as $brand)
                                        <option value="{{$brand->id}}">{{$brand->name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </fieldset>
                        @error('brand_id') <span class="alert danger-text text-center">{{$message}}</span> @enderror
                        <fieldset class="name">
                            <div class="body-title">Name <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="text" placeholder="Name" name="name" tabindex="0"
                                value="{{ old('name') }}" aria-required="true" required="">
                        </fieldset>
                        @error('name')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror

                        <fieldset class="name">
                            <div class="body-title">Description <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="text" placeholder="Description" name="description"
                                tabindex="0" value="{{ old('description') }}" aria-required="true" required="">
                        </fieldset>
                        @error('description')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="wg-box">
                        <fieldset class="name">
                            <div class="body-title">Price <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="number" step="0.01" placeholder="Price" name="price"
                                tabindex="0" value="{{ old('price') }}" aria-required="true" required="">
                        </fieldset>
                        @error('price')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror

                        <fieldset class="name">
                            <div class="body-title">Quantity <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="number" placeholder="Quantity" name="quantity"
                                tabindex="0" value="{{ old('quantity') }}" aria-required="true" required="">
                        </fieldset>
                        @error('quantity')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                        <fieldset class="name">
                            <div class="body-title">UOM <span class="tf-color-1">*</span></div>
                            <input class="flex-grow" type="text" placeholder="UOM" name="uom"
                                tabindex="0" value="{{ old('uom') }}" aria-required="true" required="">
                        </fieldset>
                        @error('uom')
                            <span class="alert danger-text text-center">{{ $message }}</span>
                        @enderror
                        <fieldset>
                            <div class="body-title">Upload images <span class="tf-color-1">*</span>
                            </div>
                            <div class="upload-image flex-grow">
                                <div class="item" id="imgpreview" style="display:none">
                                    <img src="upload-1.html" class="effect8" alt="">
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
                    </div>
                    <div class="bot">
                        <div></div>
                        <button class="tf-button w208" type="submit">Add</button>
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
