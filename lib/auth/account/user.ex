defmodule Auth.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Auth.Account.User


  schema "users" do
    field :email, :string
    field :password, :string
    field :plain_password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :plain_password, :password])
    |> validate_required([:email, :plain_password])
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    plain_password = get_change(changeset, :plain_password)

    if plain_password do
      encrypted_password = Comeonin.Argon2.hashpwsalt(plain_password)
      put_change(changeset, :password, encrypted_password)
    else  
      changeset
    end
  end
end
