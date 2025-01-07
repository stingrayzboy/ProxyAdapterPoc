class HomeController < ApplicationController
  def index
    Blog.load_schema
    @blogs = Blog.all
    render json: @blogs
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      render json: @blog
    else
      render json: @blog.errors
    end
  end

  def bulk_create
    #get a array of blogs
    # use activerecord import
    blogs = params["blogs"].to_json
    Blog.load_schema
    p blogs
    result = Blog.import JSON.parse blogs
    render json: result.to_json
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

end
