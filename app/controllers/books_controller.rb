class BooksController < ApplicationController

  def new
    #Viewに渡すインスタンス変数に空のmodelオブジェクトを生成する。
    @list = List.new
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      flash[:notice] = "successfully"
      render :edit
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @error_message = [:alert]
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    @book.update(books_params)
    if @book.save
      flash[:notice] = "successfully"
    redirect_to @book
    else
    @books = Book.all
    flash.now[:alert] ="更新に失敗しました。"
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

 private
  # ストロングパラメータ
  def books_params
   params.require(:book).permit(:title, :body)
  end
end
