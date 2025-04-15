defmodule ExMon.Player do
  @require_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @require_keys
  defstruct @require_keys

  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        rnd: move_rnd,
        avg: move_avg,
        heal: move_heal
      },
      name: name
    }
  end
end
