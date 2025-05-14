defmodule BbvaChallenge.Businesses do
  @moduledoc """
  The Businesses context.
  """

  import Ecto.Query, warn: false
  alias BbvaChallenge.Repo

  alias BbvaChallenge.Businesses.Company

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    with {:ok, file_paths} <- persist_files(attrs, ~w(official_id e_signature)a),
         changeset <- Company.changeset(%Company{}, Map.merge(attrs, file_paths)),
         {:ok, company} <- Repo.insert(changeset) do
      {:ok, company}
    else
      {:error, _} = err -> err
    end
  end

  # ---------- helpers ----------
  @upload_dir Application.compile_env(
                :bbva_challenge,
                :company_upload_dir,
                Application.app_dir(:bbva_challenge, "priv/static/uploads/companies")
              )

  defp persist_files(attrs, keys) do
    Enum.reduce_while(keys, {:ok, %{}}, fn k, {:ok, acc} ->
      case Map.get(attrs, Atom.to_string(k)) || Map.get(attrs, k) do
        %Plug.Upload{filename: fname, path: tmp} ->
          File.mkdir_p!(@upload_dir)
          ext = Path.extname(fname)
          dest = Path.join(@upload_dir, "#{Ecto.UUID.generate()}#{ext}")

          case File.cp(tmp, dest) do
            :ok ->
              {:cont, {:ok, Map.put(acc, k, String.replace(dest, ~r|.*priv/static|, "/uploads"))}}

            error ->
              {:halt, error}
          end

        # si no se envió el campo, seguimos sin error
        nil ->
          {:cont, {:ok, acc}}

        _ ->
          {:halt, {:error, "#{k} debe ser un archivo"}}
      end
    end)
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end
end
