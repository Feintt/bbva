defmodule BbvaChallenge.BusinessesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BbvaChallenge.Businesses` context.
  """

  @doc """
  Generate a unique company rfc.
  """
  def unique_company_rfc, do: "some rfc#{System.unique_integer([:positive])}"

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        name: "some name",
        rfc: unique_company_rfc()
      })
      |> BbvaChallenge.Businesses.create_company()

    company
  end
end
