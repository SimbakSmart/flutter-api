<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    //http://localhost:8000/api/categories
    public function index()
    {
        return CategoryResource::collection(Category::select('id','name')->get());
    }

    /**
     * Store a newly created resource in storage.
     */

    //  http://localhost:8000/api/categories
    //  {

    //     "name": "Second"
    // }
    // public function store(StoreCategoryRequest $request)
    // {
    //    $category = auth()->user()->categories()->create($request->validated());

    //     //   $category = Category::create($request->validated()+['user_id'=>auth()->id()]);

    //     return new CategoryResource($category);
    // }

      public function store(StoreCategoryRequest $request)
    {
      return new CategoryResource(Category::create($request->validated()));
    }

    /**
     * Display the specified resource.
     */
    //http://localhost:8000/api/categories/1
    public function show($id)
    {
           $category = Category::find($id);

           if(!$category){
             abort(404,'Category Not Found');
           }

        return new CategoryResource($category);
    }

    /**
     * Update the specified resource in storage.
     */
    //http://localhost:8000/api/categories/1
    public function update(StoreCategoryRequest $request, Category $category)
    {
        $category->update($request->validated());

        return new CategoryResource($category);
    }

    /**
     * Remove the specified resource from storage.
     */
    // http://localhost:8000/api/categories/1
    public function destroy(Category $category)
    {
         $category->delete();

         return response()->noContent();
    }
}
