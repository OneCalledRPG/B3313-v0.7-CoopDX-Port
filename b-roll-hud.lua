--name: Custom HUD Template - B3313 B-Roll HUD
--description: A customizable template that changes the in game HUDs. Modified for use in B3313 (0.7)

custom_hud = true
currHUD = 1

local life_icons = {
    [CT_MARIO] = gTextures.mario_head,
    [CT_LUIGI] = gTextures.luigi_head,
    [CT_TOAD] = gTextures.toad_head,
    [CT_WALUIGI] = gTextures.waluigi_head,
    [CT_WARIO] = gTextures.wario_head,
}

local powerMeters = {
    ["left"] = {
        [1] = get_texture_info("b_roll_pm_left")
    },
    ["right"] = {
        [1] = get_texture_info("b_roll_pm_right")
    },
    [1] = {
        [1] = get_texture_info("b_roll_pm_1")
    },
    [2] = {
        [1] = get_texture_info("b_roll_pm_2")
    },
    [3] = {
        [1] = get_texture_info("b_roll_pm_3")
    },
    [4] = {
        [1] = get_texture_info("b_roll_pm_4")
    },
    [5] = {
        [1] = get_texture_info("b_roll_pm_5")
    },
    [6] = {
        [1] = get_texture_info("b_roll_pm_6")
    },
    [7] = {
        [1] = get_texture_info("b_roll_pm_7")
    },
    [8] = {
        [1] = get_texture_info("b_roll_pm_8")
    }
}

-- OLD FUNCTIONS FOR OLDER VERSIONS OF CS
--[[function render_custom_char_icon(x, y, scaleW, scaleH) -- Determines the character icon (compatibility with Character Select)
    if _G.charSelectExists then
        local lifeIcon = _G.charSelect.character_get_current_table().lifeIcon
        if lifeIcon == nil then
            djui_hud_print_text("?", x, y, 1)
        else
            djui_hud_render_texture(lifeIcon, x, y, scaleW * 16/lifeIcon.width, scaleH * 16/lifeIcon.height) -- 0.0625 is 1/16
        end
    else
        djui_hud_render_texture(life_icons[gMarioStates[0].character.type], x, y, scaleW, scaleH)
    end
end]]

--[[function render_custom_star_icon(x, y, scaleW, scaleH) -- Determines the character icon (compatibility with Character Select)
    if _G.charSelectExists then
        local starIcon = _G.charSelect.character_get_current_table().starIcon
        if starIcon == nil then
            djui_hud_render_texture(gTextures.star, x, y, scaleW, scaleH)
        else
            djui_hud_render_texture(starIcon, x, y, scaleW * 16/starIcon.width, scaleH * 16/starIcon.height) -- 0.0625 is 1/16
        end
    else
        djui_hud_render_texture(gTextures.star, x, y, scaleW, scaleH)
    end
end]]

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

    --if not gPlayerSyncTable[0].vanillaMario then
        djui_hud_render_texture(powerMeters["left"][currHUD], x, y + ascendValue, scaleW, scaleH)
        djui_hud_render_texture(powerMeters["right"][currHUD], x + 32, y + ascendValue, scaleW, scaleH)
        if health > 0 then
            djui_hud_render_texture(powerMeters[health][currHUD], (x + 16), (y + 16) + ascendValue, scaleW, scaleH)
        end
    --else
    --    djui_hud_set_color(255, 255, 255, 255)
    --    hud_render_power_meter(gMarioStates[0].health, x, y + ascendValue, scaleW, scaleH)
    --end
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

local check_hud_value_on_launch = true
local function on_hud_render() -- Handles the HUD layouts 

    hud_set_value(HUD_DISPLAY_LIVES, displayLives)
    --hud_set_value(HUD_DISPLAY_COINS, displaycoin)

    --if custom_hud == false then return end

    if obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then return end
    if gNetworkPlayers[0].currActNum == 99 then return end
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(255, 255, 255, 255)
    screenWidth = djui_hud_get_screen_width()
    screenHeight = djui_hud_get_screen_height()
    halfScreenWidth = djui_hud_get_screen_width() / 2
    halfScreenHeight = djui_hud_get_screen_height() / 2
    djui_hud_set_font(FONT_HUD)

    lives = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_LIVES))):gsub("-", "M")
    coins = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_COINS))):gsub("-", "M")
    stars = tostring(string.format("%02d", hud_get_value(HUD_DISPLAY_STARS))):gsub("-", "M")

    if check_hud_value_on_launch then 
        if (hud_get_value(HUD_DISPLAY_FLAGS) & HUD_DISPLAY_FLAG_LIVES) ~= 0 then
            ogLivesValue = 1
        else ogLivesValue = 0 end
        check_hud_value_on_launch = false
    end

    if custom_hud then -- B-roll HUD layout
        hud_hide()

        --Lives
        --if (hud_get_value(HUD_DISPLAY_FLAGS) & HUD_DISPLAY_FLAG_LIVES) ~= 0 then
        if ogLivesValue ~= 0 then
            if _G.charSelectExists then
                _G.charSelect.character_render_life_icon(0, 28, 14, 1)
            else
                djui_hud_render_texture(life_icons[gMarioStates[0].character.type], 28, 14, 1, 1)
            end
            djui_hud_print_text("@", 28 + 16, 14, 1)
            djui_hud_print_text(lives, 28 + 28, 14, 1)
        end

        --Coins
        djui_hud_render_texture(gTextures.coin, halfScreenWidth + 11, 31, 1, 1)
        djui_hud_print_text("@", halfScreenWidth + 11 + 16, 31, 1)
        djui_hud_print_text(coins, halfScreenWidth + 11 + 28, 31, 1)

        --Stars
        if _G.charSelectExists then
            _G.charSelect.character_render_star_icon(0, halfScreenWidth + 11, 14, 1)
        else
            djui_hud_render_texture(gTextures.star, halfScreenWidth + 11, 14, 1, 1)
        end
        djui_hud_print_text("@", halfScreenWidth + 11 + 16, 14, 1)
        djui_hud_print_text(stars, halfScreenWidth + 11 + 28, 14, 1)

        render_power_meter(halfScreenWidth - 51, 11, 1, 1)
        render_timer(hud_get_value(HUD_DISPLAY_TIMER), halfScreenWidth + 50, screenHeight - 40)
        --render_camera(screenWidth - 38, screenHeight - 35, 1)

    else  -- temp fix for incorrect lives value with CS. Other HUD mods will still display incorrectly
        if _G.charSelectExists then
            local hudDisplayFlags = hud_get_value(HUD_DISPLAY_FLAGS)
            hud_set_value(HUD_DISPLAY_FLAGS, hudDisplayFlags & ~HUD_DISPLAY_FLAGS_LIVES)
            local x = 22
            local y = 15 -- SCREEN_HEIGHT - 209 - 16
            if _G.charSelectExists then
                _G.charSelect.character_render_life_icon(0, x, y, 1)
            else djui_hud_render_texture(life_icons[gMarioStates[0].character.type], x, y, 1, 1) end
            djui_hud_print_text("@", x + 16, y, 1)
            djui_hud_print_text(tostring(hud_get_value(HUD_DISPLAY_LIVES)):gsub("-", "M"), x + 32, y, 1)
        end
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