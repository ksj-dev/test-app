class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, { :only => [:edit, :update, :destroy] }
  
  def index
    @posts = Post.all.order(:created_at => :desc)
    @animedb = Animedb.all
  end

  def ranking
    @posts = Post.all.order(:created_at => :desc)
    @animedb = Animedb.all
  end

  def likes_ranking
    @arr = [] 
    @posts = Post.all.order(:created_at => :desc)
    
    @posts.each do |post|
      @arr.push(post)
    end
    @arr.sort
      
    @animedb = Animedb.all

    
  end
  
  def show
    @post = Post.find_by(:id => params[:id])
    @user = @post.user
    @likes_count = Like.where(:post_id => @post.id).count
    @animedb = Animedb.find_by(:sora_id => @post.sora_id)
  end
  
  def new
    @post = Post.new
    @animedb = Animedb.find_by(:sora_id => params[:sora_id])
  end
  
  def create
    @post = Post.new(
      :content => params[:content],
      :user_id => @current_user.id,
      :sora_id => params[:sora_id],
      :review_point => params[:review_point].to_i
    )
    
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      #render("posts/new")
      #render :partial => "posts/new.html.erb",:locals =>{:sora_id => "5"}
      # render引数の渡し方がわからない！！
      #render :partial => "posts/new", :locals => { :sora_id => 6 }
    end
  end
  
  def edit
    @post = Post.find_by(:id => params[:id])
  end
  
  def update
    @post = Post.find_by(:id => params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(:id => params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(:id => params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
