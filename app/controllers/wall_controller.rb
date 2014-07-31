class WallController < ApplicationController

  def index
  	@user = User.find(current_user.id)
	@posts = Post.all.order("created_at DESC")
  end

  def post
  	post = Post.new(post_params)
	post.save
	new_post_id = Post.where("user_id = #{post_params[:user_id]}").last.id
	json_message = {:status => 'success', :message => post_params, :post_id => new_post_id}
  	render json: json_message
	# redirect_to wall_index_path
  end

  def comment
  	comment = Comment.new(comment_params)
	comment.save
	json_message = {:status => 'success', :message => comment_params}
  	render json: json_message
	# redirect_to wall_index_path
  end

  private
	def post_params
	  	params.require(:post).permit(:content, :user_id)
	end

	def comment_params
	  	params.require(:comment).permit(:content, :post_id, :user_id)
	end
end
