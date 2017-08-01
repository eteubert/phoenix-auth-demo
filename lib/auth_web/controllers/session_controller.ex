defmodule AuthWeb.SessionController do
  use AuthWeb, :controller

  alias Auth.Repo
  alias Auth.Account
  alias Auth.Account.User

  def new(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    user = Account.get_user_by_email! params["email"]
    valid = Comeonin.Argon2.checkpw(params["plain_password"], user.password)

    if valid do
      conn
      |> put_flash(:info, "Login!")
      |> redirect(to: "/")
    else
      render conn, "index.html"
    end
  end
end
