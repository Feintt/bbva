defmodule BbvaChallengeWeb.PaymentRequestControllerTest do
  use BbvaChallengeWeb.ConnCase

  import BbvaChallenge.PaymentsFixtures

  alias BbvaChallenge.Payments.PaymentRequest

  @create_attrs %{
    status: "some status",
    currency: "some currency",
    amount: "120.5",
    pay_url: "some pay_url",
    qr_svg: "some qr_svg"
  }
  @update_attrs %{
    status: "some updated status",
    currency: "some updated currency",
    amount: "456.7",
    pay_url: "some updated pay_url",
    qr_svg: "some updated qr_svg"
  }
  @invalid_attrs %{status: nil, currency: nil, amount: nil, pay_url: nil, qr_svg: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all payment_requests", %{conn: conn} do
      conn = get(conn, ~p"/api/payment_requests")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create payment_request" do
    test "renders payment_request when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/payment_requests", payment_request: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/payment_requests/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "120.5",
               "currency" => "some currency",
               "pay_url" => "some pay_url",
               "qr_svg" => "some qr_svg",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/payment_requests", payment_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update payment_request" do
    setup [:create_payment_request]

    test "renders payment_request when data is valid", %{conn: conn, payment_request: %PaymentRequest{id: id} = payment_request} do
      conn = put(conn, ~p"/api/payment_requests/#{payment_request}", payment_request: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/payment_requests/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "456.7",
               "currency" => "some updated currency",
               "pay_url" => "some updated pay_url",
               "qr_svg" => "some updated qr_svg",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, payment_request: payment_request} do
      conn = put(conn, ~p"/api/payment_requests/#{payment_request}", payment_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete payment_request" do
    setup [:create_payment_request]

    test "deletes chosen payment_request", %{conn: conn, payment_request: payment_request} do
      conn = delete(conn, ~p"/api/payment_requests/#{payment_request}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/payment_requests/#{payment_request}")
      end
    end
  end

  defp create_payment_request(_) do
    payment_request = payment_request_fixture()
    %{payment_request: payment_request}
  end
end
