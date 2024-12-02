class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id]) 
        @comment = @post.comments.new(comment_params)
        if @comment.save
            redirect_to @post
        else
            redirect_to @post
        end
    end

    def set_comment
        @comment = Comment.find(params[:post])
    end

    def comment_params
        params.require(:comment).permit(:commenter, :body, :post)
    end
end
