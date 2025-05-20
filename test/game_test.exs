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

  describe "update/1" do
    test "returns the game state update" do
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

      new_state = %{
        status: :started,
        player: %ExMon.Player{
          name: "Wallauer",
          life: 43,
          moves: %{heal: :cura, avg: :soco, rnd: :chute}
        },
        computer: %ExMon.Player{
          name: "Robot",
          life: 11,
          moves: %{heal: :cura, avg: :soco, rnd: :chute}
        },
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player" do
      player = Player.build("Wallauer", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        name: "Wallauer",
        life: 100,
        moves: %{heal: :cura, avg: :soco, rnd: :chute}
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the turn" do
      player = Player.build("Wallauer", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player" do
      player = Player.build("Wallauer", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        name: "Wallauer",
        life: 100,
        moves: %{heal: :cura, avg: :soco, rnd: :chute}
      }

      assert expected_response == Game.fetch_player(:player)
    end
  end
end
