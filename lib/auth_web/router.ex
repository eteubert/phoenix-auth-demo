defmodule AuthWeb.Router do
  use AuthWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Auth.AuthAccessPipeline
    plug Auth.Plug.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthWeb do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index

    resources "/users", UserController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :destroy

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuthWeb do
  #   pipe_through :api
  # end
end
