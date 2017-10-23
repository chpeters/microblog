defmodule MicroblogWeb.MessageView do
  use MicroblogWeb, :view

  def markdown(body) do
  	body
  	|> Earmark.as_html!
  	|> raw
	end
end
