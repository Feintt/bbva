defmodule BbvaChallengeWeb.ErrorHelpers do
  @moduledoc false

  @doc """
  Convierte un Ecto.Changeset en un mapa legible de errores.
  """
  def traverse_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, val}, acc ->
        String.replace(acc, "%{#{key}}", to_string(val))
      end)
    end)
  end
end
