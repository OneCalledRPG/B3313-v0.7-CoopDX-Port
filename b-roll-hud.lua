custom_hud = true
hud_07_layout = false
power_meter_override = false

local life_icons = {
    [CT_MARIO] = gTextures.mario_head,
    [CT_LUIGI] = gTextures.luigi_head,
    [CT_TOAD] = gTextures.toad_head,
    [CT_WALUIGI] = gTextures.waluigi_head,
    [CT_WARIO] = gTextures.wario_head,
}

local powerMeters = {
    ["left"] = get_texture_info("b_roll_pm_left"),
    ["right"] = get_texture_info("b_roll_pm_right"),
    [1] = get_texture_info("b_roll_pm_1"),
    [2] = get_texture_info("b_roll_pm_2"),
    [3] = get_texture_info("b_roll_pm_3"),
    [4] = get_texture_info("b_roll_pm_4"),
    [5] = get_texture_info("b_roll_pm_5"),
    [6] = get_texture_info("b_roll_pm_6"),
    [7] = get_texture_info("b_roll_pm_7"),
    [8] = get_texture_info("b_roll_pm_8")
}

local ax = 16 -- Space between the lives/stars/coins icons and the multiplication symbol
local xb = 28 -- Space between the lives/stars/coins and the actual value of lives/stars/coins you have

-- Note, if a value in these rendring functions only takes one scale value, it'll default to the scaleW value, or the horizontal scale value

function render_lives_segment(x, y, scaleW, scaleH) -- Lives
    --render_custom_char_icon(x, y, scaleW, scaleH)  -- Gets the star icon from the earlier functions, in the event of a Character Select override
    if _G.charSelectExists then
        _G.charSelect.character_render_life_icon(0, x, y, scaleW)
    else
        djui_hud_render_texture(gMarioStates[0].character.hudHeadTexture, x, y, scaleW, scaleH)
        --lifeIcon = gMarioStates[0].character.hudHeadTexture
        --djui_hud_render_texture(lifeIcon, x, y, scaleW / (lifeIcon.width * MATH_DIVIDE_16), scaleH / (lifeIcon.height * MATH_DIVIDE_16))
    end
    djui_hud_print_text("@", x + ax, y, scaleW)
    djui_hud_print_text(lives, x + xb, y, scaleW)
end

function render_coins_segment(x, y, scaleW, scaleH) -- Coins
    --if gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_GROUNDS and gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_COURTYARD and gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE then     -- Hides coin display in certain areas
        djui_hud_render_texture(gTextures.coin, x, y, scaleW, scaleH) -- Coin texture
        djui_hud_print_text("@", x + ax, y, scaleW) -- The X
        djui_hud_print_text(coins, x + xb, y, scaleW)
    --end
end

function render_stars_segment(x, y, scaleW, scaleH) -- Stars
    --render_custom_star_icon(x, y, scaleW, scaleH) -- Gets the star icon from the earlier functions, in the event of a Character Select override
    if _G.charSelectExists then
        _G.charSelect.character_render_star_icon(0, x, y, scaleW)
    else
        djui_hud_render_texture(gTextures.star, x, y, scaleW, scaleH)
    end
    if gMarioStates[0].numStars < 100 or not hud_07_layout then  -- Renders the X if you have less than 100 stars
        djui_hud_print_text("@", x + ax, y, scaleW) -- The X
        djui_hud_print_text(stars, x + xb, y, scaleW)  -- The counter itself
    else
        djui_hud_print_text(stars, x + ax, y, scaleW)
    end
end

local pmTimer = 0
local ascendValue = 0
local doOnce = false
function render_power_meter(x, y, scaleW, scaleH)
    local health = math.ceil(gMarioStates[0].health / 256) - 1
    --djui_hud_set_color(255, 255, 255, 216.75)
    djui_hud_set_color(255, 255, 255, 255)

    local renderPowerMeter = health < 8 or gMarioStates[0].action & ACT_GROUP_MASK == ACT_GROUP_SUBMERGED
    if pmTimer > 0 then
        pmTimer = pmTimer - 1
    elseif renderPowerMeter then
        if ascendValue < -1 then
            ascendValue = 35
        end
        if ascendValue >= 31 then ascendValue = ascendValue - 5
        elseif ascendValue >= 21 then ascendValue = ascendValue - 3
        elseif ascendValue >= 10 then ascendValue = ascendValue - 2
        elseif ascendValue >= 0 then ascendValue = ascendValue - 1 end
    else
        if ascendValue == -1 and not doOnce then
            pmTimer = 90
            doOnce = true
        end
        if ascendValue > 0 - 100 and pmTimer == 0 then
            ascendValue = ascendValue - 20
            doOnce = false
        end
    end
    --[[hud_render_power_meter(gMarioStates[0].health, x, y + ascendValue, scaleW, scaleH)

    djui_hud_set_color(255, 255, 255, 255)
    hud_render_power_meter(gMarioStates[0].health, x, y + ascendValue, scaleW, scaleH)]]

    if not power_meter_override then
    --if not gPlayerSyncTable[0].vanillaMario then
        djui_hud_render_texture(powerMeters["left"], x, y + ascendValue, scaleW, scaleH)
        djui_hud_render_texture(powerMeters["right"], x + 32, y + ascendValue, scaleW, scaleH)
        if health > 0 then
            djui_hud_render_texture(powerMeters[health], (x + 16), (y + 16) + ascendValue, scaleW, scaleH)
        end
    else
        djui_hud_set_color(255, 255, 255, 255)
        hud_render_power_meter(gMarioStates[0].health, halfScreenWidth - 51, 9 + ascendValue, 65, 65)
    end

    if _G.charSelectExists then
        char_power_meter = _G.charSelect.character_get_health_meter()
        if type(char_power_meter) == "function" then
            power_meter_override = true
        else
            power_meter_override = false
        end
    end
end

minutes = 0
seconds = 0
milliseconds = 0
function render_timer(timer, x, y)
    djui_hud_set_color(255, 255, 255, 255)
    if hud_get_value(HUD_DISPLAY_FLAGS) & HUD_DISPLAY_FLAGS_TIMER ~= 0 then
        minutes = math.floor(timer/30/60%60)
        seconds = math.floor(timer/30)%60
        milliseconds = math.floor(timer/30%1 * 100)

        if HUDstate == 1 then
            djui_hud_print_text("TIME", x - 47, y, 1)
            djui_hud_print_text(string.format("%02d", minutes), x + 14.5, y, 1)
            djui_hud_print_text("'", x + 22, y - 7, 1)
            djui_hud_print_text(string.format("%02d", seconds), x + 44.5, y, 1)
            djui_hud_print_text('"', x + 57, y - 7, 1)
            djui_hud_print_text(string.format("%d", milliseconds), x + 74.5, y, 1)
        end
    end
end

local is_camera_cdown = false
function render_camera(x, y, scaleW, scaleH)
    local m = gMarioStates[0]
    local c = m.area and m.area.camera or nil
    if not c then return end
    local camText = nil
    if c.cutscene ~= 0 or (m.controller.buttonDown & R_TRIG ~= 0 and cam_select_alt_mode(0) == CAM_SELECTION_FIXED) or camera_is_frozen() then
        camText = gTextures.no_camera
    elseif set_cam_angle(0) == CAM_ANGLE_MARIO then
        camText = gTextures.mario_head
    else
        camText = gTextures.lakitu
    end
    djui_hud_render_texture(camText, x, y, 1, 1)
    djui_hud_render_texture(gTextures.camera, x - 16, y, 1, 1)
    if c.mode == CAMERA_MODE_C_UP then
        djui_hud_render_texture(gTextures.arrow_up, x - 12, y - 8, 1, 1)
    end
    if c.cutscene == 0 and (c.mode ~= CAMERA_MODE_C_UP and c.mode ~= CAMERA_MODE_BEHIND_MARIO) then
        if m.controller.buttonPressed & D_CBUTTONS ~= 0 then
            is_camera_cdown = true
        elseif m.controller.buttonPressed & U_CBUTTONS ~= 0 then
            is_camera_cdown = false
        end
    end
    if is_camera_cdown then
        djui_hud_render_texture(gTextures.arrow_down, x - 12, y + 16, 1, 1)
    end
end

local function on_hud_render() -- Handles the HUD layouts 
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(255, 255, 255, 255)
    screenWidth = djui_hud_get_screen_width()
    screenHeight = djui_hud_get_screen_height()
    halfScreenWidth = djui_hud_get_screen_width() / 2
    halfScreenHeight = djui_hud_get_screen_height() / 2
    djui_hud_set_font(FONT_HUD)

    hud_set_value(HUD_DISPLAY_LIVES, displayLives)
    --hud_set_value(HUD_DISPLAY_COINS, displaycoin)

    lives = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_LIVES))):gsub("-", "M")
    coins = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_COINS))):gsub("-", "M")
    stars = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_STARS))):gsub("-", "M")

    if obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then hud_hide() return end
    if gNetworkPlayers[0].currActNum == 99 then hud_hide() return end

    if hud_07_layout then ax = 18 xb = 30 else ax = 16 xb = 28 end

    if custom_hud then -- B-roll HUD layout
        hud_hide()

        render_lives_segment(28, 14, 1, 1)
        render_stars_segment((halfScreenWidth + 11), 14, 1, 1)
        render_coins_segment((halfScreenWidth + 11), 31, 1, 1)

        render_power_meter(halfScreenWidth - 51, 11, 1, 1)
        render_timer(hud_get_value(HUD_DISPLAY_TIMER), halfScreenWidth + 50, screenHeight - 40)
        --render_camera(screenWidth - 38, screenHeight - 35, 1)
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_hud_render)

hook_chat_command("custom-hud", "Shows or hides the custom hud",
function (msg)
    custom_hud = not custom_hud
    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gMarioStates[0].pos)
    hud_show()
    return true
end)

hook_chat_command("faithful-hud", "Toggles the b-roll HUD arrangement between the 0.7 and 1.0 layouts",
function (msg)
    if not custom_hud then custom_hud = true end
    hud_07_layout = not hud_07_layout
    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gMarioStates[0].pos)
    hud_show()
    return true
end)

hook_chat_command("reset-hud", "Forces the HUD back to default B3313 HUD settings)",
function (msg)
    custom_hud = true
    hud_07_layout = false
    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gMarioStates[0].pos)
    hud_show()
    return true
end)