defmodule AuthWeb.RegistrationController do
  use AuthWeb, :controller

  alias Auth.Account
  alias Auth.Account.User

  def new(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    case Account.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Registration successfull.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
