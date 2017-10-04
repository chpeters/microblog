defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  alias Microblog.Social

  def index(conn, _params) do
  	user_id = get_session(conn, :user_id)
  	if user_id do
      follows = Social.list_follows_by_follower_id(user_id)
      followed_ids = Enum.map(follows, fn(follow) -> follow.followee_id end)
      ids = [user_id | followed_ids]
  		messages = Social.list_messages_by_user_ids(ids)
  		render(conn, "index.html", messages: messages)
  	else 
    	render conn, "index.html", messages: nil
  	end
  end
end
