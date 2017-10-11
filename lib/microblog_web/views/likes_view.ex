defmodule MicroblogWeb.LikesView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikesView

  def render("index.json", %{likes: likes}) do
    if likes do
      %{data: render_one(likes, LikesView, "likes.json")}
    else
      %{}
    end
  end

  def render("show.json", %{likes: likes}) do
    %{data: render_one(likes, LikesView, "likes.json")}
  end

  def render("likes.json", %{likes: likes}) do
    %{id: likes.id, message_id: likes.message_id, user_id: likes.user_id}
  end
end
