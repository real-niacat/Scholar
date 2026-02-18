local game_hook = Game.init_game_object
function Game:init_game_object()

    local game = game_hook(self)

    game.dollars_per_interest = 5

    return game
end