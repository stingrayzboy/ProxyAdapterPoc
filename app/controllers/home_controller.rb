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
    blogs = JSON.parse params["blogs"].to_json
    blogs.map! do |blog|
      Blog.new blog
    end
    Blog.load_schema
    result = Blog.import  blogs
    render json: result.to_json
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

end
