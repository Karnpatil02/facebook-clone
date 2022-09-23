module UsersHelper
  def its_me?(user)
    user == current_user
  end
  
  def pending_for_accept_my_request(user)
    friendship1 = @friendships.map { |friendship| friendship.friend if !friendship.status }.compact
    friendship1.include?(user)
  end

  def pending_for_me_to_accept(user)
    friendship_2 = @inverse_friendships.map { |friendship| friendship.user if !friendship.status }.compact
    friendship_2.include?(user)
  end

  def we_are_friends(user)
    friends_list = @friendships.map { |friendship| friendship.friend if friendship.status }
    friends_list += @inverse_friendships.map { |friendship| friendship.user if friendship.status }
    friends_list.compact
    friends_list.include?(user)
  end

  def finding_friendship_id(user)
    Friendship.find_by(user_id: current_user.id, friend_id: user.id) ||
      Friendship.find_by(user_id: user.id, friend_id: current_user.id)
  end

  def list_pending_friends(user)
    friendship_2 = @inverse_friendships.map { |friendship| friendship.user if !friendship.status }.compact
    friendship_2
  end
end
