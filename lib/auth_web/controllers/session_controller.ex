defmodule AuthWeb.SessionController do
  use AuthWeb, :controller

  alias Auth.Account

  def new(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    user = Account.get_user_by_email! params["email"]
    valid = Comeonin.Argon2.checkpw(params["plain_password"], user.password)

    if valid do
      conn
      |> Auth.Guardian.Plug.sign_in(user)
      |> put_flash(:info, "Login!")
      |> redirect(to: "/")
    else
      render conn, "index.html"
    end
  end

  def destroy(conn, _params) do
    conn
    |> Auth.Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
