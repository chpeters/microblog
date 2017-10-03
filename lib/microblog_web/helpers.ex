defmodule MicroblogWeb.Helpers do
	def username_from_user_id(id) do
		Microblog.Accounts.get_user!(id).username
	end
end