class Api::BlogsController < ApplicationController
  def index
    # Blog.all の Blog は、model 名
    blogs = Blog.all
    # render でクライアント側にレスを返す
    # json: でJSON形式に変換
    render json: blogs
  end
  
  def show
    # params[:id]で、URLのid部分を取り出す
    blog = Blog.find(params[:id])
    render json: blog
  end

  def create
    # blog_params はストロングパラメーターとして、許可された属性のみを受け取る（コード下部で定義）
    blog = Blog.new(blog_params)
    if blog.save
      # status: -> ステータスコードを定義(201, 422: リクエストは受理したが、処理が不可)
      render json: blog, status: :created
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  def update
    blog = Blog.find(params[:id])
    if blog.update(blog_params)
      # 200: リクエストが正常に処理され、適切なレスポンスが返された
      render json: blog, status: :ok
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
  end

  # ストロングパラメーターのメソッド（blog_params）は private 以下に書く
  private
  def blog_params
    # params -> クライアントからのリクエストが入ったオブジェクト
    # require の引数には、リクエストのキーを入れる(デフォルトでは、モデル名)
    # permit の引数には、サーバー側で利用するリクエストのデータを指定
    params.require(:blog).permit(:title, :author, :content)
  end
end