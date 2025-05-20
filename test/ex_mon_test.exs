defmodule ExMonTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "create_player/4" do
    test "return a player" do
      expected_response = %Player{
        name: "Wallauer",
        life: 100,
        moves: %{heal: :cura, avg: :soco, rnd: :chute}
      }

      assert expected_response == ExMon.create_player("Wallauer", :chute, :soco, :cura)
    end
  end
end
