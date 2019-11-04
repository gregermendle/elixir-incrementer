defmodule Numbers.Repo do
  use Ecto.Repo, otp_app: :incrementer, adapter: Sqlite.Ecto2
end
