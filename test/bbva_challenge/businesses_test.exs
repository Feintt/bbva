defmodule BbvaChallenge.BusinessesTest do
  use BbvaChallenge.DataCase

  alias BbvaChallenge.Businesses

  describe "companies" do
    alias BbvaChallenge.Businesses.Company

    import BbvaChallenge.BusinessesFixtures

    @invalid_attrs %{name: nil, rfc: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Businesses.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Businesses.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{name: "some name", rfc: "some rfc"}

      assert {:ok, %Company{} = company} = Businesses.create_company(valid_attrs)
      assert company.name == "some name"
      assert company.rfc == "some rfc"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      update_attrs = %{name: "some updated name", rfc: "some updated rfc"}

      assert {:ok, %Company{} = company} = Businesses.update_company(company, update_attrs)
      assert company.name == "some updated name"
      assert company.rfc == "some updated rfc"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_company(company, @invalid_attrs)
      assert company == Businesses.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Businesses.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Businesses.change_company(company)
    end
  end
end
