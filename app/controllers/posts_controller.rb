class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]	
  
  def new
     @post = Post.new
  end

  def index
     if params[:category].blank?	  
	  @posts = Post.all.order("created_at DESC")
     else 
	  @category_id = Category.find_by(name: params[:category]).id
	  @posts = Post.where(category_id: @category_id).order("created_at DESC")
     end
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
