defmodule BbvaChallengeWeb.CompanyController do
  use BbvaChallengeWeb, :controller

  alias BbvaChallenge.Accounts
  alias BbvaChallenge.Businesses
  alias BbvaChallenge.Businesses.Company

  action_fallback BbvaChallengeWeb.FallbackController

  def index(conn, _params) do
    companies = Businesses.list_companies()
    render(conn, :index, companies: companies)
  end

  def create(conn, %{"company" => params}) do
    user = conn.assigns.current_user

    case BbvaChallenge.Businesses.create_company(params) do
      {:ok, company} ->
        Accounts.update_user_company(user, company.id)

        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/companies/#{company}")
        |> render(:show, company: company)

      {:error, %Ecto.Changeset{} = cs} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: cs)

      {:error, reason} ->
        # error fuera del changeset (ej. al copiar archivo)
        conn |> send_resp(500, "upload error: #{inspect(reason)}")
    end
  end

  def show(conn, %{"id" => id}) do
    company = Businesses.get_company!(id)
    render(conn, :show, company: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Businesses.get_company!(id)

    with {:ok, %Company{} = company} <- Businesses.update_company(company, company_params) do
      render(conn, :show, company: company)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Businesses.get_company!(id)

    with {:ok, %Company{}} <- Businesses.delete_company(company) do
      send_resp(conn, :no_content, "")
    end
  end
end
