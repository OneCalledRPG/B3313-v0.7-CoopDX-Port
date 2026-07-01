local star_display_areas = {
-- CASTLE, CASTLE_COURTYARD
    {name = "Vanilla Upstairs", course = 0, stars = {1,2}},
    {name = "Vanilla Basement", course = 0, stars = {0,3,4}},
    {name = "Uncanny Courtyard", course = 0, stars = {3,4}},
-- BOB
    {name = "Crimson Hallway", course = 1, stars = {3,4}},
    {name = "athletic", course = 1, stars = {5}},
    {name = "Goomba Hills", course = 1, stars = {0,1,2,4,6}},
-- WF
    {name = "Flooded Hideout", course = 2, stars = {0}},
    {name = "Lavish Lava Mountain", course = 2, stars = {3,4,5,6}},
-- JRB
    {name = "River Mountain", course = 3, stars = {0,2,3,6}},
    {name = "Piranha Plant Garden", course = 3, stars = {4,6}},
    {name = "Piranha's Igloo", course = 3, stars = {0,5}},
-- CCM
    {name = "Jolly Roger Lagoon", course = 4, stars = {0,2}},
    {name = "Orange Hall", course = 4, stars = {1}},
    {name = "Test Level", course = 4, stars = {6}},  
    {name = "Checkerboard 1", course = 4, stars = {3,4}},
-- BBH
    {name = "Whomp's Kingdom", course = 5, stars = {1,3,6}},
    {name = "Whomp's Prison", course = 5, stars = {0,2}},
    {name = "King Whomp's Battle Arena", course = 5, stars = {5}},
    {name = "Vanish Cap Under the Moat (Beta)", course = 5, stars = {4}},
-- HMC
    {name = "Tick Tock Blocks", course = 6, stars = {3,6}},
    {name = "Midnight Meadow", course = 6, stars = {1,4}},   
    {name = "Cave City", course = 6, stars = {2,5}},
-- LLL
    {name = "Blazing Bully Base", course = 7, stars = {0,1,2,5,6}},
    {name = "Infernal Tower", course = 7, stars = {4}},
    {name = "Fire Bubble (B-Roll)", course = 7, stars = {3}},
-- SSL
    {name = "Desert Maze", course = 8, stars = {0,1,6}},
    {name = "Shifted Sand Land", course = 8, stars = {3,4,6}},
    {name = "Eyerok's Tomb", course = 8, stars = {2}},
-- DDD
    {name = "Checkerboard 2", course = 9, stars = {0}},
    {name = "Snow Slide (B-Roll)", course = 9, stars = {0,1}},
    {name = "Snowman's Land (Beta)", course = 9, stars = {2}},
    {name = "Frosty Highlands", course = 9, stars = {4,5,6}},
-- SL
    {name = "Floating Hotel", course = 10, stars = {1}},
    {name = "Wing Cap by the Rainbow Highway", course = 10, stars = {0,3,4}},
    {name = "Rainbow Ride (Beta)", course = 10, stars = {4}},
    {name = "Vanish Cap within the Plexus", course = 10, stars = {2,5,6}},
-- WDW
    {name = "Snow Slide (Shoshinkai)", course = 11, stars = {0}},
    {name = "Cool, Cool Mountain (Beta)", course = 11, stars = {0}},
    {name = "Chief Chilly's Ring", course = 11, stars = {4}},
    {name = "Cold, Cold Crevasse", course = 11, stars = {2,3}},
    {name = "Chroma Tundra", course = 11, stars = {5,6}},
-- TTM
    {name = "Tall, Tall Mountain", course = 12, stars = {0,2,3,4,5,6}},
-- THI
    {name = "Bob-Omb Tower", course = 13, stars = {0,2,6}},
    {name = "Grassy Highlands", course = 13, stars = {4,5,6}},
    {name = "Minion Base", course = 13, stars = {3,6}},
    {name = "Peach's Cell", course = 13, stars = {1}},
-- TTC
    {name = "Big Boo's Haunted Forest", course = 14, stars = {1,2,3,6}},
    {name = "Big Boo's Fortress", course = 14, stars = {0}},
    {name = "Plexal Hallway", course = 14, stars = {5}},
    {name = "Bowser's Floor", course = 14, stars = {3}},
-- RR
    {name = "Jolly Roger Bay (Beta)", course = 15, stars = {0,3,4,5,6}},
    {name = "Checkerboard 3", course = 15, stars = {1,2}},
-- BITDW
    {name = "Tiny-Huge Island (Beta)", course = 16, stars = {0}},
    {name = "Creepy Cove", course = 16, stars = {1,2}},
    {name = "Sunken Castle", course = 16, stars = {4}},
-- BITFS
    {name = "Aquarium Limbo", course = 17, stars = {0,2}},
-- BITS
    {name = "Wet-Dry World (Beta)", course = 18, stars = {4,5}},
    {name = "Ice-Cold Warzone", course = 18, stars = {3}},
    {name = "Bob-Omb Battlefield (Beta)", course = 18, stars = {1,2,3}},
-- PSS
    {name = "Dark Downtown", course = 19, stars = {3}},
    {name = "castle2", course = 19, stars = {4}},
    {name = "Cubic Greens", course = 19, stars = {0}},
    {name = "Bob-Omb Village", course = 19, stars = {1,2,5}},
-- COTMC
    {name = "Mountain (B-Roll)", course = 20, stars = {0,1,2}},
    {name = "Goomboss Battle", course = 20, stars = {4}},
    {name = "Whomp's Fortress (Beta)", course = 20, stars = {3}},
    {name = "Tall Floating Fortress", course = 20, stars = {5}},
-- TOTWC
    {name = "Eel Graveyard", course = 21, stars = {0}},
    {name = "Checkerboard 4", course = 21, stars = {1,2,3,4,5}},
-- VCUTM
    {name = "Battle Fort", course = 22, stars = {2}},
    {name = "Bob-Omb Test Field", course = 22, stars = {0}},
    {name = "Big Bob-omb's Fortress", course = 22, stars = {1}},
-- WMOTR
    {name = "Water Land (Shoshinkai)", course = 23, stars = {0,1,2}},
    {name = "castle1", course = 23, stars = {3}},
-- SA
    {name = "Dry Town", course = 24, stars = {0,1}},
    {name = "Wiggler's Forest Fortress", course = 24, stars = {3}},
    {name = "Pleasant, Pleasant Falls", course = 24, stars = {2,4}},
    {name = "Sky-High Pathway", course = 24, stars = {5}},
-- ENDING
    {name = "Flooded Town", course = 25, stars = {0,1,2,3}},
}


local base_height = 83
local jump = 0
local page = 1
djui_hud_set_resolution(RESOLUTION_N64)
local jump_space = 140 --20 pixels per name + icon display * the 7 entries per peage
local max_height = 0

screenWidth = djui_hud_get_screen_width()
screenHeight = djui_hud_get_screen_height()
halfScreenWidth = djui_hud_get_screen_width() / 2
halfScreenHeight = djui_hud_get_screen_height() / 2

--local starId = 0
local function on_interact(m, o, type)
    if type == INTERACT_STAR_OR_KEY then
        if get_id_from_behavior(o.behavior) == id_bhvStar then
            starId = (o.oBehParams >> 24) --& 0x1F
            gStarId = (7 * gNetworkPlayers[0].currCourseNum) + starId
            djui_chat_message_create("ID: "..tostring(starId))
            djui_chat_message_create("Global ID: "..tostring(gStarId))
            --o.oBehParams = gStarId << 24
        end
    end
end

local cooldown = 5
local cooldownCounter = 0
local previousStickY = 0
local max_pages = 12
total_stars = 146

-- From pause screen template, retooled for star display
local function menu_controls(options)
    local stickY = gMarioStates[0].controller.stickY

    if stickY * previousStickY <= 0 then
        cooldownCounter = cooldownCounter // 2
    end

    if cooldownCounter > 0 then
        cooldownCounter = cooldownCounter - 1
    else
        if gMarioStates[0].controller.buttonPressed & U_JPAD ~= 0 or stickY > 20 then
            if page > 1 then
                jump = jump + jump_space
                page = page - 1
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            else
                jump = jump - (jump_space * (max_pages - 1))
                page = page + (max_pages - 1)
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            end
            cooldownCounter = cooldown
        elseif gMarioStates[0].controller.buttonPressed & D_JPAD ~= 0 or stickY < -20 then
            if page < max_pages then
                jump = jump - jump_space
                page = page + 1
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            else
                jump = jump + (jump_space * (max_pages - 1))
                page = page - (max_pages - 1)
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
            end
            cooldownCounter = cooldown
        end
    end
    previousStickY = stickY
end

TEX_STAR_UNCOLLECTED = get_texture_info("star_tracker_uncollected")
TEX_100_COIN = get_texture_info("hud_100")

local function on_hud_render()
    if not is_game_paused() then extended_star_tracker = false return end
    if not extended_star_tracker then return end

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(0, 0, 0, 192)
    djui_hud_render_rect(halfScreenWidth - 85, base_height - 5, 170, 148)
    djui_hud_set_color(0, 0, 0, 128)
    djui_hud_render_rect(halfScreenWidth - 83, base_height - 3, 166, 144)
    djui_hud_set_color(255, 255, 255, 255)
    local height = 0

    djui_hud_set_color(0, 0, 25, 128)
    djui_hud_render_rect(0, 0, screenWidth + 20, screenHeight)
    djui_hud_set_color(255, 255, 255, 255)

    djui_hud_set_font(FONT_HUD)
    djui_hud_print_text("STAR TRACKER", screenWidth * 0.5 - (djui_hud_measure_text("STAR TRACKER") /2), (screenHeight * 0.55) - 75, 1 )

    menu_controls()

    for i = 1, #star_display_areas do
        table.sort(star_display_areas, function (a, b)
            return string.upper(a.name) < string.upper(b.name)
        end)
        max_height = max_height + 1
        djui_hud_set_font(FONT_TINY)
        if (20 * height) + base_height + jump >= base_height and (20 * height) + base_height + jump < 210 then
            djui_hud_print_text(star_display_areas[i].name, halfScreenWidth - 78, 20 * height + base_height + jump, 0.5)
        end
        local starFlags = save_file_get_star_flags(get_current_save_file_num() - 1, star_display_areas[i].course - 1)
        djui_hud_set_font(FONT_HUD)
        for z = 1, #star_display_areas[i].stars do
            if (20 * height) + base_height + jump >= base_height and (20 * height) + base_height + jump < 210 then
                if starFlags & (1 << star_display_areas[i].stars[z]) ~= 0 then
                    djui_hud_render_texture(gTextures.star, 8 * (z - 1) + halfScreenWidth - 78, 20 * height + 10 + base_height + jump, 0.5, 0.5)
                else
                    djui_hud_render_texture(TEX_STAR_UNCOLLECTED, 8 * (z - 1) + halfScreenWidth - 78, 20 * height + 10 + base_height + jump, 0.5, 0.5)
                end
                if (star_display_areas[i].course > 0 and star_display_areas[i].course <= 15 and star_display_areas[i].course ~= 4) and star_display_areas[i].stars[z] == 6 then
                    djui_hud_render_texture(TEX_100_COIN, 8 * (#star_display_areas[i].stars - 1) + halfScreenWidth - 78, 20 * height + 10 + base_height + jump, 0.5, 0.5)
                end
            end
        end
        if height < max_height then
            height = height + 1
        end
    end

    local starDisplayRotateTextures = {
        [0] = get_texture_info("hud_star_seg3_texture_1"),
        [1] = get_texture_info("hud_star_seg3_texture_2"),
        [2] = get_texture_info("hud_star_seg3_texture_3"),
        [3] = get_texture_info("hud_star_seg3_texture_4"),
        [4] = get_texture_info("hud_star_seg3_texture_5"),
        [5] = get_texture_info("hud_star_seg3_texture_6"),
        [6] = get_texture_info("hud_star_seg3_texture_7"),
        [7] = get_texture_info("hud_star_seg3_texture_8"),
        [8] = get_texture_info("hud_star_seg3_texture_1"),
    }
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_render_texture(starDisplayRotateTextures[math.floor(gMarioStates[0].marioObj.oTimer / 2) % #starDisplayRotateTextures], halfScreenWidth + 21, 125, 1.5, 1.5) -- spin code by Isaac
    
    djui_hud_set_font(FONT_TINY)
    djui_hud_set_color(255, 255, 0, 255)
    djui_hud_print_text("Page:  ", halfScreenWidth + 56 - djui_hud_measure_text("Stars Collected:")*0.75*0.5, 82, 0.75)
    djui_hud_set_color(255, 255, 192, 255)
    djui_hud_print_text("       ".. page.. "/"..max_pages, halfScreenWidth + 56 - djui_hud_measure_text("Stars Collected:")*0.75*0.5, 82, 0.75)

    djui_hud_set_color(255, 255, 0, 255)
    djui_hud_print_text("Stars Collected:", halfScreenWidth + 45 - djui_hud_measure_text("Stars Collected:")*0.75*0.5, 200, 0.75)
    djui_hud_set_color(255, 255, 192, 255)
    djui_hud_print_text(tostring(gMarioStates[0].numStars).." / "..total_stars, halfScreenWidth + 45 - djui_hud_measure_text(tostring(gMarioStates[0].numStars).." / xxx")*0.75*0.5, 210, 0.75)
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
-- Debug stuff: hook_event(HOOK_ON_INTERACT, on_interact)