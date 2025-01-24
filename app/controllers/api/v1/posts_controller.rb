# rails g controller Api::V1::Posts: ApiディレクトリのV1ディレクトリにPostsコントローラーを作成

class Api::V1::PostsController < ApplicationController
  # リソースすべてを一覧表示
  def index
    # @posts: postsに対して、何か操作を加えるときに@を付けて、インスタンス変数とする
    # Post: modelの名前
    @posts = Post.all
    # render: Railsのレスポンスをクライアント側に返す
    # json: JSON形式に変更(apiが絡むときは、JSONに直す)
    render json: @posts
  end

  # 特定のリソースを詳細表示
  def show
    # params[:id]: GET /posts/5 のリクエストが送られた場合、params[:id] は 5
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :umprocessable_entity # 422(バリデーションエラー)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private
  def post_params
    # require(:post): この post は model 名が由来(Postモデル)
    params.require(:post).permit(:title, :content)
  end
end