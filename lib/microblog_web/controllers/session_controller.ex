# Modified from Prof. Tuck's Session Controller lesson

defmodule MicroblogWeb.SessionController do
	use MicroblogWeb, :controller

  alias Microblog.Accounts

  def login(conn, %{"username" => username}) do 
  	user = Accounts.get_user_by_username(username)

  	if user do
  		conn
  		|> put_session(:user_id, user.id)
  		|> put_flash(:info, "Logged in as #{user.username}")
  		|> redirect(to: user_path(conn, :show, user.id))
  	else
  		conn
  		|> put_session(:user_id, nil)
      |> put_flash(:error, "Username doesn't exist")
      |> redirect(to: user_path(conn, :index))
  	end
  end

  def logout(conn, _params) do 
  	conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end