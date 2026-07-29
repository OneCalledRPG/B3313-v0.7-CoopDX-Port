Bhv_Custom_0x130056bc = hook_behavior(id_Bhv_Custom_0x130056bc, OBJ_LIST_DEFAULT, true, obj_mark_for_deletion, nil)
Bhv_Custom_0x13005708 = hook_behavior(id_Bhv_Custom_0x13005708, OBJ_LIST_DEFAULT, true, obj_mark_for_deletion, nil)

-- Star Dust
local check = 0
local modelStar = 0

E_MODEL_STAR_DUST = smlua_model_util_get_id("star_dust_geo")
E_MODEL_STAR_TRANSPARENT = smlua_model_util_get_id("transparent_star_geo")
local function on_interact(m, o, type)
    if gMarioStates[0].playerIndex ~= 0 then return end
    if type == INTERACT_STAR_OR_KEY then
        if get_id_from_behavior(o.behavior) == id_bhvBowserKey then
            modelStar = 0
        else
            oBeh = o.oBehParams
            modelStar = 1
            spawn_sync_object(id_bhvSmoke, E_MODEL_STAR_DUST, o.oPosX, o.oPosY, o.oPosZ, function() end)
            check = 0
            if (gNetworkPlayers[0].currLevelNum == LEVEL_THI and gNetworkPlayers[0].currAreaIndex == 7) then
                spawn_sync_object(id_bhvStar, E_MODEL_STAR_TRANSPARENT, o.oPosX, o.oPosY, o.oPosZ, function(o) o.oBehParams = oBeh end)
            end
        end
    end
end

hook_event(HOOK_ON_INTERACT, on_interact)

---@param o Object
function wind_init(o)
    o.oFlags = (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_ACTIVE_FROM_AFAR)
end
---@param o Object
function wind_loop(o)
    ---@type MarioState
    local m = gMarioStates[0]
    --obj_copy_pos(pos, o)
    if m.marioObj ~= nil then play_sound(SOUND_AIR_HOWLING_WIND, m.marioObj.header.gfx.cameraToObject) end
    -- o.oPosX = gMarioStates[0].pos.x
    -- o.oPosY = gMarioStates[0].pos.y
    -- o.oPosZ = gMarioStates[0].pos.z
    o.oPosX = m.pos.x
    o.oPosY = m.pos.y
    o.oPosZ = m.pos.z
    -- obj_set_pos(o, gMarioStates[0].pos.x, gMarioStates[0].pos.y, gMarioStates[0].pos.z)
end
id_bhvSandSoundLoop = hook_behavior(id_bhvSandSoundLoop, OBJ_LIST_LEVEL, true, wind_init, wind_loop, "Sand Ambient Sounds")

bhvKoopaNPC = hook_behavior(nil, OBJ_LIST_GENACTOR, false, function(o)
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oInteractType = INTERACT_TEXT
    o.oFlags = (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW)
    bhv_bobomb_buddy_init()
    o.oAnimations = gObjectAnimations.koopa_seg6_anims_06011364
    cur_obj_init_animation(7)
    o.oIntangibleTimer = 0
    o.hitboxHeight = 113
    o.hitboxRadius = 90
    o.hitboxDownOffset = 0
    o.oGravity = 2.5
    o.oFriction = 0.8
    o.oBuoyancy = 1.3
    timer = 0
end,
function(o)
    bhv_bobomb_buddy_loop()
    object_step()
end)

bhvB3313Peach = hook_behavior(nil, OBJ_LIST_GENACTOR, true, function(o)
    o.oFlags = OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_HOLDABLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oAnimations = gObjectAnimations.peach_seg5_anims_0501C41C
    --o.oFaceAngleYaw = 0
    o.oInteractType = INTERACT_TEXT
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.hitboxRadius = 90
    o.hitboxHeight = 150
    o.oOpacity = 255
    cur_obj_init_animation(0)
    --bhv_toad_message_init()
    bhv_bobomb_buddy_init()
end, function(o)
    o.oIntangibleTimer = 0
    --djui_chat_message_create(tostring(o.oOpacity))
    --bhv_toad_message_loop()
    bhv_bobomb_buddy_loop()
end)

bhvSecretBobomb = hook_behavior(nil, OBJ_LIST_GENACTOR, true, function(o)
    o.oFlags = OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_HOLDABLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.oAnimations = gObjectAnimations.bobomb_seg8_anims_0802396C
    o.oInteractType = INTERACT_TEXT
    o.hitboxRadius = 160
    o.hitboxHeight = 150
    cur_obj_init_animation(0)
    bhv_bobomb_buddy_init()
end, function(o)
    o.oIntangibleTimer = 0
    bhv_bobomb_buddy_loop()
end)

E_MODEL_FACELESS_A = smlua_model_util_get_id("custom_geo_0700b630")
E_MODEL_FACELESS_B = smlua_model_util_get_id("custom_geo_07016c90")
E_MODEL_BEEIE_CHUNGUS = smlua_model_util_get_id("beeie_chungus_geo")

bhvB3313PlayerNPC = hook_behavior(nil, OBJ_LIST_GENACTOR, true, function(o)
    playerNPC_pos = {x = o.oPosX, y = o.oPosY, z = o.oPosZ}
    o.oFlags = OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.header.gfx.animInfo.curAnim = get_mario_vanilla_animation(MARIO_ANIM_FIRST_PERSON)
    o.oInteractType = INTERACT_TEXT
    o.hitboxRadius = 100
    o.hitboxHeight = 100
    o.oGraphYOffset = o.oGraphYOffset + 40
    bhv_bobomb_buddy_init()
end, function(o)
    o.oIntangibleTimer = 0
    bhv_bobomb_buddy_loop()
end)

-- troll 1up noise by wingstosky256
function play_waahwaahwaah_init(o)
    o.hitboxRadius = 25
    o.hitboxHeight = 45
end
function play_waahwaahwaah_loop(o)
    local m = gMarioStates[0]
    if obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) == true and gMarioStates[0].playerIndex == 0 then
        audio_sample_stop(SOUND_BETA_FAKE_1UP)
        audio_sample_play(SOUND_BETA_FAKE_1UP, gMarioStates[0].pos, 2)
        obj_mark_for_deletion(o)
    end
end
id_bhvWaahWaah = hook_behavior(nil, OBJ_LIST_GENACTOR, false, play_waahwaahwaah_init, play_waahwaahwaah_loop, "waahwaah")


function fakewarp_init(o)
    o.hitboxRadius = 100
    o.hitboxHeight = 100
end

is_warping = false
---@param o Object
function fakewarp_loop(o)
    if obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) then
        is_warping = true
    end
    if is_warping then
        obj_mark_for_deletion(gMarioStates[0].marioObj)
        if transition == 0 then
            play_transition(WARP_TRANSITION_FADE_INTO_STAR, 15, 0, 0, 0)
            play_sound(SOUND_MENU_ENTER_HOLE, m.pos)
            transition = 1
        end
        warp_delay = warp_delay + 1
        if warp_delay >= 20 then
            warp_to_warpnode(dest_level, dest_area, gNetworkPlayers[0].currActNum, dest_node)
            set_mario_action(m, ACT_SPAWN_SPIN_AIRBORNE, 0)
            warp_delay = 0
            is_warping = false
            transition = 0
        end
    end
end
bhvFakeWarp = hook_behavior(nil, OBJ_LIST_LEVEL, true, fakewarp_init, fakewarp_loop, "Fake Warp")

---@param o Object
function killma_plumber_loop(o)
    o.oTimer = o.oTimer + 1
    --if obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) then
    if (dist_between_objects(o, gMarioStates[0].marioObj)) <= 500 then
        gMarioStates[0].health = 0
        allow_negative_lives = true
        obj_mark_for_deletion(o)
    end
    if o.oTimer >= 5 then
        obj_mark_for_deletion(o)
    end
end
bhvKillmaPlumber = hook_behavior(nil, OBJ_LIST_LEVEL, true, nil, killma_plumber_loop, "Kill Mario")

bhvCustomBoxSpawn = hook_behavior(nil, OBJ_LIST_GENACTOR, true, nil, nil)

function bhv_star_loop(o)
    o.oAnimState = o.oAnimState + 1
    obj_set_billboard(o)
    obj_scale(o, 1.25)
end

function bhv_celebration_star_loop(o)
    if modelStar ~= 0 then
        obj_set_model_extended(o, E_MODEL_STAR)
        if check < 33 then
            o.oAnimState = o.oAnimState + 1
            check = check + 1
        end
        obj_set_billboard(o)
        obj_scale(o, 0.5 + (0.75 / (34 - check)))
    end
end

function bhv_grand_star_loop(o)
    o.oAnimState = o.oAnimState + 1
    obj_set_billboard(o)
    obj_scale(o, 3)
end

--Yellow Switch
function pressed_check(o)
    --only run this function when the switch is pressed
    if o.oAction ~= 2 then return end
    if o.oBehParams2ndByte == 3 then
        save_file_set_flags(SAVE_FLAG_FILE_EXISTS)
        -- unlocked flags
        save_file_set_flags(SAVE_FLAG_MOAT_DRAINED)
        save_file_set_flags(SAVE_FLAG_UNLOCKED_50_STAR_DOOR)
        save_file_set_flags(SAVE_FLAG_UNLOCKED_CCM_DOOR)
        save_file_set_flags(SAVE_FLAG_UNLOCKED_PSS_DOOR)
        save_file_set_flags(SAVE_FLAG_HAVE_KEY_2)
        -- star flags
        save_file_set_flags(SAVE_FLAG_COLLECTED_MIPS_STAR_2)
        save_file_set_flags(SAVE_FLAG_COLLECTED_TOAD_STAR_1)
        save_file_set_flags(SAVE_FLAG_COLLECTED_TOAD_STAR_2)
        save_file_set_flags(SAVE_FLAG_COLLECTED_TOAD_STAR_3)
        yellowSwitch = true
        do_level = true
        --spawn_non_sync_object(id_bhvFloorTrapInCastle, E_MODEL_NONE, 0, 0, 0, nil)
        --obj_mark_for_deletion(gMarioStates[0].marioObj)
        capBuffer = true
        yellowSwitchCapState = math.random(0,4)
        if yellowSwitchDialog then
            ysDialogNumber = math.random(0,169)
            if ysDialogNumber == 20 then ysDialogNumber = math.random(0,169) end
            create_dialog_box(ysDialogNumber)
            yellowSwitchPressCount = yellowSwitchPressCount + 1
            yellowSwitchDialog = false
        end
    end
end

hook_behavior(id_bhvStar, OBJ_LIST_GENACTOR, false, nil, bhv_star_loop)
hook_behavior(id_bhvSpawnedStar, OBJ_LIST_GENACTOR, false, nil, bhv_star_loop)
hook_behavior(id_bhvHiddenStar, OBJ_LIST_GENACTOR, false, nil, bhv_star_loop)
hook_behavior(id_bhvStarSpawnCoordinates, OBJ_LIST_GENACTOR, false, nil, bhv_star_loop)
hook_behavior(id_bhvSpawnedStarNoLevelExit, OBJ_LIST_GENACTOR, false, nil, bhv_star_loop)
hook_behavior(id_bhvCelebrationStar, OBJ_LIST_GENACTOR, false, nil, bhv_celebration_star_loop)
hook_behavior(id_bhvGrandStar, OBJ_LIST_GENACTOR, false, nil, bhv_grand_star_loop)
hook_behavior(id_bhvCapSwitch,OBJ_LIST_SURFACE,false,nil,pressed_check,"bhvCustomCapSwitch")