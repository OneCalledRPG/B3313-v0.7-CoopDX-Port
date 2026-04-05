-- name: !  Custom Pause Menu  !
-- description: New pause menu featuring a \nrestart level option\nMade by Blocky

local zero = {x=0,y=0,z=0}
local m = gMarioStates[0]
local np = gNetworkPlayers[0]
local restartLevelArea = 1

local isPaused = false

local r = 0
local g = 0
local b = 0
local color = {r = 0, g = 0, b = 0}

local menuActBlacklist = {
    -- Star Acts
    [ACT_FALL_AFTER_STAR_GRAB] = true,
    [ACT_STAR_DANCE_EXIT] = true,
    [ACT_STAR_DANCE_NO_EXIT] = true,
    [ACT_STAR_DANCE_WATER] = true,
    -- Key Acts
    [ACT_UNLOCKING_KEY_DOOR] = true,
    [ACT_UNLOCKING_STAR_DOOR] = true,
    -- Cutscene Acts
    [ACT_INTRO_CUTSCENE] = true,
    [ACT_END_PEACH_CUTSCENE] = true,
    [ACT_CREDITS_CUTSCENE] = true,
    [ACT_WARP_DOOR_SPAWN] = true,
    [ACT_PULLING_DOOR] = true,
    [ACT_PUSHING_DOOR] = true,
    -- Dialog Acts
    [ACT_READING_NPC_DIALOG] = true,
    [ACT_WAITING_FOR_DIALOG] = true,
    [ACT_EXIT_LAND_SAVE_DIALOG] = true,
    [ACT_READING_AUTOMATIC_DIALOG] = true,
    -- Exit Acts
    [ACT_EXIT_AIRBORNE] = true,
    [ACT_DEATH_EXIT] = true,
    [ACT_UNUSED_DEATH_EXIT] = true,
    [ACT_FALLING_DEATH_EXIT] = true,
    [ACT_SPECIAL_EXIT_AIRBORNE] = true,
    [ACT_SPECIAL_DEATH_EXIT] = true,
    [ACT_FALLING_EXIT_AIRBORNE] = true,
}

--* thanks coolio for the hook & function overwriting

local function is_game_paused_modded()
    return isPaused
end

_G.is_game_paused = is_game_paused_modded

local pause_exit_funcs = {}

local real_hook_event = hook_event
local function hook_event_modded(hook, func)
    if hook == HOOK_ON_PAUSE_EXIT then
        table.insert(pause_exit_funcs, func)
    else
        return real_hook_event(hook, func)
    end
end
_G.hook_event = hook_event_modded

local function call_pause_exit_hooks(exitToCastle)
    local allowExit = true
    for _, func in ipairs(pause_exit_funcs) do
        if func(exitToCastle) == false then
            allowExit = false
            break
        end
    end
    return allowExit
end

local play_sound,save_file_get_star_flags,level_trigger_warp,warp_to_warpnode,djui_hud_set_resolution,djui_hud_set_font,
      djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_set_color,djui_hud_render_rect,course_is_main_course,get_level_name,
      get_star_name,save_file_get_course_star_count,get_current_save_file_num,save_file_get_course_coin_score,djui_hud_measure_text,
      djui_hud_print_text,obj_count_objects_with_behavior_id,djui_open_pause_menu =
      play_sound,save_file_get_star_flags,level_trigger_warp,warp_to_warpnode,djui_hud_set_resolution,djui_hud_set_font,
      djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_set_color,djui_hud_render_rect,course_is_main_course,get_level_name,
      get_star_name,save_file_get_course_star_count,get_current_save_file_num,save_file_get_course_coin_score,djui_hud_measure_text,
      djui_hud_print_text,obj_count_objects_with_behavior_id,djui_open_pause_menu

local selectedOption = 1

local function close_menu()
    if isPaused then
        isPaused = false
        play_sound(SOUND_MENU_PAUSE_HIGHPRIO, zero)
        m.controller.buttonPressed = 0
    end
end

extended_star_tracker = false
local function star_display_toggle()
    if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 then
        extended_star_tracker = true
    end
end

local cooldown = 5
local cooldownCounter = 0

local previousStickY = 0

function loop_var(var, min, max)
    if var > max then
        var = min
    elseif var < min then
        var = max
    end
    return var
end

local function menu_controls(options)
    local stickY = gMarioStates[0].controller.stickY

    if stickY * previousStickY <= 0 then
        cooldownCounter = cooldownCounter // 2
    end

    if cooldownCounter > 0 then
        cooldownCounter = cooldownCounter - 1
    else
        local delta = options and 1 or -1
        if (stickY > 30) or (gMarioStates[0].controller.buttonPressed & U_JPAD ~= 0) then
            selectedOption = (selectedOption - delta)
            if options then
                selectedOption = loop_var(selectedOption, 1, #options)
            else
                selectedOption = loop_var(selectedOption, 0, COURSE_MAX)
            end
            play_sound(SOUND_MENU_CHANGE_SELECT, zero)
            cooldownCounter = cooldown
        elseif (stickY < -30) or (gMarioStates[0].controller.buttonPressed & D_JPAD ~= 0) then
            selectedOption = (selectedOption + delta)
            if options then
                selectedOption = loop_var(selectedOption, 1, #options)
            else
                selectedOption = loop_var(selectedOption, 0, COURSE_MAX)
            end
            play_sound(SOUND_MENU_CHANGE_SELECT, zero)
            cooldownCounter = cooldown
        end
    end

    if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 and options then
        play_sound(SOUND_MENU_CLICK_FILE_SELECT, gMarioStates[0].pos)
        local option = options[selectedOption]
        if option and option.func then
            option.func()
        end
    end

    previousStickY = stickY
end


local function is_star_collected(fileIndex, courseIndex, starId)
    if fileIndex < 0 or courseIndex < -1 or starId < 0 then
        return false
    end

    local currentLevelStarFlags = save_file_get_star_flags(fileIndex, courseIndex)

    return (currentLevelStarFlags & (1 << starId)) ~= 0
end

local lastLobby = 1
local function checkWarp(m)
    if (gNetworkPlayers[m.playerIndex].currLevelNum == LEVEL_CASTLE_GROUNDS and (gNetworkPlayers[m.playerIndex].currAreaIndex == 4)) then
        lastLobby = 1
    elseif (gNetworkPlayers[m.playerIndex].currLevelNum == LEVEL_CASTLE_GROUNDS and (gNetworkPlayers[m.playerIndex].currAreaIndex == 3)) then
        lastLobby = 2
    elseif (gNetworkPlayers[m.playerIndex].currLevelNum == LEVEL_CASTLE_GROUNDS and (gNetworkPlayers[m.playerIndex].currAreaIndex == 2)) then
        lastLobby = 3
    end

    if is_game_paused() then
        if m.playerIndex ~= 0 then return end
        if selectedOption == 3 and (m.controller.buttonPressed & A_BUTTON ~= 0) then
            if lastLobby == 1 then
                warp_to_level(16, 3, 1)
            elseif lastLobby == 2 then
                warp_to_level(16, 2, 1)
            elseif lastLobby == 3 then
                warp_to_level(16, 4, 1)
            end
            --enable_background_sound()
        end
    end
end
hook_event(HOOK_MARIO_UPDATE, checkWarp)

local pauseMenuLevelOptions = {
    {name = "CONTINUE"      , func = close_menu},
    --{name = "RESTART LEVEL" , func = restart_course},
    {name = "VIEW STAR TRACKER", func = star_display_toggle},
    {name = "FAST TRAVEL"   , func = exit_course},
    --{name = "EXIT TO CASTLE", func = exit_to_castle},
}

local function open_cs()
    _G.charSelect.set_menu_open(true)
    close_menu()
end

local r = 0
local g = 0
local b = 0
local color = {r = 0, g = 0, b = 0}

local function render_options(options, screenHeight, screenWidth, optionPosY)
    color = network_player_get_override_palette_color(gNetworkPlayers[gMarioStates[0].playerIndex], CAP)

    djui_hud_set_color(0, 0, 0, 128)

    djui_hud_print_text("CONTINUE", (screenWidth/2) - 60, (screenHeight/2) + 30, 1)
    djui_hud_print_text("VIEW STAR TRACKER", (screenWidth/2) - 60, (screenHeight/2) + 50, 1)
    djui_hud_print_text("FAST TRAVEL", (screenWidth/2) - 60, (screenHeight/2) + 70, 1)

    if selectedOption == 1 then
        djui_hud_set_color(0, 0, 0, 128)
        djui_hud_print_text(">", (screenWidth/2) - 67, (screenHeight/2) + 30, 1)
        djui_hud_set_color(color.r + r, color.g + g, color.b + b, 255)
        djui_hud_print_text(">", (screenWidth/2) - 68, (screenHeight/2) + 29, 1)
        djui_hud_print_text("CONTINUE", (screenWidth/2) - 61, (screenHeight/2) + 29, 1)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("VIEW STAR TRACKER", (screenWidth/2) - 61, (screenHeight/2) + 49, 1)
        djui_hud_print_text("FAST TRAVEL", (screenWidth/2) - 61, (screenHeight/2) + 69, 1)
    elseif selectedOption == 2 then
        djui_hud_set_color(0, 0, 0, 128)
        djui_hud_print_text(">", (screenWidth/2) - 67, (screenHeight/2) + 50, 1)
        djui_hud_set_color(color.r + r, color.g + g, color.b + b, 255)
        djui_hud_print_text(">", (screenWidth/2) - 68, (screenHeight/2) + 49, 1)
        djui_hud_print_text("VIEW STAR TRACKER", (screenWidth/2) - 61, (screenHeight/2) + 49, 1)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("CONTINUE", (screenWidth/2) - 61, (screenHeight/2) + 29, 1)
        djui_hud_print_text("FAST TRAVEL", (screenWidth/2) - 61, (screenHeight/2) + 69, 1)
    else
        djui_hud_set_color(0, 0, 0, 128)
        djui_hud_print_text(">", (screenWidth/2) - 67, (screenHeight/2) + 70, 1)
        djui_hud_set_color(color.r + r, color.g + g, color.b + b, 255)
        djui_hud_print_text(">", (screenWidth/2) - 68, (screenHeight/2) + 69, 1)
        djui_hud_print_text("FAST TRAVEL", (screenWidth/2) - 61, (screenHeight/2) + 69, 1)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("CONTINUE", (screenWidth/2) - 61, (screenHeight/2) + 29, 1)
        djui_hud_print_text("VIEW STAR TRACKER", (screenWidth/2) - 61, (screenHeight/2) + 49, 1)
    end

    if color.r + r >= 255 and color.g + g >= 255 and color.b + b >= 255 then
        r = 255 - color.r
        g = 255 - color.g
        b = 255 - color.b
        switch = true
    elseif r <= 0 and g <= 0 and b <= 0 then
        r = 0
        g = 0
        b = 0
        switch = false
    end

    if switch then
        if r > 0 then
            r = r - 5
        end
        if g > 0 then
            g = g - 5
        end
        if b > 0 then
            b = b - 5
        end
    elseif not switch then
        r = r + (255 - color.r)/75
        g = g + (255 - color.g)/75
        b = b + (255 - color.b)/75
    end

    if color.r + r > 255 then
        r = 255 - color.r
    end
    if color.g + g > 255 then
        g = 255 - color.g
    end
    if color.b + b > 255 then
        b = 255 - color.b
    end

end

local function hud_render()

    local areaStars = areas[gNetworkPlayers[0].currLevelNum] and areas[gNetworkPlayers[0].currLevelNum][gNetworkPlayers[0].currAreaIndex].stars

    if areaStars then
        areaStarCount = 0
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, gNetworkPlayers[0].currCourseNum - 1)
        for z = 0, #areaStars - 1 do
            if starFlags & (1 << areaStars[z + 1]) ~= 0 then
                areaStarCount = areaStarCount + 1
            end
        end
    end

    local course = np.currCourseNum
    local level = np.currLevelNum
    local area = np.currAreaIndex
    local act = np.currActNum

    local sCoinTextures = {
        [0] = get_texture_info("coin_seg3_texture_03005780"),
        [1] = get_texture_info("coin_seg3_texture_03005F80"),
        [2] = get_texture_info("coin_seg3_texture_03006780"),
        [3] = get_texture_info("coin_seg3_texture_03006F80"),
        [4] = get_texture_info("coin_seg3_texture_03005780"),
    }

    local sMiniStarTextures = {
        [0] = get_texture_info("mini_star_seg3_texture_1"),
        [1] = get_texture_info("mini_star_seg3_texture_2"),
        [2] = get_texture_info("mini_star_seg3_texture_3"),
        [3] = get_texture_info("mini_star_seg3_texture_4"),
        [4] = get_texture_info("mini_star_seg3_texture_1"),
    }

    if not isPaused then return end
    m.freeze = 1
    if extended_star_tracker then return end
    local zTrigPressed = m.controller.buttonPressed & Z_TRIG ~= 0

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_TINY)
    local screenHeight = djui_hud_get_screen_height()
    local screenWidth = djui_hud_get_screen_width()
    local optionPosY = screenHeight - 35

    local currCourseNum = gNetworkPlayers[0].currCourseNum
    local currLevelNum = gNetworkPlayers[0].currLevelNum
    local currAreaIndex = gNetworkPlayers[0].currAreaIndex
    local currActNum = gNetworkPlayers[0].currActNum

    djui_hud_set_color(0, 0, 25, 128)
    djui_hud_render_rect(0, 0, screenWidth + 20, screenHeight)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_print_text("R Button - Options", halfScreenWidth - (djui_hud_measure_text("R Button - Options") /3), 3, 0.5)

    -- Character Select Support
    if _G.charSelectExists then
        if isPaused and _G.charSelect.is_menu_open() then
            close_menu()
        end
        if isPaused and zTrigPressed then
            _G.charSelect.set_menu_open(true)
            close_menu()
        end

        -- Render Pause Screen Text
        if currActNum == 99 or (menuActBlacklist[m.action] or m.action == ACT_JUMBO_STAR_CUTSCENE) then cstext = "Character Select is Unavailable"
        else cstext = "Z Button - Character Select" end
        cswidth = djui_hud_get_screen_width() - djui_hud_measure_text(cstext)/2
        djui_hud_print_text(cstext, cswidth - 5, 3, 0.5)

        cstext = "Current Character: "
        cschar = charSelect.character_get_current_table()
        cswidth = djui_hud_get_screen_width() - djui_hud_measure_text(cstext)/2 - djui_hud_measure_text(cschar.name)/2
        djui_hud_print_text(cstext, cswidth - 5, 10, 0.5)
        djui_hud_set_color(color.r, color.g, color.b, 255)
        cswidth = djui_hud_get_screen_width() - djui_hud_measure_text(cschar.name)/2
        djui_hud_print_text(cschar.name, cswidth - 5, 10, 0.5)

        djui_hud_set_color(255, 255, 255, 255)
        if charSelect.are_palettes_restricted() and charSelect.are_movesets_restricted() then cstext = "Movesets and Palettes are Restricted"
        elseif not charSelect.are_palettes_restricted() and charSelect.are_movesets_restricted() then cstext = "Movesets are Restricted"
        elseif charSelect.are_palettes_restricted() and not charSelect.are_movesets_restricted() then cstext = "Paletted are Restricted" end
        if charSelect.are_palettes_restricted() or charSelect.are_movesets_restricted() then
            cswidth = djui_hud_get_screen_width() - djui_hud_measure_text(cstext)/2
            djui_hud_print_text(cstext, cswidth - 5, 17, 0.5)
        end
    end

    djui_hud_set_color(0, 0, 0, 192)
    djui_hud_render_rect(halfScreenWidth - 100, 85, 200, 50)
    djui_hud_set_color(0, 0, 0, 128)
    djui_hud_render_rect(halfScreenWidth - 98, 87, 196, 46)

    djui_hud_set_font(FONT_TINY)
    djui_hud_set_color(255, 255, 255, 255)

    local areaNameLength = djui_hud_measure_text(gPlayerSyncTable[0].location)
    local areaTextScale = clamp((180)/areaNameLength, 0.3, 1)
    djui_hud_print_text(gPlayerSyncTable[0].location, halfScreenWidth - areaNameLength*areaTextScale*0.5, 99 + (1 - areaTextScale)*16, areaTextScale)

    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text("GAME PAUSED", halfScreenWidth - (djui_hud_measure_text("GAME PAUSED") /2), (screenHeight * 0.55) - 75, 1 )

    if areaStars then
        djui_hud_render_texture(gTextures.star, halfScreenWidth - 80, 119, 0.7, 0.7)
        djui_hud_print_text((tostring(areaStarCount).."/"..tostring(#areas[gNetworkPlayers[0].currLevelNum][gNetworkPlayers[0].currAreaIndex].stars)), halfScreenWidth - 65, 120, 0.7)
    end

    -- Displays tiny star counter
    local tinyStarCourse = (currLevelNum == LEVEL_BBH)
    or (currLevelNum == LEVEL_HMC)
    or (currLevelNum == LEVEL_COTMC)

    if gMarioStates[0].area.numRedCoins > 0 then
        if tinyStarCourse then
            djui_hud_set_color(0xFF, 0xFF, 0x00, 0xFF) -- Yellow
            djui_hud_render_texture(sMiniStarTextures[math.floor(gMarioStates[0].marioObj.oTimer / 1) % #sMiniStarTextures], halfScreenWidth + 35, 120.5, 0.36, 0.36)
        else
            djui_hud_set_color(0xFF, 0x00, 0x00, 0xFF) -- Red
            djui_hud_render_texture(sCoinTextures[math.floor(gMarioStates[0].marioObj.oTimer / 2) % #sCoinTextures], halfScreenWidth + 35, 119.5, 0.4, 0.4)
        end
        djui_hud_set_color(0xFF, 0xFF, 0xFF, 0xFF) -- Regular
        djui_hud_print_text(tostring(gMarioStates[0].area.numRedCoins - obj_count_objects_with_behavior_id(id_bhvRedCoin).."/"..gMarioStates[0].area.numRedCoins), halfScreenWidth + 49, 120, 0.7)
    end

    djui_hud_set_font(FONT_TINY)
    if (gLevelValues.pauseExitAnywhere or (gMarioStates[0].action & ACT_FLAG_PAUSE_EXIT) ~= 0) then
        menu_controls(pauseMenuLevelOptions)
        render_options(pauseMenuLevelOptions, screenHeight, screenWidth, optionPosY)
    end
end

local function pressed_pause()
    if get_dialog_id() >= 0 or (_G.charSelectExists and _G.charSelect.is_menu_open()) then
        return false
    end

    return gMarioStates[0].controller.buttonPressed & START_BUTTON ~= 0
end

function before_mario_update()
    local rTrigPressed = m.controller.buttonPressed & R_TRIG ~= 0

    if pressed_pause() then
        if not isPaused then
            if menuActBlacklist[m.action] then return end
            isPaused = true
            selectedOption = 1
            m.controller.buttonPressed = 0
            play_sound(SOUND_MENU_PAUSE_HIGHPRIO, zero)
        else
            extended_star_tracker = false
            close_menu()
        end
    elseif rTrigPressed and isPaused then
        djui_open_pause_menu()
        extended_star_tracker = false
        m.controller.buttonPressed = 0
        play_sound(SOUND_MENU_EXIT_A_SIGN, zero)
        close_menu()
    elseif (m.controller.buttonPressed & B_BUTTON ~= 0) and isPaused then
        if extended_star_tracker then 
            extended_star_tracker = false
            m.controller.buttonPressed = 0
            play_sound(SOUND_MENU_CLICK_FILE_SELECT, zero)
        else
            isPaused = false
            play_sound(SOUND_MENU_PAUSE, m.marioObj.header.gfx.cameraToObject)
        end
    elseif (m.controller.buttonPressed & A_BUTTON ~= 0) and isPaused and extended_star_tracker then
        extended_star_tracker = false
        m.controller.buttonPressed = 0
        play_sound(SOUND_MENU_CLICK_FILE_SELECT, zero)
    end
end

real_hook_event(HOOK_ON_HUD_RENDER, hud_render)
real_hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
real_hook_event(HOOK_ON_WARP, close_menu)
real_hook_event(HOOK_ON_LEVEL_INIT, function () restartLevelArea = gNetworkPlayers[0].currAreaIndex close_menu() end)

-- Fixes an issue where the original pause screen can be accessed in rare circumstances when a star spawns. Replicates normal star-spawn cutscene behavior while avoiding the issue
hook_event(HOOK_UPDATE, function()
    local m = gMarioStates[0]
    local c = gMarioStates[0].area.camera
    if not m or not c then return end

    if (c.cutscene == CUTSCENE_STAR_SPAWN) or (c.cutscene == CUTSCENE_RED_COIN_STAR_SPAWN) then
        disable_time_stop_including_mario()
        m.capTimer = m.capTimer + 1
        local grandStar = obj_get_first_with_behavior_id(id_bhvGrandStar)
        if not grandStar then
            m.freeze = 1
            m.invincTimer = 2
        end
    end
end)