defmodule BbvaChallengeWeb.CompanyControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.BusinessesFixtures

  alias BbvaChallenge.Businesses.Company

  @create_attrs %{
    name: "some name",
    rfc: "some rfc"
  }
  @update_attrs %{
    name: "some updated name",
    rfc: "some updated rfc"
  }
  @invalid_attrs %{name: nil, rfc: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get(conn, ~p"/api/companies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company" do
    test "renders company when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/companies", company: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/companies/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name",
               "rfc" => "some rfc"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/companies", company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company" do
    setup [:create_company]

    test "renders company when data is valid", %{conn: conn, company: %Company{id: id} = company} do
      conn = put(conn, ~p"/api/companies/#{company}", company: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/companies/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "rfc" => "some updated rfc"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put(conn, ~p"/api/companies/#{company}", company: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, ~p"/api/companies/#{company}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/companies/#{company}")
      end
    end
  end

  defp create_company(_) do
    company = company_fixture()
    %{company: company}
  end
end
