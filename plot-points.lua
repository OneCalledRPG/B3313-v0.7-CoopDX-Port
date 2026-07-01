-- Brought to you by Floralys

local m = gMarioStates[0]
local introDialogue = true
local cGroundsDialogue = false
local lobbyDialogue = false
local course1Dialogue = false
local course2Dialogue = false
local course3Dialogue = false
local course4Dialogue = false
local riverDialogue = true
local battlefieldDialogue = true
local crevasseDialogue = true
local sewerDialogue = false
local cakeDialogue = false
local dialogDelay = 0
local force_ending_warp = false
local flash_fix = false
local countdown_to_credits = 0
local max_rbc = 9
yellowSwitch = false
yellowSwitchPressCount = 0
ysDialogNumber = 0
yellowSwitchDialog = true
yellowSwitchCapState = 0
capBuffer = false
betterCoinCompat = false

hook_event(HOOK_ON_MODS_LOADED, function()
    for i = 0, #gActiveMods, 1 do
	    if gActiveMods[i].name:find("Better Coins") then
		    betterCoinCompat = true
	    end
    end
end)

-- Hide Peach's dialogue text during the credits
function hide_peach_dialog()
    djui_hud_set_resolution(RESOLUTION_N64)
    if gMarioStates[0].action == ACT_END_PEACH_CUTSCENE then
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(0, screenHeight - 30, screenWidth + 1, screenHeight)
        djui_hud_render_rect(0, 0, screenWidth + 1, 30)
    end

    -- Fix a one frame flash of castle grounds
    if flash_fix then
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(0, 0, screenWidth + 1, screenHeight + 1)
    end
end
hook_event(HOOK_ON_HUD_RENDER, hide_peach_dialog)

---@param m MarioState
hook_event(HOOK_MARIO_UPDATE, function(m)
    if m.playerIndex ~= 0 then return end

    local spawning_action = ACT_SPAWN_SPIN_AIRBORNE or ACT_SPAWN_NO_SPIN_AIRBORNE

    -- Intro text
    if (gNetworkPlayers[0].currLevelNum == LEVEL_THI and gNetworkPlayers[0].currAreaIndex == 1) then
        if introDialogue then
            dialogDelay = dialogDelay + 1
            if dialogDelay >= 2 then
                --cutscene_object_with_dialog(CUTSCENE_DIALOG, gMarioStates[0].marioObj, DIALOG_033) -- For 0.9 intro
                create_dialog_box(DIALOG_B3313_INTRO_AND_WARNING)  -- For 0.7 intro
                introDialogue = false
                dialogDelay = 0
            end
        end
        if m.action == spawning_action then cGroundsDialogue = true end
        if cGroundsDialogue and m.action ~= spawning_action and not introDialogue then
            create_dialog_box(DIALOG_CASTLE_ENTRY)
            cGroundsDialogue = false
        end
    end
    --  Castle grounds entry (excluding starting castle grounds)
    if (gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and gNetworkPlayers[0].currAreaIndex == 1) then
        if m.action == spawning_action then cGroundsDialogue = true end
        if cGroundsDialogue and m.action ~= spawning_action then
            create_dialog_box(DIALOG_CASTLE_ENTRY)
            cGroundsDialogue = false
        end
    end
    -- First lobby entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and (gNetworkPlayers[0].currAreaIndex == 3 or gNetworkPlayers[0].currAreaIndex == 4)) then
        if m.action ~= spawning_action and m.action ~= ACT_WARP_DOOR_SPAWN and lobbyDialogue then  
            create_dialog_box(DIALOG_LOBBY_ENTRY)
            lobbyDialogue = false
        elseif (m.action == ACT_WARP_DOOR_SPAWN) and lobbyDialogue then
            dialogDelay = dialogDelay + 1
            if dialogDelay >= 30 then
                if m.pos.y <= -67 then
                    create_dialog_box(DIALOG_LOBBY_ENTRY)
                end
                lobbyDialogue = false
                dialogDelay = 0
            end
        end
    end
    -- Genesis Basement entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and gNetworkPlayers[0].currAreaIndex == 5) then
        if m.action == ACT_WARP_DOOR_SPAWN then lobbyDialogue = false end
        if m.action ~= spawning_action and lobbyDialogue then  
            create_dialog_box(DIALOG_LOBBY_ENTRY)
            lobbyDialogue = false
        end
    end
    -- Mountain (B-Roll) entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_COTMC and gNetworkPlayers[0].currAreaIndex == 1) then
        if not course1Dialogue and m.action == spawning_action then course1Dialogue = true end
        if m.action ~= spawning_action and course1Dialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_MOUNTAIN_ENTRY)
            end
            course1Dialogue = false
        end
    end
    -- Fire Bubble (B-Roll) entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_LLL and (gNetworkPlayers[0].currAreaIndex == 1 or gNetworkPlayers[0].currAreaIndex == 5)) then
        if not course2Dialogue and m.action == spawning_action then course2Dialogue = true end
        if m.action ~= spawning_action and course2Dialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_FIREBUBBLE_ENTRY)
            end
            course2Dialogue = false
        end
    end
    -- Snow Slide (B-Roll) entry
    if ((gNetworkPlayers[0].currLevelNum == LEVEL_DDD and gNetworkPlayers[0].currAreaIndex == 5) or (gNetworkPlayers[0].currLevelNum == LEVEL_WDW and gNetworkPlayers[0].currAreaIndex == 1)) then
        if not course3Dialogue and m.action == spawning_action then course3Dialogue = true end
        if m.action ~= spawning_action and course3Dialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_SNOWSLIDE_ENTRY)
            end
            course3Dialogue = false
        end
    end
    -- Water Land (Shoshinkai) entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_WMOTR and gNetworkPlayers[0].currAreaIndex == 1) then
        if not course4Dialogue and m.action == spawning_action then course4Dialogue = true end
        if m.action ~= spawning_action and course4Dialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_WATERLAND_ENTRY)
            end
            course4Dialogue = false
        end
    end
    -- River Mountain entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_JRB and gNetworkPlayers[0].currAreaIndex == 1) then
        if not riverDialogue and m.action == spawning_action then riverDialogue = true end
        if m.action ~= spawning_action and riverDialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_RIVER_ENTRY)
            end
            riverDialogue = false
        end
    end
    -- Bob-Omb Battlefield entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_BITS and gNetworkPlayers[0].currAreaIndex == 4) then
        if not battlefieldDialogue and m.action == spawning_action then battlefieldDialogue = true end
        if m.action ~= spawning_action and battlefieldDialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_BATTLEFIELD_ENTRY)
            end
            battlefieldDialogue = false
        end
    end
    -- Cold Cold Crevasse entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_WDW and gNetworkPlayers[0].currAreaIndex == 6) then
        if not crevasseDialogue and m.action == spawning_action then crevasseDialogue = true end
        if m.action ~= spawning_action and crevasseDialogue then
            if (areaStarCount < 1) then
                create_dialog_box(DIALOG_CREVASSE_ENTRY)
            end
            crevasseDialogue = false
        end
    end
    -- Scary Sewer Maze entry
    if (gNetworkPlayers[0].currLevelNum == LEVEL_SSL and gNetworkPlayers[0].currAreaIndex == 3) then
        if m.action ~= spawning_action and sewerDialogue then
            create_dialog_box(DIALOG_SEWER_ENTRY)
            sewerDialogue = false
        end
    end
    -- Cake text
    if (gNetworkPlayers[0].currLevelNum == LEVEL_DDD and gNetworkPlayers[0].currAreaIndex == 4 and gNetworkPlayers[0].currActNum == 99) then 
        if m.action ~= spawning_action and cakeDialogue then
            local PeachNPC = obj_get_first_with_behavior_id(bhvB3313Peach)
            if PeachNPC ~= nil then
                cutscene_object_with_dialog(CUTSCENE_DIALOG, PeachNPC, DIALOG_CAKE_ENTRY)
            end
            cakeDialogue = false
        end
    end

    -- Jumbo Star Cutscene interrupt
    if m.action == ACT_JUMBO_STAR_CUTSCENE and m.actionTimer >= 483 then
        force_ending_warp = true
        --[[if transition == 0 then
            play_transition(WARP_TRANSITION_FADE_INTO_STAR, 15, 0, 0, 0)
            transition = 1
        end
        warp_delay = warp_delay + 1
        if warp_delay >= 19 then
            warp_to_warpnode(LEVEL_WF, 1, 0, 10)
            warp_delay = 0
            transition = 0
        end]]
    end

    -- Force the intended ending without the weird post-game sheninigans Coop does. Also puts you at the same spot if you skip the credits or not
    if (gNetworkPlayers[0].currLevelNum == LEVEL_THI and gNetworkPlayers[0].currAreaIndex == 1) and force_ending_warp then
        warp_to_warpnode(LEVEL_BITFS, 4, 99, 10)
        currLives = currLives + 1
        force_ending_warp = false
        flash_fix = false
        countdown_to_credits = 0
    end 

    if m.action == ACT_END_PEACH_CUTSCENE then
        countdown_to_credits = countdown_to_credits + 1
        if countdown_to_credits >= 3215 then
            flash_fix = true
        end
        --djui_chat_message_create(tostring(countdown_to_credits))
    end

    -- Change Mario's hat after pressing the yellow switch
    if yellowSwitchCapState > 0 and not capBuffer then
        if (m.flags == m.flags | MARIO_WING_CAP and not fakewings) or (m.flags == m.flags | MARIO_VANISH_CAP) or (m.flags == m.flags | MARIO_METAL_CAP) then return 
        else
            m.flags = m.flags & ~MARIO_CAP_ON_HEAD
        end
    end
end)

--On interact
function on_interact(m, o, intType, interacted)
    local s = gStateExtras[m.playerIndex]
    local np = gNetworkPlayers[0]
    print(get_behavior_name_from_id(get_id_from_behavior(o.behavior)))

    local yellowSwitchPalace = gNetworkPlayers[0].currLevelNum == LEVEL_CCM and ((gNetworkPlayers[0].currAreaIndex == 5) or (gNetworkPlayers[0].currAreaIndex == 6))
    if (obj_has_behavior_id(o,bhvSecretBobomb)) ~= 0 then
        if yellowSwitchPalace then
            if yellowSwitch then
                o.oBehParams2ndByte = DIALOG_BOBOMB_WARNING_2
            end
        else
            if yellowSwitchPressCount < 13 then
                o.oBehParams2ndByte = DIALOG_BOBOMB_SECRET_1
            else
                o.oBehParams2ndByte = DIALOG_BOBOMB_SECRET_2
            end
        end
    end
    if (obj_has_behavior_id(o,bhvB3313Peach)) ~= 0 and ((m.controller.buttonPressed & B_BUTTON) + (m.action & ACT_FLAG_ATTACKING) ~= 0) then
        play_sound(SOUND_ACTION_TELEPORT, m.marioObj.header.gfx.cameraToObject)
        obj_mark_for_deletion(o)
        if m.action & ACT_FLAG_AIR == 0 then
            set_mario_action(m, ACT_PUNCHING, 0)
        end
    end
    if (obj_has_behavior_id(o,bhvB3313PlayerNPC) ~= 0) and (obj_has_model_extended(o, E_MODEL_BEEIE_CHUNGUS) ~= 0) then
        if ((m.controller.buttonPressed & B_BUTTON) ~= 0) or (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            audio_sample_stop(SOUND_BETA_CHUNGUS)
            audio_sample_play(SOUND_BETA_CHUNGUS, playerNPC_pos, 0.65)
        end
        if (gNetworkPlayers[0].currLevelNum == LEVEL_VCUTM and gNetworkPlayers[0].currAreaIndex == 4) then
            o.oBehParams2ndByte = DIALOG_BC_1
        elseif (gNetworkPlayers[0].currLevelNum == LEVEL_BOB and gNetworkPlayers[0].currAreaIndex == 4) then
            o.oBehParams2ndByte = DIALOG_BC_3
        else
            o.oBehParams2ndByte = DIALOG_BC_2
        end
    end

    if (obj_has_behavior_id(o,id_bhvYoshi)) ~= 0 then
        if  m.numStars >= total_stars and o.oBehParams2ndByte == 75 then
            o.oBehParams2ndByte = DIALOG_YOSHI_ALL_STARS
        end
    end
end
hook_event(HOOK_ON_INTERACT, on_interact)

-- 1up replacement code by IncredibleHolc
local function before_phys_step(m,stepType) --Called once per player per frame before physics code is run, return an integer to cancel it with your own step result
    local m = gMarioStates[0]
    if m.playerIndex ~= 0 then
        return
    end
	
    local Standard1up = obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1Up) 
    if Standard1up ~= nil and (nearest_interacting_mario_state_to_object(Standard1up)).playerIndex == 0 and is_within_100_units_of_mario(Standard1up.oPosX, Standard1up.oPosY, Standard1up.oPosZ) == 1 then --if local mario is touching 1up then
        obj_mark_for_deletion(Standard1up)
        --m.numLives = m.numLives - 1
        audio_sample_play(SOUND_BETA_FAKE_1UP, m.pos, 3)
    end
end
hook_event(HOOK_BEFORE_PHYS_STEP, before_phys_step)

function green_demon(unloadedObj)
    nearest = nearest_mario_state_to_object(unloadedObj)
    if (get_id_from_behavior(unloadedObj.behavior) == id_bhvHidden1upInPole and nearest.playerIndex == 0) then
        if (obj_has_model_extended(unloadedObj, E_MODEL_NONE) ~= 0) or (obj_has_model_extended(unloadedObj, E_MODEL_FACELESS_A) ~= 0) then
		    m.health = 0
            m.numLives = m.numLives - 1
        else
            m.numLives = m.numLives - 1
            audio_sample_play(SOUND_BETA_FAKE_1UP, m.pos, 3)
        end
    end
end
hook_event(HOOK_ON_OBJECT_UNLOAD, green_demon)

-- Set box content
set_exclamation_box_contents({
    {id = 0, unused = 0, firstByte = 0, model = E_MODEL_MARIOS_WING_CAP, behavior = id_bhvWingCap },
    {id = 1, unused = 0, firstByte = 0, model = E_MODEL_MARIOS_METAL_CAP, behavior = id_bhvMetalCap },
    {id = 2, unused = 0, firstByte = 0, model = E_MODEL_MARIOS_CAP, behavior = id_bhvVanishCap },
    {id = 3, unused = 0, firstByte = 0, model = E_MODEL_KOOPA_SHELL, behavior = id_bhvKoopaShell },
    {id = 4, unused = 0, firstByte = 0, model = E_MODEL_YELLOW_COIN, behavior = id_bhvSingleCoinGetsSpawned },
    {id = 5, unused = 0, firstByte = 0, model = E_MODEL_NONE, behavior = id_bhvThreeCoinsSpawn },
    {id = 6, unused = 0, firstByte = 0, model = E_MODEL_NONE, behavior = id_bhvTenCoinsSpawn },
    {id = 7, unused = 0, firstByte = 0, model = E_MODEL_1UP, behavior = id_bhv1upWalking },
    {id = 8, unused = 0, firstByte = 0, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    {id = 9, unused = 0, firstByte = 0, model = E_MODEL_1UP, behavior = id_bhv1upRunningAway },
    {id = 10, unused = 0, firstByte = 1, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    {id = 11, unused = 0, firstByte = 2, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    {id = 12, unused = 0, firstByte = 3, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    {id = 13, unused = 0, firstByte = 4, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    {id = 14, unused = 0, firstByte = 5, model = E_MODEL_STAR, behavior = id_bhvSpawnedStar },
    --{id = 15, unused = 0, firstByte = 0, model = E_MODEL_NONE, behavior = nil}, -- End of vanilla behaviors, also is literally blank
    {id = 16, unused = 0, firstByte = 0, model = E_MODEL_BLACK_BOBOMB, behavior = bhvSecretBobomb },
    {id = 17, unused = 0, firstByte = 1, model = E_MODEL_BLACK_BOBOMB, behavior = id_bhvBobomb },
    {id = 18, unused = 0, firstByte = 0, model = E_MODEL_FACELESS_B, behavior = id_bhvBreakableBoxSmall },
    {id = 19, unused = 0, firstByte = 0, model = E_MODEL_FACELESS_A, behavior = id_bhvHidden1upInPole },
    {id = 20, unused = 0, firstByte = 0, model = E_MODEL_1UP, behavior = id_bhvHidden1upInPole },
    {id = 21, unused = 0, firstByte = 0, model = E_MODEL_BEEIE_CHUNGUS, behavior = bhvB3313PlayerNPC },
    {id = 22, unused = 0, firstByte = 0, model = E_MODEL_GOOMBA, behavior = id_bhvGoomba },
    {id = 23, unused = 0, firstByte = 0, model = E_MODEL_CHUCKYA, behavior = id_bhvChuckya },
    {id = 24, unused = 0, firstByte = 0, model = E_MODEL_FLYGUY, behavior = id_bhvFlyGuy },
    {id = 25, unused = 0, firstByte = 0, model = E_MODEL_KLEPTO, behavior = id_bhvKlepto },
    {id = 26, unused = 0, firstByte = 0, model = E_MODEL_NONE, behavior = bhvKillmaPlumber }
})

-- Placing extra 1ups (some had to be removed from the level bins to work just right)
hook_event(HOOK_ON_SYNC_VALID, function()
    -- Mario's Maze fix
    if gNetworkPlayers[0].currLevelNum == LEVEL_BITDW and gNetworkPlayers[0].currAreaIndex == 6 then
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_FACELESS_A, 5610, 0, 1342, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)	
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_FACELESS_A, 603, 0, -4945, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_FACELESS_A, 53817, 0, -9882, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_FACELESS_A, 1050, 0, 1085, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)
        spawn_sync_object(id_bhvUnagi, E_MODEL_FACELESS_B, 3705,0,-4656, nil)
        spawn_sync_object(id_bhvUnagi, E_MODEL_FACELESS_B, 4278,0,955, nil)
    end
    -- Empty HMC fix
    if gNetworkPlayers[0].currLevelNum == LEVEL_HMC and gNetworkPlayers[0].currAreaIndex == 1 then
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_NONE, -759, 2056, 8003, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)	
    end
    -- Sinister Clockwork fix
    if gNetworkPlayers[0].currLevelNum == LEVEL_COTMC and gNetworkPlayers[0].currAreaIndex == 3 then
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_NONE, gMarioStates[0].pos.x, gMarioStates[0].pos.y + 100, gMarioStates[0].pos.z + 3000, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)	
    end
    -- Cryptic Hideout fix
    if gNetworkPlayers[0].currLevelNum == LEVEL_BITFS and gNetworkPlayers[0].currAreaIndex == 3 then
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_NONE, -1062, 416, -28561, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)	
    end
    -- Bowser's Bridge fix
    if gNetworkPlayers[0].currLevelNum == LEVEL_TTM and gNetworkPlayers[0].currAreaIndex == 5 then
        spawn_sync_object(id_bhvHidden1upInPole, E_MODEL_NONE, gMarioStates[0].pos.x, gMarioStates[0].pos.y + 100, gMarioStates[0].pos.z + 3000, function(o) o.oBehParams2ndByte = 2 o.oAction = 3 end)	
    end

    -- Spawn back up star boxes for Crimson Hall and Wing Cap by the Rainbow Highway (in case ya missed MIPs 1)
    if (gNetworkPlayers[0].currLevelNum == LEVEL_BOB and gNetworkPlayers[0].currAreaIndex == 1) then
        if save_file_get_flags() & SAVE_FLAG_COLLECTED_MIPS_STAR_1 ~= 0 then
            if save_file_get_star_flags(get_current_save_file_num() - 1, COURSE_BOB - 1) & (1 << 3) == 0 then
                if box_spawn == nil then
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 808, 300, 2319, function(o) o.oBehParams2ndByte = 12 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            end
        end
    end
    if (gNetworkPlayers[0].currLevelNum == LEVEL_SL and gNetworkPlayers[0].currAreaIndex == 3) then
        if save_file_get_flags() & SAVE_FLAG_COLLECTED_MIPS_STAR_1 ~= 0 then
            if save_file_get_star_flags(get_current_save_file_num() - 1, COURSE_SL - 1) & (1 << 3) == 0 then
                if box_spawn == nil then
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 3941, 4124, 3504, function(o) o.oBehParams2ndByte = 12 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            end
        end
    end

    -- Silly boxes
    local box_spawn = obj_get_first_with_behavior_id(bhvCustomBoxSpawn)
    if yellowSwitch then
        if gNetworkPlayers[0].currLevelNum == LEVEL_BOB then
            if gNetworkPlayers[0].currAreaIndex == 4 then
                if box_spawn == nil then
                    random_box_contents = math.random(0,max_rbc)
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -4473, 3000, -2554, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            elseif gNetworkPlayers[0].currAreaIndex == 7 then
                if box_spawn == nil then
                    random_box_contents = math.random(0,max_rbc)
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 2038, 294, 13351, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_WF and gNetworkPlayers[0].currAreaIndex == 3 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -11713, 300, 7469, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 1072, 459, -91, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_JRB and gNetworkPlayers[0].currAreaIndex == 1 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 6721, 1217, -11704, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_SL and gNetworkPlayers[0].currAreaIndex == 1 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 5240, 300, -8866, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and gNetworkPlayers[0].currAreaIndex == 5 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -2002, -1520, 666, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -8778, -712, -3980, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -7202, 300, -12954, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_COURTYARD then
            if gNetworkPlayers[0].currAreaIndex == 1 then
                if box_spawn == nil then
                    random_box_contents = math.random(0,max_rbc)
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -6754, -947, -17396, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            elseif gNetworkPlayers[0].currAreaIndex == 7 then
                if box_spawn == nil then
                    random_box_contents = math.random(0,max_rbc)
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -4638, -947, -11186, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                    spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
                end
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_VCUTM and gNetworkPlayers[0].currAreaIndex == 2 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, -12286, 1926, -24216, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 7445, 1058, -10912, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end
        if gNetworkPlayers[0].currLevelNum == LEVEL_WMOTR and gNetworkPlayers[0].currAreaIndex == 5 then
            if box_spawn == nil then
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 10161, -1016, -5555, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 10161, -1016, -5855, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                random_box_contents = math.random(0,max_rbc)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 10161, -1016, -5255, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, 9680, -1016, -7060, function(o) o.oBehParams2ndByte = 26 end)
                spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
            end
        end

        --Replace Empty Boxes
        local EmptyBox = obj_get_first_with_behavior_id(id_bhvExclamationBox)
        if box_spawn == nil then
            while EmptyBox ~= nil and (EmptyBox.oBehParams2ndByte == 15) do
                if obj_has_behavior_id(EmptyBox, id_bhvExclamationBox) ~= 0 then
                    boxPOS = {x = EmptyBox.oPosX, y = EmptyBox.oPosY, z = EmptyBox.oPosZ}
                    obj_mark_for_deletion(EmptyBox)
                    random_box_contents = math.random(0,max_rbc)
                    spawn_sync_object(id_bhvExclamationBox, E_MODEL_EXCLAMATION_BOX, boxPOS.x, boxPOS.y, boxPOS.z, function(o) o.oBehParams2ndByte = random_box_contents + 16 end)
                end
                EmptyBox = obj_get_next_with_same_behavior_id(EmptyBox)
            end
            spawn_sync_object(bhvCustomBoxSpawn, E_MODEL_NONE, 0, 0, 0, nil)
        end

        --Aggressive Bobomb Buddies
        local bobBuddy = obj_get_first_with_behavior_id(id_bhvBobombBuddy)
        while bobBuddy ~= nil do
            if obj_has_behavior_id(bobBuddy, id_bhvBobombBuddy) ~= 0 and obj_has_model_extended(bobBuddy, E_MODEL_BOBOMB_BUDDY) ~= 0 then
                bobBuddyPOS = {x = bobBuddy.oPosX, y = bobBuddy.oPosY, z = bobBuddy.oPosZ}
                obj_mark_for_deletion(bobBuddy)
                spawn_sync_object(id_bhvBobomb, E_MODEL_BOBOMB_BUDDY, bobBuddyPOS.x, bobBuddyPOS.y, bobBuddyPOS.z, function(o) o.oBehParams2ndByte = 1 end)
            end
            bobBuddy = obj_get_next_with_same_behavior_id(bobBuddy)
        end
    end
end)

hook_event(HOOK_ON_WARP, function()
    if m.numStars < 10 then lobbyDialogue = true end
    sewerDialogue = true
    cakeDialogue = true
    yellowSwitchDialog = true
    capBuffer = false

    --Lobby 1up fix by wingstosky256
    if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and (gNetworkPlayers[0].currAreaIndex == 2 or gNetworkPlayers[0].currAreaIndex == 3 or gNetworkPlayers[0].currAreaIndex == 4) then
        local Lobby1up = obj_get_first_with_behavior_id(id_bhv1Up)
        while Lobby1up ~= nil do
            if obj_has_behavior_id(Lobby1up, id_bhv1Up) ~= 0 then
                waahwaahPOS = {x = Lobby1up.oPosX, y = Lobby1up.oPosY, z = Lobby1up.oPosZ}
                obj_mark_for_deletion(Lobby1up)
                spawn_non_sync_object(id_bhvWaahWaah, E_MODEL_NONE, waahwaahPOS.x, waahwaahPOS.y, waahwaahPOS.z, nil)
            end
            Lobby1up = obj_get_next_with_same_behavior_id(Lobby1up)
        end
    end

    --Fix Crescent Castle Death Floor
    if gNetworkPlayers[0].currLevelNum == LEVEL_BOB and gNetworkPlayers[0].currAreaIndex == 6 then
        spawn_non_sync_object(id_bhvPushableMetalBox, E_MODEL_METAL_BOX, -2331, 205, 2050, nil)
        spawn_non_sync_object(id_bhvPushableMetalBox, E_MODEL_METAL_BOX, -2024, 205, 2050, nil)
    end

    -- Better Coin Compatibility for Peach's Cell
    --[[if gNetworkPlayers[0].currLevelNum == LEVEL_THI and gNetworkPlayers[0].currAreaIndex == 7 and betterCoinCompat then
        --local starPOS = obj_get_first_with_behavior_id(id_bhvStar)
        spawn_non_sync_object(bhvFakeWarp, E_MODEL_NONE, 2309,300,-22683, function(o) dest_level = LEVEL_SA dest_area = 6 end)
    end]]
end)

hook_event(HOOK_ON_LEVEL_INIT, function()
    --spawn temp warps
    if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS and gNetworkPlayers[0].currAreaIndex == 1 then -- Ending Grounds (to 2nd Floor Beta)
        spawn_non_sync_object(bhvFakeWarp, E_MODEL_NONE, 12, 550, -6005, function(o) dest_level = LEVEL_VCUTM dest_area = 4 end)
    end
    if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE and gNetworkPlayers[0].currAreaIndex == 1 then -- Inside vanilla lobby (to long Crimson Courtyard)
        spawn_non_sync_object(bhvFakeWarp, E_MODEL_NONE, 1990, 819, 1236, function(o) dest_level = LEVEL_BITDW dest_area = 2 end)
    end

    -- Peach NPC
    if gNetworkPlayers[0].currLevelNum == LEVEL_DDD and gNetworkPlayers[0].currAreaIndex == 4 and gNetworkPlayers[0].currActNum == 99 then 
        spawn_non_sync_object(bhvB3313Peach, E_MODEL_PEACH, 2350, 0, -1600, function(o) o.oFaceAngleYaw = -6000 end)
    end

    -- chungus
    if gNetworkPlayers[0].currLevelNum == LEVEL_VCUTM and gNetworkPlayers[0].currAreaIndex == 4 then 
        spawn_non_sync_object(bhvB3313PlayerNPC, E_MODEL_BEEIE_CHUNGUS, -810, 0, -2650, function(o) o.oBehParams2ndByte = DIALOG_BC_1 end)
    end

    --"100%" bonus interactions (bobombs)
    if gNetworkPlayers[0].currLevelNum == LEVEL_SA and gNetworkPlayers[0].currAreaIndex == 1 and m.numStars >= total_stars then 
        spawn_non_sync_object(bhvSecretBobomb, E_MODEL_BLACK_BOBOMB, 4030, 0, 30519, nil)
    end
    if gNetworkPlayers[0].currLevelNum == LEVEL_PSS and gNetworkPlayers[0].currAreaIndex == 1 and m.numStars >= total_stars then 
        spawn_non_sync_object(bhvSecretBobomb, E_MODEL_BLACK_BOBOMB, -863, -1563, -11719, nil)
    end
    if gNetworkPlayers[0].currLevelNum == LEVEL_CCM and ((gNetworkPlayers[0].currAreaIndex == 6) or (gNetworkPlayers[0].currAreaIndex == 5 and not yellowSwitch)) then
        local yellowSwitchWarning = math.random(0,5)
        if (m.numStars >= 1 and yellowSwitchWarning <= 1) or (m.numStars >= 13 and yellowSwitchWarning <= 2) or (m.numStars >= 33 and yellowSwitchWarning <= 3) or (m.numStars >= 70 and yellowSwitchWarning <= 4) or (m.numStars >= 120 and yellowSwitchWarning <= 5)then
            spawn_non_sync_object(bhvSecretBobomb, E_MODEL_BOBOMB_BUDDY, 1151, 6005, -7171, function(o) o.oBehParams2ndByte = DIALOG_BOBOMB_WARNING_1 end)
        end
    end
end)