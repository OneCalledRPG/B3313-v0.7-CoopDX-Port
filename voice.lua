-- General functions.
function current_beta_voice(m)
    if (not gPlayerSyncTable[m.playerIndex].vanillaMario) then
        return 1 
    else
        return 0
    end
end

gStateExtras = {}
for i=0,(MAX_PLAYERS-1) do
    gStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gStateExtras[i]
end

local sound_beta_mario_attacked = 'sound_beta_mario_attacked.ogg'
local sound_beta_mario_eeuh = 'sound_beta_mario_eeuh.ogg'
local sound_beta_mario_uh = 'sound_beta_mario_uh.ogg'
local sound_beta_mario_hawh = 'sound_beta_mario_hawh.ogg'
local sound_beta_mario_jump_hoo = 'sound_beta_mario_jump_hoo.ogg'
local sound_beta_mario_jump_wah = 'sound_beta_mario_jump_wah.ogg'
local sound_beta_mario_jump_yah = 'sound_beta_mario_jump_yah.ogg'
local sound_beta_mario_woah = 'sound_beta_mario_woah.ogg'
local sound_beta_mario_on_fire = 'sound_beta_mario_on_fire.ogg'
local sound_beta_mario_yahaa = 'sound_beta_mario_yahaa.ogg'
local sound_beta_mario_yeah = 'sound_beta_mario_yeah.ogg'

--Define what triggers the custom voice
local function use_custom_voice(m)
    return current_beta_voice(m) == 1 --Put your condition here!
end

--How many snores the sleep-talk has, or rather, how long the sleep-talk lasts
--If you omit the sleep-talk you can ignore this
local SLEEP_TALK_SNORES = 8

--Define what actions play what voice clips
--If an action has more than one voice clip, put those clips inside a table
--CHAR_SOUND_SNORING3 requires two or three voice clips to work properly...
--but you can omit it if your character does not sleep-talk
local BETA_MARIO_VOICE = {
    [CHAR_SOUND_ATTACKED] = sound_beta_mario_attacked,
    --[CHAR_SOUND_COUGHING1] = nil,
    --[CHAR_SOUND_COUGHING2] = nil,
    --[CHAR_SOUND_COUGHING3] = nil,
    --[CHAR_SOUND_DOH] = nil,
    --[CHAR_SOUND_DROWNING] = nil,
    [CHAR_SOUND_DYING] = sound_beta_mario_attacked,
    [CHAR_SOUND_EEUH] = sound_beta_mario_uh,
    --[CHAR_SOUND_GAME_OVER] = nil,
    --[CHAR_SOUND_GROUND_POUND_WAH] = nil,
    [CHAR_SOUND_HAHA] = sound_beta_mario_yeah,
    [CHAR_SOUND_HAHA_2] = sound_beta_mario_yeah,
    --[CHAR_SOUND_HELLO] = nil,
    [CHAR_SOUND_HERE_WE_GO] = sound_beta_mario_yeah,
    [CHAR_SOUND_HOOHOO] = sound_beta_mario_hawh,
    [CHAR_SOUND_HRMM] = sound_beta_mario_eeuh,
    --[CHAR_SOUND_IMA_TIRED] = nil,
    --[CHAR_SOUND_LETS_A_GO] = nil,
    --[CHAR_SOUND_MAMA_MIA] = nil,
    --[CHAR_SOUND_OKEY_DOKEY] = nil,
    [CHAR_SOUND_ON_FIRE] = sound_beta_mario_on_fire,
    [CHAR_SOUND_OOOF] = sound_beta_mario_hawh,
    [CHAR_SOUND_OOOF2] = sound_beta_mario_hawh,
    --[CHAR_SOUND_PANTING] = nil,
    --[CHAR_SOUND_PANTING_COLD] = nil,
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = nil,
    [CHAR_SOUND_PUNCH_HOO] = SOUND_ACTION_KEY_SWISH,
    [CHAR_SOUND_PUNCH_WAH] = SOUND_ACTION_THROW,
    [CHAR_SOUND_PUNCH_YAH] = SOUND_ACTION_THROW,
    --[CHAR_SOUND_SNORING1] = nil,
    --[CHAR_SOUND_SNORING2] = nil,
    --[CHAR_SOUND_SNORING3] = nil,
    [CHAR_SOUND_SO_LONGA_BOWSER] = sound_beta_mario_yeah,
    --[CHAR_SOUND_TWIRL_BOUNCE] = nil,
    [CHAR_SOUND_UH] = sound_beta_mario_hawh,
    [CHAR_SOUND_UH2] = sound_beta_mario_uh,
    [CHAR_SOUND_UH2_2] = sound_beta_mario_uh,
    [CHAR_SOUND_WAAAOOOW] = sound_beta_mario_on_fire,
    --[CHAR_SOUND_WAH2] = nil,
    [CHAR_SOUND_WHOA] = sound_beta_mario_woah,
    [CHAR_SOUND_YAHOO] = sound_beta_mario_yeah,
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = sound_beta_mario_yahaa,
    [CHAR_SOUND_YAH_WAH_HOO] = {sound_beta_mario_jump_yah, sound_beta_mario_jump_wah, sound_beta_mario_jump_hoo},
    --[CHAR_SOUND_YAWNING] = nil,
}

--Define the table of samples that will be used for each player
--Global so if multiple mods use this they won't create unneeded samples
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
gCustomVoiceSamples = {}
gCustomVoiceStream = nil

--Get the player's sample, stop whatever sound
--it's playing if it doesn't match the provided sound
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
--- @param m MarioState
function stop_custom_character_sound(m, sound)
    local voice_sample = gCustomVoiceSamples[m.playerIndex]
    if voice_sample == nil or not voice_sample.loaded then
        return
    end

    audio_sample_stop(voice_sample)
    if voice_sample.filepath:match('^.+/(.+)$') == sound then
        return voice_sample
    end
    -- audio_sample_destroy(voice_sample)
end

--Play a custom character's sound
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
--- @param m MarioState
function play_custom_character_sound(m, voice)
    --Get sound, if it's a table, get a random entry from it
    local sound
    if type(voice) == "table" then
        sound = voice[math.random(#voice)]
    else
        sound = voice
    end
    if sound == nil then return 0 end

    --Get current sample and stop it
    local voice_sample = stop_custom_character_sound(m, sound)

    --If the new sound isn't a string, let's assume it's
    --a number to return to the character sound hook
    if type(sound) ~= "string" then
        return sound
    end

    --Load a new sample and play it! Don't make a new one if we don't need to
    if (m.area == nil or m.area.camera == nil) and m.playerIndex == 0 then
        if gCustomVoiceStream ~= nil then
            audio_stream_stop(gCustomVoiceStream)
            audio_stream_destroy(gCustomVoiceStream)
        end
        gCustomVoiceStream = audio_stream_load(sound)
        audio_stream_play(gCustomVoiceStream, true, 1)
    else
        if voice_sample == nil then
            voice_sample = audio_sample_load(sound)
        end
        audio_sample_play(voice_sample, m.pos, 1)

        gCustomVoiceSamples[m.playerIndex] = voice_sample
    end
    return 0
end

--Main character sound hook
--This hook is freely modifiable in case you want to make any specific exceptions
--- @param m MarioState
local function custom_character_sound(m, characterSound)
    if not use_custom_voice(m) then return end
    if characterSound == CHAR_SOUND_SNORING3 then return 0 end
    if characterSound == CHAR_SOUND_HAHA and m.hurtCounter > 0 then return 0 end

    local voice = BETA_MARIO_VOICE[characterSound]
    
    if current_beta_voice(m) == 1 then
        voice = BETA_MARIO_VOICE[characterSound]
    end

    if voice ~= nil then
        return play_custom_character_sound(m, voice)
    end
    return 0
end
hook_event(HOOK_CHARACTER_SOUND, custom_character_sound)

--Snoring logic for CHAR_SOUND_SNORING3 since we have to loop it manually
--This code won't activate on the Japanese version, due to MARIO_MARIO_SOUND_PLAYED not being set
local SNORE3_TABLE = nil
local STARTING_SNORE = 46
local SLEEP_TALK_START = STARTING_SNORE + 49
local SLEEP_TALK_END = SLEEP_TALK_START + SLEEP_TALK_SNORES

--Main hook for snoring
--- @param m MarioState
local function custom_character_snore(m)
    if not use_custom_voice(m) then return end
    
    
    if current_beta_voice(m) == 1 then
        SNORE3_TABLE = BETA_MARIO_VOICE[CHAR_SOUND_SNORING3]
    end

    --Stop the snoring!
    if m.action ~= ACT_SLEEPING then
        if m.isSnoring > 0 then
            stop_custom_character_sound(m)
        end
        return

    --You're not in deep snoring
    elseif not (m.actionState == 2 and (m.flags & MARIO_MARIO_SOUND_PLAYED) ~= 0) then
        return
    end

    local animFrame = m.marioObj.header.gfx.animInfo.animFrame

    --Behavior for CHAR_SOUND_SNORING3
    if SNORE3_TABLE ~= nil and #SNORE3_TABLE >= 2 then
        --Exhale sound
        if animFrame == 2 and m.actionTimer < SLEEP_TALK_START then
            play_custom_character_sound(m, SNORE3_TABLE[2])

        --Inhale sound
        elseif animFrame == 25 then
            
            --Count up snores
            if #SNORE3_TABLE >= 3 then
                m.actionTimer = m.actionTimer + 1

                --End sleep-talk
                if m.actionTimer >= SLEEP_TALK_END then
                    m.actionTimer = STARTING_SNORE
                end
    
                --Enough snores? Start sleep-talk
                if m.actionTimer == SLEEP_TALK_START then
                    play_custom_character_sound(m, SNORE3_TABLE[3])
                
                --Regular snoring
                elseif m.actionTimer < SLEEP_TALK_START then
                    play_custom_character_sound(m, SNORE3_TABLE[1])
                end
            
            --Definitely regular snoring
            else
                play_custom_character_sound(m, SNORE3_TABLE[1])
            end
        end

    --No CHAR_SOUND_SNORING3, just use regular snoring
    elseif animFrame == 2 then
        play_character_sound(m, CHAR_SOUND_SNORING2)

    elseif animFrame == 25 then
        play_character_sound(m, CHAR_SOUND_SNORING1)
    end
end

-- Stop character sounds on warp.
function on_sync_valid()
    local m = gMarioStates[0]
    stop_custom_character_sound(m)
end

--hook_event(HOOK_MARIO_UPDATE, custom_character_snore)
hook_event(HOOK_ON_SYNC_VALID, on_sync_valid)



playB3313SFX = true

local function stop_all_custom_character_sounds()
    for i = 0, MAX_PLAYERS - 1 do
        local m = gMarioStates[i]
        local voiceTable = charSelect.character_get_voice(m)
        if voiceTable ~= nil then
            for sound in pairs(voiceTable) do
                if voiceTable[sound] ~= nil and type(voiceTable[sound]) ~= "string" then
                    if voiceTable[sound]._pointer == nil then
                        for voice in pairs(voiceTable[sound]) do
                            if type(voiceTable[sound][voice]) == "string" then
                                break
                            end
                            audio_sample_stop(voiceTable[sound][voice])
                        end
                    else
                        audio_sample_stop(voiceTable[sound])
                    end
                end
            end
        end
    end
end

-- Mutes sound effects upon a certain dialog cue from Toad
hook_event(HOOK_ON_DIALOG, function (dialogID)
    if dialogID == 19 and areas[gNetworkPlayers[gMarioStates[0].playerIndex].currLevelNum] ~= nil then
        seq_player_lower_volume(SEQ_PLAYER_SFX, 25, 0)
        playB3313SFX = false
    end
end)

hook_event(HOOK_ON_WARP, function()
    if not playB3313SFX then
        playB3313SFX = true -- restore beta voice and SFX if they were turned off
        seq_player_unlower_volume(SEQ_PLAYER_SFX, 25)
    end
end)



-- SOUND EFFECTS (Not Mario's Voice)

SOUND_BETA_FAKE_1UP = audio_sample_load("sound_tricked.ogg")
SOUND_BETA_COIN = audio_sample_load("sound_coin.ogg")
SOUND_JP_RED_COIN = audio_sample_load("sound_red_coin.ogg")
SOUND_BETA_WOODEN_DOOR_OPEN = audio_sample_load("sound_wooden_door_open.ogg")
SOUND_BETA_WOODEN_DOOR_CLOSE = audio_sample_load("sound_wooden_door_close.ogg")

SOUND_BETA_TERRAIN_DEFAULT_STEP = audio_sample_load("sound_step.ogg")
SOUND_BETA_TERRAIN_DEFAULT_JUMP = audio_sample_load("sound_step_jump.ogg")
SOUND_BETA_TERRAIN_DEFAULT_LAND = audio_sample_load("sound_step_land.ogg")

SOUND_BETA_TERRAIN_WATER_STEP = audio_sample_load("sound_step_water.ogg")
SOUND_BETA_TERRAIN_WATER_JUMP = audio_sample_load("sound_step_water_jump.ogg")
SOUND_BETA_TERRAIN_WATER_LAND = audio_sample_load("sound_step_water_land.ogg")

SOUND_BETA_SWIM = audio_sample_load("sound_swim.ogg")
SOUND_BETA_SWIM_FAST = audio_sample_load("sound_swim_fast.ogg")

SOUND_BETA_BOWSER_DIES = audio_sample_load("sound_bowser_dies.ogg")
SOUND_BETA_BOWSER_ROAR = audio_sample_load("sound_bowser_roar.ogg")
SOUND_BETA_BOWSER_YELP = audio_sample_load("sound_bowser_yelp.ogg")

SOUND_BETA_CHUNGUS = audio_sample_load("sound_bc_interact.ogg")

-- Defines from Coolio's sound system
gSamples = {
    SOUND_BETA_TERRAIN_DEFAULT_STEP,
    SOUND_BETA_TERRAIN_DEFAULT_JUMP,
    SOUND_BETA_TERRAIN_DEFAULT_LAND,
    SOUND_BETA_TERRAIN_WATER_STEP,
    SOUND_BETA_TERRAIN_WATER_JUMP,
    SOUND_BETA_TERRAIN_WATER_LAND,
    SOUND_BETA_SWIM,
    SOUND_BETA_SWIM_FAST
}

local sStepDefault = 1
local sStepJumpDefault = 2
local sStepLandDefault = 3
local sStepWater = 4
local sStepJumpWater = 5
local sStepLandWater = 6
local sSwim = 7
local sSwimFast = 8

function local_play(id, pos, vol)
    if playB3313SFX then
        audio_sample_play(gSamples[id], pos, (is_game_paused() and 0 or vol))
    end
end
function network_play(id, pos, vol, i)
    local_play(id, pos, vol)
    network_send(true, {id = id, x = pos.x, y = pos.y, z = pos.z, vol = vol, i = network_global_index_from_local(i)})
end

hook_event(HOOK_ON_PACKET_RECEIVE, function (data)
    if is_player_active(gMarioStates[network_local_index_from_global(data.i)]) ~= 0 then
        local_play(data.id, {x=data.x, y=data.y, z=data.z}, data.vol)
    end
end)

-- Get Bowser's position for Bowser sfx
id_bhvLocateBowser = hook_behavior(id_bhvBowser, OBJ_LIST_GENACTOR, false, nil, function(o) bowser_pos = { x = o.oPosX, y = o.oPosY, z = o.oPosZ } end)

-- Get Door Position (temp probably)
function door_pos_update(m)
    local door = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoor)
    local warpdoor = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoorWarp)

    if door ~= nil and dist_between_objects(m.marioObj, door) < 150 then
        if door.oAction == 0 or door.oAction == 4 then
            door_pos = { x = door.oPosX, y = door.oPosY, z = door.oPosZ }
        end
    elseif warpdoor ~= nil and dist_between_objects(m.marioObj, warpdoor) < 150 then
        if warpdoor.oAction == 0 or warpdoor.oAction == 4 then
            door_pos = { x = warpdoor.oPosX, y = warpdoor.oPosY, z = warpdoor.oPosZ }
        end
    end

    if m.action == ACT_WARP_DOOR_SPAWN then door_pos = { x = warpdoor.oPosX, y = warpdoor.oPosY, z = warpdoor.oPosZ } end
end

-- Mutes sounds with no catches
local muteSounds = {
    -- Princess Peach voice
    [SOUND_PEACH_BAKE_A_CAKE] = true,
    [SOUND_PEACH_DEAR_MARIO] = true,
    [SOUND_PEACH_FOR_MARIO] = true,
    [SOUND_PEACH_MARIO] = true,
    [SOUND_PEACH_MARIO2] = true,
    [SOUND_PEACH_POWER_OF_THE_STARS] = true,
    [SOUND_PEACH_SOMETHING_SPECIAL] = true,
    [SOUND_PEACH_THANKS_TO_YOU] = true,
    [SOUND_PEACH_THANK_YOU_MARIO] = true,

    -- Coin drop
    [SOUND_GENERAL_COIN_DROP] = true,
    [SOUND_GENERAL_COIN_SPURT] = true,
    [SOUND_GENERAL_COIN_SPURT_2] = true,
    [SOUND_GENERAL_COIN_SPURT_EU] = true,

    -- Misc
    [SOUND_OBJ_BOBOMB_WALK] = true,
}

local step_sound = false
local jump_sound = false
local land_sound = false
local has_landed = true
local fast_swim_sound = false

-- Mutes/replaces ALL sounds that use beta alternatives
hook_event(HOOK_ON_PLAY_SOUND, function (soundID, pos)
    local m = gMarioStates[0]
    if muteSounds[soundID] then
        return NO_SOUND
    end

    if not playB3313SFX then return NO_SOUND end

    -- Coin sounds
    if soundID == SOUND_GENERAL_COIN or soundID == SOUND_GENERAL_COIN_WATER then
        audio_sample_play(SOUND_BETA_COIN, m.pos, 1.5)
        return NO_SOUND
    end

    -- Red Coin sounds
    if soundID == SOUND_MENU_COLLECT_RED_COIN
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x10000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x20000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x30000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x40000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x50000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x60000
    or soundID == SOUND_MENU_COLLECT_RED_COIN + 0x70000 then
        audio_sample_play(SOUND_JP_RED_COIN, m.pos, 1.5)
        return NO_SOUND
    end

     -- Mario movement
    if soundID == SOUND_ACTION_TERRAIN_STEP + 0x20000 --water
    or soundID == SOUND_ACTION_TERRAIN_STEP + 0x30000 then --default/grass
        step_sound = true
        return NO_SOUND
    end
    if soundID == SOUND_ACTION_TERRAIN_STEP_TIPTOE + 0x20000
    or soundID == SOUND_ACTION_TERRAIN_STEP_TIPTOE + 0x30000 then
        step_sound = true
        return NO_SOUND
    end
    if soundID == SOUND_ACTION_TERRAIN_JUMP + 0x20000
    or soundID == SOUND_ACTION_TERRAIN_JUMP + 0x30000 then
        jump_sound = true
        return NO_SOUND
    end
    if soundID == SOUND_ACTION_TERRAIN_LANDING + 0x20000
    or soundID == SOUND_ACTION_TERRAIN_LANDING + 0x30000 then
        land_sound = true
        return NO_SOUND
    end

    -- Swimming (mutes default sound and gets the swim state)
    if soundID == SOUND_ACTION_SWIM_FAST then
        fast_swim_sound = true
        return NO_SOUND
    elseif soundID == SOUND_ACTION_SWIM then
        fast_swim_sound = false
        return NO_SOUND
    end

    -- Wooden Door (replace sound)
    if soundID == SOUND_GENERAL_OPEN_WOOD_DOOR then
        audio_sample_stop(SOUND_BETA_WOODEN_DOOR_OPEN)
        audio_sample_play(SOUND_BETA_WOODEN_DOOR_OPEN, door_pos, 1.3)
        return NO_SOUND
    end
    if soundID == SOUND_GENERAL_CLOSE_WOOD_DOOR then
        audio_sample_stop(SOUND_BETA_WOODEN_DOOR_CLOSE)
        audio_sample_play(SOUND_BETA_WOODEN_DOOR_CLOSE, door_pos, 1.3)
        return NO_SOUND
    end

    -- Bowser sounds
    if soundID == SOUND_OBJ2_BOWSER_ROAR then
        audio_sample_play(SOUND_BETA_BOWSER_ROAR, bowser_pos, 1.5)
        return NO_SOUND
    end
    if soundID == SOUND_OBJ_BOWSER_TAIL_PICKUP then
        audio_sample_play(SOUND_BETA_BOWSER_YELP, bowser_pos, 1.5)
        return NO_SOUND
    end
    if soundID == SOUND_OBJ_BOWSER_DEFEATED then
        audio_sample_play(SOUND_BETA_BOWSER_DIES, bowser_pos, 1.7)
        return NO_SOUND
    end
    if soundID == SOUND_OBJ_BOWSER_LAUGH then
        return NO_SOUND
    end

    -- Mutes specific flying sounds
    if enableBeeie09 and not fakewings then
        if soundID == SOUND_MOVING_FLYING then
            return NO_SOUND
        end
    end

    -- 1up sounds
    if soundID == SOUND_GENERAL2_1UP_APPEAR then
        return NO_SOUND
    end
    if soundID == SOUND_GENERAL_COLLECT_1UP then
        local is_obj_1up = (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1Up)) 
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1upJumpOnApproach)) 
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1upRunningAway))
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1upSliding))
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhv1upWalking))
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhvHidden1up))
        or (obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhvHidden1upInPole))

        if is_obj_1up ~= nil and obj_check_hitbox_overlap(m.marioObj,is_obj_1up) then
            return NO_SOUND
        end   
    end
end)
 
hook_event(HOOK_MARIO_UPDATE, function(m) -- ALL Mario_Update hooked commands.,
    custom_character_snore(m)

    door_pos_update(m)
    if not playB3313SFX then stop_custom_character_sound(m, sound)
        if _G.charSelectExists then stop_all_custom_character_sounds() end 
    end

    if m.playerIndex ~= 0 then return end
    -- Footstep sounds
    if (m.terrainSoundAddend == 196608 or m.terrainSoundAddend == 131072) and (m.flags ~= m.flags | MARIO_METAL_CAP) then
        if m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_WALKING 
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_RUNNING 
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_RUNNING_UNUSED
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_RUN_WITH_LIGHT_OBJ
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_WALK_WITH_LIGHT_OBJ then
            if step_sound then
                if is_anim_past_frame(m, 26) ~= 0 or is_anim_past_frame(m, 60) ~= 0 then
                    if m.terrainSoundAddend == 196608 then
                        network_play(sStepDefault, m.pos, 1.5, m.playerIndex)
                    elseif m.terrainSoundAddend == 131072 then
                        network_play(sStepWater, m.pos, 1.5, m.playerIndex)
                    end
                    step_sound = false
                end
            end
        end
        if m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_TIPTOE 
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_WALK_WITH_HEAVY_OBJ
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_RUN_WITH_HEAVY_OBJ  
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_SLOW_WALK_WITH_HEAVY_OBJ
        or m.marioObj.header.gfx.animInfo.animID == CHAR_ANIM_SLOW_WALK_WITH_LIGHT_OBJ then
            if step_sound then
                if is_anim_past_frame(m, 26) ~= 0 or is_anim_past_frame(m, 80) ~= 0 then
                    if m.terrainSoundAddend == 196608 then
                        network_play(sStepDefault, m.pos, 1.5, m.playerIndex)
                    elseif m.terrainSoundAddend == 131072 then
                        network_play(sStepWater, m.pos, 1.5, m.playerIndex)
                    end
                end
                step_sound = false
            end
        end

        --Jump handling
        if m.pos.y > m.floorHeight then
            has_landed = false
            if jump_sound then
                if m.terrainSoundAddend == 196608 then
                    network_play(sStepJumpDefault, m.pos, 1.5, m.playerIndex)
                elseif m.terrainSoundAddend == 131072 then
                    network_play(sStepJumpWater, m.pos, 1.5, m.playerIndex)
                end
                jump_sound = false
            end
        end
        if m.pos.y == m.floorHeight and land_sound and not has_landed then
            if m.terrainSoundAddend == 196608 then
                network_play(sStepLandDefault, m.pos, 1.5, m.playerIndex)
            elseif m.terrainSoundAddend == 131072 then
                network_play(sStepLandWater, m.pos, 1.5, m.playerIndex)
            end
            has_landed = true
            land_sound = false
        end
    end

    -- Swimming sounds
    if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
        if is_anim_past_end(m) ~= 0 and m.actionArg == 1 then
            if fast_swim_sound then
                network_play(sSwimFast, m.pos, 1.5, m.playerIndex)
            else
                network_play(sSwim, m.pos, 1.5, m.playerIndex)
            end
        end
    end 
end)