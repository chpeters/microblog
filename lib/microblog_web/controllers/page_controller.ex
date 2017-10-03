defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  def index(conn, _params) do
  	user_id = get_session(conn, :user_id)
  	if user_id do
  		messages = Microblog.Social.list_messages()
  		render(conn, "index.html", messages: messages)
  	else 
    	render conn, "index.html", messages: nil
  	end
  end
end
