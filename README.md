# Scholar
#### A Balatro mod made to overcomplicate a simple game

All vanilla Jokers receive a fresh coat of paint, effect-wise.

Jokers are now much more complicated, having 2-5 separate effects which allow for many more synergies and unique builds.

You can find the suggestion and planning document [Here](https://docs.google.com/spreadsheets/d/1KdAGnW1ntXrrdpWyZgHtaKW-x_4lT0-57tMybdHBN6U/edit?gid=0#gid=0).
### Jokers Implemented: 0/150

# Contributing
#### The following are not hard rules, but guidelines for consistent code.

- Keep all relevant code within the file related.
    - If it is a system or function other Jokers could reasonably make use of, put it in src/api.lua
    - Label the purpose of all functions added for this purpose.

- If lovely patches are needed, use a different .toml file for each Joker
    - Similarly, if it is a system or function other Jokers could reasonably make use of, name it related to its purpose, rather than Joker

- Comment or clean up your code
    - Using a feature that's lesser known / used (e.g. DynaText) should explain what inputs correlate with what results.
    - Doing longer statements that don't inherently make sense (e.g. `local x = y and (y + z) or z`) should be annotated, or outright removed
    - Code that's clear enough to not require comments is often better than well-commented code

- Generally, make other peoples lives easier 
    - If you're making a function that'll get lots of use, please add LSP annotations for it
        - (see [This Guide](https://luals.github.io/wiki/annotations/) for help with making LSP annotations)
    - Name & place functions and variables appropriately
        - Use [snake_case](https://en.wikipedia.org/wiki/Snake_case) whenever possible
        - Avoid non-descript variable names unless they are exceptionally obvious (e.g. `local x = 5`)
        - Do not put functions in the global scope, use the mod table (e.g. `function Scholar.func(x)` rather than `function func(x)`)
        - Never declare new global variables for any purpose. Use something like `G.GAME`.
    - Name hooked functions appropriately
        - e.g.
        ```lua
        local func_hook = func
        -- not something like local x = func, or local old = func
        function func(x)
            return func_hook(x)
        end
        ```