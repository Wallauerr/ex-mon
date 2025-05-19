defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Wallauer", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Wallauer", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %ExMon.Player{
          name: "Wallauer",
          life: 100,
          moves: %{heal: :cura, avg: :soco, rnd: :chute}
        },
        computer: %ExMon.Player{
          name: "Robot",
          life: 100,
          moves: %{heal: :cura, avg: :soco, rnd: :chute}
        },
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end
end
