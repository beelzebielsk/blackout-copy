-- Assorted Constants: {{{ ---------------------------------

colors = {
    bg         = Color.new(0, 0, 0, 255)
    fg         = Color.new(255, 255, 255, 40)
    fg_lighter = Color.new(255, 255, 255, 20)
    outline    = Color.new(255, 255, 255, 80)
    light_bg   = Color.new(0, 100, 0, 110)
    light      = Color.new(255, 255, 255, 255)
    solution   = Color.new(255, 255, 0, 255)
}

buttons = {
    up       = SCE_CTRL_UP
    down     = SCE_CTRL_DOWN
    left     = SCE_CTRL_LEFT
    right    = SCE_CTRL_RIGHT
    cross    = SCE_CTRL_CROSS
    circle   = SCE_CTRL_CIRCLE
    square   = SCE_CTRL_SQUARE
    triangle = SCE_CTRL_TRIANGLE
    ltrigger = SCE_CTRL_LTRIGGER
    rtrigger = SCE_CTRL_RTRIGGER
    start    = SCE_CTRL_START
    select   = SCE_CTRL_SELECT
    power    = SCE_CTRL_POWER
    volup    = SCE_CTRL_VOLUP
    voldown  = SCE_CTRL_VOLDOWN
    psbutton = SCE_CTRL_PSBUTTON
}

puzzles = {
    "1101100000110110000011011",
    "1111100100000000010011111",
}

-- }}} -----------------------------------------------------

-- Parameters:
-- puzzle, string:
--     A string representing a puzzle configuration. Should be 25
--     characters in length exactly, as each puzzle is a 5x5 grid.
-- Returns:
-- tablePuzzle, table:
--     A table representing a puzzle configuration.
function puzzleToTable(puzzle)
    local light = {}
    for i = 1, 25 do
        -- The ith element of light is the ith character of puzzle.
        light[i] = string.sub(puzzle, i, i)
    end
    return light
end

-- Switches "1" to "0", and "0" to "1".
-- Parameters:
-- number, string:
--      A string representing a number. Should be either "0", or "1".
-- Returns:
-- toggled Number: "1" if number was "0", and "0" otherwise.
function toggleNumber(number)
    return tostring(1 - tonumber(number))
end

function lightSwitch(puzzle, position)
    -- - The above position is a row above (5 less).
    -- - The position to the right is one more than the current
    --   position.
    -- - The position to the left is one less than the current
    --   position.
    -- - The position under is a row under (5 more).
    local width = 5
    local above = position - width >= 0 and position - 5 or nil
    local left  = position % width ~= 0 and position - 1 or nil
    local right = position % width ~= 4 and position + 1 or nil
    local below = position + width < 25 and position + 5 or nil
    puzzle[position] = toggleNumber(puzzle[position])
    if above then puzzle[above] = toggleNumber(puzzle[above]) end
    if left  then puzzle[left]  = toggleNumber(puzzle[left]) end
    if right then puzzle[right] = toggleNumber(puzzle[right]) end
    if below then puzzle[below] = toggleNumber(puzzle[below]) end
end

-- Parameters:
-- frame, integer:
--      The number of frames to wait for.
function wait(frame)
    frame = frame * 0.034
    time = os.clock() + frame
    while os.clock() < time do end
end

currentPuzzle = 0
puzzle = puzzleToTable(puzzles[currentPuzzle])

while true do
    pad = Controls.read()
    -- Get only the first touch. All other touches don't count.
    touches = {Controls.readTouch()}
    Graphics.initBlend()
    Screen.clear()
    Graphics.fillRect(0, 0, 960, 544, colors.bg)
    Graphics.fillEmptyRect(10, 10, 940, 524, colors.fg)
    Graphics.fillEmptyRect(20, 20, 920, 504, colors.fg_lighter)
    Graphics.fillRect(549, 477, 391, 49, colors.bg)
    Graphics.fillEmptyRect(610, 60, 195, 52, colors.fg)
    Graphics.fillRect(614, 64, 187, 44, colors.fg)
    Graphics.fillEmptyRect(610, 140, 195, 85, colors.fg)
    Screen.flip()
end
