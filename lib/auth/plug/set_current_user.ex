defmodule Auth.Plug.SetCurrentUser do
  def init(opts), do: opts

  def call(conn, opts) do
    user = Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, user)
  end
end
