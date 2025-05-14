# lib/bbva_challenge_web/views/company_json.ex
defmodule BbvaChallengeWeb.CompanyJSON do
  alias BbvaChallenge.Businesses.Company
  alias BbvaChallengeWeb.ErrorHelpers

  @doc """
  Renders a list of companies.
  """
  def index(%{companies: companies}) do
    %{data: Enum.map(companies, &data/1)}
  end

  @doc """
  Renders a single company.
  """
  def show(%{company: company}) do
    %{data: data(company)}
  end

  @doc """
  Renders validation errors from a changeset.
  """
  def render("error.json", %{changeset: changeset}) do
    %{errors: ErrorHelpers.traverse_errors(changeset)}
  end

  defp data(%Company{} = c) do
    %{
      id: c.id,
      name: c.name,
      rfc: c.rfc,
      society_type: c.society_type,
      fiscal_address: c.fiscal_address,
      industry: c.industry,
      official_id_url: c.official_id,
      e_signature_url: c.e_signature,
      inserted_at: c.inserted_at,
      updated_at: c.updated_at
    }
  end
end
