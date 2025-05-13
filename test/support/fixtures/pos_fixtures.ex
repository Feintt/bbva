defmodule BbvaChallenge.PosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BbvaChallenge.Pos` context.
  """

  @doc """
  Generate a cash_movement.
  """
  def cash_movement_fixture(attrs \\ %{}) do
    {:ok, cash_movement} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        date: ~U[2025-05-12 19:41:00Z],
        description: "some description",
        payment_method: "some payment_method",
        type: "some type"
      })
      |> BbvaChallenge.Pos.create_cash_movement()

    cash_movement
  end

  @doc """
  Generate a terminal.
  """
  def terminal_fixture(attrs \\ %{}) do
    {:ok, terminal} =
      attrs
      |> Enum.into(%{
        name: "some name",
        qr_code_url: "some qr_code_url"
      })
      |> BbvaChallenge.Pos.create_terminal()

    terminal
  end

  @doc """
  Generate a terminal_assignment.
  """
  def terminal_assignment_fixture(attrs \\ %{}) do
    {:ok, terminal_assignment} =
      attrs
      |> Enum.into(%{

      })
      |> BbvaChallenge.Pos.create_terminal_assignment()

    terminal_assignment
  end
end
