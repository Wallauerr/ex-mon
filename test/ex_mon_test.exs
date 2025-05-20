defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

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

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Wallauer", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "life: 100"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Wallauer", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
      assert messages =~ "turn: :player"
    end

    test "when the move is invalid, return an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong_move)
        end)

      assert messages =~ "Invalid move: wrong_move."
    end
  end
end
