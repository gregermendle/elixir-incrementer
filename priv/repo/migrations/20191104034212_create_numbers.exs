defmodule Numbers.Repo.Migrations.CreateNumbers do
  use Ecto.Migration

  def change do
    create table(:numbers, primary_key: false) do
      add :key, :text
      add :value, :integer, default: 0
    end
    create unique_index(:numbers, [:key], name: :numbers_key_index)
  end
end
