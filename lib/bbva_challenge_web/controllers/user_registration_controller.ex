defmodule BbvaChallengeWeb.UserRegistrationController do
  use BbvaChallengeWeb, :controller
  alias BbvaChallenge.Accounts

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.get_user_by_email(user_params["email"]) do
      nil ->
        case Accounts.register_user(user_params) do
          {:ok, user} ->
            {:ok, token} = Accounts.create_user_api_token(user)

            conn
            |> put_status(:created)
            |> json(%{token: token, user_id: user.id})

          {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: changeset_errors(changeset)})
        end

      _user ->
        conn
        |> put_status(:conflict)
        |> json(%{error: "Email already registered"})
    end
  end
end
