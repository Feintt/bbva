defmodule BbvaChallengeWeb.UserSessionController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Accounts

  def get(conn, _params) do
    user = conn.assigns[:current_user]

    if user do
      conn
      |> put_status(:ok)
      |> json(%{user: %{id: user.id, email: user.email, name: user.name}})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized"})
    end
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.get_user_by_email_and_password(email, password) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})

      user ->
        {:ok, token} = Accounts.create_user_api_token(user)

        conn
        |> put_status(:ok)
        |> json(%{token: token})
    end
  end

  def delete(conn, _params) do
    current_user = conn.assigns[:current_user]
    IO.inspect(current_user, label: "My user")

    with {:ok, _msg} <- Accounts.delete_user_api_token(current_user) do
      json(conn, %{message: "Logged out"})
    else
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end
end
