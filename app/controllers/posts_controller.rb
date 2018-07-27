class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]	
  
  def new
     @post = Post.new
  end

  def index
     @posts = Post.all
  end

  def create
     @post = Post.new(post_params)
     if @post.save     
	flash[:notice] = "The post was created!"
        redirect_to @post
     else
	render 'new'
     end
  end     

  def show
  end

  def edit
  end

  def destroy
      @post.destroy 
      redirect_to root_path, notice: "Post destroyed"
  end

  def update
     if @post.update(post_params)
	redirect_to @post, notice: "The post was Updated!"
     else
	render 'edit'
     end
  end

private
  def post_params
	params.require(:post).permit(:title, :content, :category_id) 
  end

  def find_post
	@post = Post.find(params[:id])
  end

end
