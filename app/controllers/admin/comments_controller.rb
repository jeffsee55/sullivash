class Admin::CommentsController < AdminController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to admin_comments_path, notice: "Comment was successfully created"
    else
      render :new, notice: "Your comment was not created"
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :description)
  end

end
