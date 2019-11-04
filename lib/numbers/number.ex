defmodule Incrementer.Number do
  use Ecto.Schema

  @primary_key false
  schema "numbers" do
    field :key, :string
    field :value, :integer, default: 0
  end
end
