class FriendshipsController < ApplicationController

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(friend_id: friend.id, user_id: current_user.id).first
    friendship.destroy
    flash[:notice] = "#{friend.first_name} #{friend.last_name} was successfully removed from friend"
    redirect_to my_friends_path
    end

end
