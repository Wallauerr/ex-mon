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
end
