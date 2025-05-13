defmodule BbvaChallengeWeb.AccountController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Accounting
  alias BbvaChallenge.Accounting.Account

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounting.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounting.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{account}")
      |> render(:show, account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounting.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounting.get_account!(id)

    with {:ok, %Account{} = account} <- Accounting.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounting.get_account!(id)

    with {:ok, %Account{}} <- Accounting.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
