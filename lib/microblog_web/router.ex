defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  import MicroblogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

   pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MicroblogWeb do
    pipe_through :browser # Use the default browser stack

    resources "/messages", MessageController
    resources "/users", UserController
    resources "/follows", FollowController
    resources "/likes", LikesController, except: [:new, :edit]

    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
    
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MicroblogWeb do
  #   pipe_through :api
  # end
end
