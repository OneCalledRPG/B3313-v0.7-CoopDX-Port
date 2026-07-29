gStateExtras = {}
for i = 0,(MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    m = gMarioStates[i]
    e = gStateExtras[i]

	e.rotAngle = 0
	e.healTimer = 0
    e.animFrame = 0

	gPlayerSyncTable[i].vanillaMario = false
	gPlayerSyncTable[i].B3313_Moveset = true
    gPlayerSyncTable[i].shadeR = shadeState
    gPlayerSyncTable[i].shadeG = shadeState
    gPlayerSyncTable[i].shadeB = shadeState
end


--------------------
-- MODEL HANDLING --
--------------------

E_MODEL_BEEIE_MARIO = smlua_model_util_get_id("beeie_mario_geo")
E_MODEL_BEEIE_LUIGI = smlua_model_util_get_id("beeie_luigi_geo")
E_MODEL_BEEIE_CHUNGUS = smlua_model_util_get_id("beeie_chungus_geo")

local custom_model_stats
local b_model = 2
local chungus = false
local b3313_models = {
    [CT_MARIO] = {E_MODEL_MARIO, E_MODEL_BEEIE_MARIO, E_MODEL_BEEIE_CHUNGUS},
    [CT_LUIGI] = {E_MODEL_LUIGI, E_MODEL_BEEIE_LUIGI, E_MODEL_BEEIE_CHUNGUS},
    [CT_TOAD] = {E_MODEL_TOAD_PLAYER, E_MODEL_TOAD_PLAYER, E_MODEL_BEEIE_CHUNGUS},
    [CT_WALUIGI] = {E_MODEL_WALUIGI, E_MODEL_WALUIGI, E_MODEL_BEEIE_CHUNGUS},
    [CT_WARIO] = {E_MODEL_WARIO, E_MODEL_WARIO, E_MODEL_BEEIE_CHUNGUS}
}

B3313_CHAR_PALETTES = {
	["mario"] = {
		{
			name = "Default",
			[PANTS]  = { r = 0x00, g = 0x00, b = 0xff },
    		[SHIRT]  = { r = 0xff, g = 0x00, b = 0x00 },
    		[GLOVES] = { r = 0xff, g = 0xff, b = 0xff },
    		[SHOES]  = { r = 0x72, g = 0x1c, b = 0x0e },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0xff, g = 0x00, b = 0x00 },
    		[EMBLEM] = { r = 0xff, g = 0x00, b = 0x00 },
		},
		{
			name = "Beta Blues",
			[PANTS]  = { r = 0x20, g = 0x20, b = 0x60 },
    		[SHIRT]  = { r = 0x0e, g = 0x45, b = 0xf0 },
    		[GLOVES] = { r = 0xe5, g = 0xd3, b = 0xd0 },
    		[SHOES]  = { r = 0xd4, g = 0x47, b = 0x07 },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0x0e, g = 0x45, b = 0xf0 },
    		[EMBLEM] = { r = 0x0e, g = 0x45, b = 0xf0 },
		},
		{
			name = "Nebula Purple",
			[PANTS]  = { r = 0x8e, g = 0x25, b = 0x9a },
    		[SHIRT]  = { r = 0x3a, g = 0x14, b = 0x9f },
    		[GLOVES] = { r = 0xe5, g = 0xd3, b = 0xd0 },
    		[SHOES]  = { r = 0x87, g = 0x3f, b = 0x3c },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0x3a, g = 0x14, b = 0x9f },
    		[EMBLEM] = { r = 0xc1, g = 0x84, b = 0x15 },
		},
		{
			name = "Haunting Red",
			[PANTS]  = { r = 0x23, g = 0x06, b = 0x00 },
    		[SHIRT]  = { r = 0x80, g = 0x00, b = 0x00 },
    		[GLOVES] = { r = 0xff, g = 0x20, b = 0x20 },
    		[SHOES]  = { r = 0xa0, g = 0x00, b = 0x00 },
    		[HAIR]   = { r = 0x63, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xff, g = 0x20, b = 0x20 },
    		[CAP]    = { r = 0x80, g = 0x00, b = 0x00 },
    		[EMBLEM] = { r = 0x80, g = 0x00, b = 0x00 },
		},
		{
			name = "All Time Bro",
			[PANTS]  = { r = 0x00, g = 0x2c, b = 0xff },
    		[SHIRT]  = { r = 0xfd, g = 0x00, b = 0xfd },
    		[GLOVES] = { r = 0xff, g = 0xff, b = 0xff },
    		[SHOES]  = { r = 0xe5, g = 0x14, b = 0x0e },
    		[HAIR]   = { r = 0x1c, g = 0xe5, b = 0x23 },
    		[SKIN]   = { r = 0xfd, g = 0xe2, b = 0x00 },
    		[CAP]    = { r = 0xfd, g = 0x00, b = 0xfd },
    		[EMBLEM] = { r = 0xfd, g = 0xe2, b = 0x00 },
		},
	},
    ["luigi"] = {
		{
			name = "Default",
    		[PANTS]  = { r = 0x00, g = 0x00, b = 0xff },
    		[SHIRT]  = { r = 0x00, g = 0xff, b = 0x00 },
    		[GLOVES] = { r = 0xff, g = 0xff, b = 0xff },
    		[SHOES]  = { r = 0x72, g = 0x1c, b = 0x0e },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0x00, g = 0xff, b = 0x00 },
    		[EMBLEM] = { r = 0x00, g = 0xff, b = 0x00 },
		},
		{
			name = "Cryptic Blues",
			[PANTS]  = { r = 0x66, g = 0x2f, b = 0xa8 },
    		[SHIRT]  = { r = 0x0e, g = 0x45, b = 0xf0 },
    		[GLOVES] = { r = 0xff, g = 0xff, b = 0xff },
    		[SHOES]  = { r = 0x17, g = 0x34, b = 0x6a },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0x0e, g = 0x45, b = 0xf0 },
    		[EMBLEM] = { r = 0x57, g = 0xde, b = 0xf9 },
		},
		{
			name = "Parallel Gold",
			[PANTS]  = { r = 0x2f, g = 0x9a, b = 0x43 },
    		[SHIRT]  = { r = 0xc9, g = 0x93, b = 0x19 },
    		[GLOVES] = { r = 0xc6, g = 0xc5, b = 0xc1 },
    		[SHOES]  = { r = 0x6b, g = 0x37, b = 0x24 },
    		[HAIR]   = { r = 0x73, g = 0x06, b = 0x00 },
    		[SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 },
    		[CAP]    = { r = 0xc9, g = 0x93, b = 0x19 },
    		[EMBLEM] = { r = 0x4a, g = 0x9a, b = 0x43 },
		},
		{
			name = "Maddening Gray",
			[PANTS]  = { r = 0x23, g = 0x23, b = 0x23 },
    		[SHIRT]  = { r = 0x60, g = 0x60, b = 0x60 },
    		[GLOVES] = { r = 0xcf, g = 0xcf, b = 0xcf },
    		[SHOES]  = { r = 0x70, g = 0x70, b = 0x70 },
    		[HAIR]   = { r = 0x33, g = 0x33, b = 0x33 },
    		[SKIN]   = { r = 0xaf, g = 0xaf, b = 0xaf },
    		[CAP]    = { r = 0x60, g = 0x60, b = 0x60 },
    		[EMBLEM] = { r = 0x60, g = 0x60, b = 0x60 },
		},
		{
			name = "Wega",
    		[PANTS]  = { r = 0x4d, g = 0x54, b = 0x37 },
    		[SHIRT]  = { r = 0x94, g = 0x00, b = 0xae },
    		[GLOVES] = { r = 0xff, g = 0xff, b = 0xff },
    		[SHOES]  = { r = 0x0f, g = 0x3c, b = 0x53 },
    		[HAIR]   = { r = 0x00, g = 0x2d, b = 0x61 },
    		[SKIN]   = { r = 0x9b, g = 0x8f, b = 0xfd },
    		[CAP]    = { r = 0x94, g = 0x00, b = 0xae },
    		[EMBLEM] = { r = 0x94, g = 0x00, b = 0xae },
		},
	}
}

if _G.charSelectExists then
	for i = 1, #B3313_CHAR_PALETTES.mario do
        charSelect.character_add_palette_preset(E_MODEL_BEEIE_MARIO, B3313_CHAR_PALETTES.mario[i], B3313_CHAR_PALETTES.mario[i].name)
    end
	for i = 1, #B3313_CHAR_PALETTES.luigi do
        charSelect.character_add_palette_preset(E_MODEL_BEEIE_LUIGI, B3313_CHAR_PALETTES.luigi[i], B3313_CHAR_PALETTES.luigi[i].name)
    end

	if charSelect.version_get_full().major >= 16 then
	CS_CHAR_ANIMS = {
		["mario"] = {
			["anims"] = {
				[charSelect.CS_ANIM_MENU] = "mario_anim_cs_menu",
			},
			["eyes"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT,
			},
			["hands"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_HAND_FISTS,
			},
		},
		["luigi"] = {
			["anims"] = {
				[charSelect.CS_ANIM_MENU] = "luigi_anim_cs_menu",
			},
			["eyes"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT,
			},
			["hands"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_HAND_OPEN,
			},
		},
		--[[["toad"] = {
			["anims"] = {
				[charSelect.CS_ANIM_MENU] = "toad_anim_cs_menu",
			},
			["eyes"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT,
			},
			["hands"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_HAND_OPEN,
			},
		},
		["waluigi"] = {
			["anims"] = {
				[charSelect.CS_ANIM_MENU] = "waluigi_anim_cs_menu",
			},
			["eyes"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT,
			},
			["hands"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_HAND_OPEN,
			},
		},
		["wario"] = {
			["anims"] = {
				[charSelect.CS_ANIM_MENU] = "wario_anim_cs_menu",
			},
			["eyes"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_LEFT,
			},
			["hands"] = {
				[charSelect.CS_ANIM_MENU] = MARIO_HAND_FISTS,
			},
		},]]
	}

	charSelect.character_add_animations(E_MODEL_BEEIE_MARIO, CS_CHAR_ANIMS.mario.anims, CS_CHAR_ANIMS.mario.eyes, CS_CHAR_ANIMS.mario.hands)
	charSelect.character_add_animations(E_MODEL_BEEIE_LUIGI, CS_CHAR_ANIMS.luigi.anims, CS_CHAR_ANIMS.luigi.eyes, CS_CHAR_ANIMS.luigi.hands)
	end
end

--[[function model_handling(m)
	if chungus then
		custom_model_stats = E_MODEL_BEEIE_CHUNGUS b_model = 3
	else
		if not gPlayerSyncTable[0].vanillaMario then
			custom_model_stats = b3313_models[gMarioStates[0].character.type][2] b_model = 2
		else
			if _G.charSelectExists then custom_model_stats = b3313_models[gMarioStates[0].character.type][1] b_model = 1
			else custom_model_stats = nil end
		end
	end
	gPlayerSyncTable[m.playerIndex].modelId = custom_model_stats
end]]

function model_handling(m)
	if b3313_models[gMarioStates[0].character.type] ~= nil then
		if chungus then
			custom_model_stats = E_MODEL_BEEIE_CHUNGUS b_model = 3
		else
			if not gPlayerSyncTable[0].vanillaMario then
				custom_model_stats = b3313_models[gMarioStates[0].character.type][2] b_model = 2
			else
				if _G.charSelectExists then custom_model_stats = b3313_models[gMarioStates[0].character.type][1] b_model = 1
				else custom_model_stats = nil end
			end
		end
		gPlayerSyncTable[m.playerIndex].modelId = custom_model_stats
	else
		gPlayerSyncTable[m.playerIndex].modelId = gMarioStates[0].character.modelId
	end
end

function set_model(o, model)
	if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
		if _G.charSelectExists then
			_G.charSelect.character_edit_costume(0, 1, nil, nil, nil, nil, b3313_models[CT_MARIO][b_model])
			_G.charSelect.character_edit_costume(1, 1, nil, nil, nil, nil, b3313_models[CT_LUIGI][b_model])
			_G.charSelect.character_edit_costume(2, 1, nil, nil, nil, nil, b3313_models[CT_TOAD][b_model])
			_G.charSelect.character_edit_costume(3, 1, nil, nil, nil, nil, b3313_models[CT_WALUIGI][b_model])
			_G.charSelect.character_edit_costume(4, 1, nil, nil, nil, nil, b3313_models[CT_WARIO][b_model])
		else
        	if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            	obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        	end
		end
        return
    end
end
hook_event(HOOK_OBJECT_SET_MODEL, set_model)

function betaShadingAndTilt(m)
    if m.playerIndex == 0 then
        model_handling(m)
	end

	if (gPlayerSyncTable[m.playerIndex].B3313_Moveset) or (not gPlayerSyncTable[m.playerIndex].vanillaMario) then
		if m.action == ACT_WALKING or m.action == ACT_BUTT_SLIDE or m.action == ACT_RIDING_SHELL_GROUND or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL then
			m.marioBodyState.torsoAngle.x = 0
			m.marioBodyState.torsoAngle.z = 0
		end
	end

	if not gPlayerSyncTable[m.playerIndex].vanillaMario then
		m.marioBodyState.shadeR = 63
		m.marioBodyState.shadeG = 63
		m.marioBodyState.shadeB = 63
		-- beta crouch handler
		if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_STOP_CROUCHING then
			smlua_anim_util_set_animation(m.marioObj, "stop_crouching")
		end
		if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_START_CROUCHING then
			smlua_anim_util_set_animation(m.marioObj, "start_crouching")
		end
		if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_CROUCHING then
			smlua_anim_util_set_animation(m.marioObj, "crouching")
		end
		-- Extra animation flare for twirl start
		if m.action == ACT_TWIRLING  then
			if m.pos.y == m.peakHeight then
				set_mario_animation(m, MARIO_ANIM_DOUBLE_JUMP_FALL)
			end
		end
	elseif gPlayerSyncTable[m.playerIndex].vanillaMario then
		m.marioBodyState.shadeR = 127
		m.marioBodyState.shadeG = 127
		m.marioBodyState.shadeB = 127
	end
end

------------------
-- MOVESET CODE --
------------------

--B3313_Moveset = true
enableBeeie09 = false
bluigiSlideFix = false
extraCharsOn = false
charMovesetsOn = false

for i = 0, #gActiveMods, 1 do
	if gActiveMods[i].name:find("Character Movesets") or gActiveMods[i].name:find("CMS") then
		charMovesetsOn = true
		bluigiSlideFix = true
	end
	if gActiveMods[i].name:find("Extra Characters Plus") then
		extraCharsOn = true
	end
end

ACT_GROUND_POUND_B3313 = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ATTACKING)
function act_ground_pound_b3313(m)
    local e = gStateExtras[m.playerIndex]
	    if m.actionTimer == 0 then
		    m.vel.y = -45
		    e.animFrame = 2
		    play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
		    play_character_sound(m, CHAR_SOUND_GROUND_POUND_WAH)
	    end
	    mario_set_forward_vel(m, 0)
	    m.vel.y = m.vel.y + 1.75

	    local stepResult = perform_air_step(m, 0)
	    if stepResult == AIR_STEP_LANDED then
		    if should_get_stuck_in_ground(m) ~= 0 then
			    queue_rumble_data_mario(m, 5, 80)
			    play_sound(SOUND_MARIO_OOOF2, m.marioObj.header.gfx.cameraToObject)
			    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
			    set_mario_action(m, ACT_BUTT_STUCK_IN_GROUND, 0)
		    else
			    play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING)
			    if check_fall_damage(m, ACT_HARD_BACKWARD_GROUND_KB) == 0 then
				    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR
				    set_mario_action(m, ACT_GROUND_POUND_LAND, 0)
			    end
		    end
	    end

	    set_mario_animation(m, MARIO_ANIM_START_GROUND_POUND)
	    set_anim_to_frame(m, e.animFrame)
	    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
		    e.animFrame = m.marioObj.header.gfx.animInfo.curAnim.loopEnd
	    end
	    e.animFrame = e.animFrame + 1
	    m.actionTimer = m.actionTimer + 1
	    return
end

ACT_SQUAT_KICK_B3313 = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION | ACT_FLAG_SHORT_HITBOX | ACT_FLAG_ATTACKING)
function act_squatkick_b3313(m)
    play_sound_if_no_flag(m, SOUND_ACTION_THROW, MARIO_ACTION_SOUND_PLAYED)
    set_mario_animation(m, m.actionArg == 0 and MARIO_ANIM_START_GROUND_POUND or MARIO_ANIM_TRIPLE_JUMP_GROUND_POUND)
    if m.actionState == 0 then
        if m.actionTimer == 0 then
			m.forwardVel = m.forwardVel * 1.75
        end
        m.vel.y = m.vel.y + 5
        if m.marioObj.header.gfx.animInfo.animFrame >= 2 then
            perform_air_step(m, 0)
        end
        if m.marioObj.header.gfx.animInfo.animFrame >= 3 then
            m.actionState = m.actionState + 1
        end
        play_mario_sound(m, SOUND_ACTION_TERRAIN_JUMP, 0)
    else
        local airStepResult = perform_air_step(m, 0)

        if airStepResult == AIR_STEP_HIT_LAVA_WALL then
            lava_boost_on_wall(m)
        elseif airStepResult == AIR_STEP_HIT_WALL then
            mario_set_forward_vel(m, -8.0)
            return set_mario_action(m, ACT_SOFT_BONK, 0)
        elseif airStepResult == AIR_STEP_NONE then
            if m.actionState == 1 then
                m.flags = m.flags | MARIO_KICKING
                update_air_without_turn(m)
                if is_anim_past_end(m) then
                    m.actionState = m.actionState + 1
                end
            elseif m.actionState == 2 then
                update_air_without_turn(m)
            end
        elseif airStepResult == AIR_STEP_LANDED then
            set_mario_action(m, ACT_BUTT_SLIDE, 0)
            play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        end
    end
	m.actionTimer = m.actionTimer + 1
    return smlua_anim_util_set_animation(m.marioObj, "squatkick")
end

function boo_bounce(m, o, intType)
	if gPlayerSyncTable[0].B3313_Moveset then
		if intType & (INTERACT_BOUNCE_TOP | INTERACT_BOUNCE_TOP2) ~= 0 and m.pos.y > o.oPosY and m.vel.y < 0 then
			if get_id_from_behavior(o.behavior) == id_bhvBoo
			or get_id_from_behavior(o.behavior) == id_bhvCourtyardBooTriplet
			or get_id_from_behavior(o.behavior) == id_bhvGhostHuntBoo
			or get_id_from_behavior(o.behavior) == id_bhvMerryGoRoundBoo
			or get_id_from_behavior(o.behavior) == id_bhvBooInCastle
			or get_id_from_behavior(o.behavior) == id_bhvBooWithCage
			or get_id_from_behavior(o.behavior) == id_bhvGhostHuntBigBoo
			or get_id_from_behavior(o.behavior) == id_bhvMerryGoRoundBigBoo
			or get_id_from_behavior(o.behavior) == id_bhvBalconyBigBoo
			then
				o.oInteractStatus = ATTACK_PUNCH + (INT_STATUS_INTERACTED | INT_STATUS_WAS_ATTACKED)
				if m.action ~= ACT_GROUND_POUND and m.action ~= ACT_GROUND_POUND_B3313 then
					m.vel.y = 35
				end
				play_sound(SOUND_ACTION_HIT, m.marioObj.header.gfx.cameraToObject)
				return false
			end
		end
    end
end

local function convert_s16(num)
	num = num & 0xFFFF
	return ((num >= 0x7FFF) and (num - 0x10000) or num)
end

---@param m MarioState
local function update_custom_hang_moving(m)
	local stepResult = 0
	local nextPos = {}
	local maxSpeed = 10

	if gPlayerSyncTable[0].B3313_Moveset then
		maxSpeed = 10
	else
		maxSpeed = 4
	end
	
	m.forwardVel = m.forwardVel + 10
	if m.forwardVel > maxSpeed then
		m.forwardVel = maxSpeed
	end

	m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x800, 0x800)

	m.slideYaw = m.faceAngle.y
	m.slideVelX = m.forwardVel * sins(m.faceAngle.y)
	m.slideVelZ = m.forwardVel * coss(m.faceAngle.y)

	m.vel.x = m.slideVelX
	m.vel.y = 0.0
	m.vel.z = m.slideVelZ

	nextPos.x = m.pos.x - m.ceil.normal.y * m.vel.x
	nextPos.z = m.pos.z - m.ceil.normal.y * m.vel.z
	nextPos.y = m.pos.y

	stepResult = perform_hanging_step(m, nextPos)

	vec3f_copy(m.marioObj.header.gfx.pos, m.pos)
	vec3s_set(m.marioObj.header.gfx.angle, 0, m.faceAngle.y, 0)
	return stepResult
end

---@param m MarioState
function act_custom_hang_moving(m)
	if m.input & INPUT_A_DOWN == 0 then
		return set_mario_action(m, ACT_FREEFALL, 0)
	end

	if m.input & INPUT_Z_PRESSED ~= 0 then
		return set_mario_action(m, ACT_GROUND_POUND, 0)
	end

	if m.ceil == nil or m.ceil.type ~= SURFACE_HANGABLE then
		return set_mario_action(m, ACT_FREEFALL, 0)
	end

	if m.actionArg & 1 ~= 0 then
		set_mario_animation(m, MARIO_ANIM_MOVE_ON_WIRE_NET_RIGHT)
	else
		set_mario_animation(m, MARIO_ANIM_MOVE_ON_WIRE_NET_LEFT)
	end

	if m.marioObj.header.gfx.animInfo.animFrame == 12 then
		play_sound(SOUND_ACTION_HANGING_STEP, m.marioObj.header.gfx.cameraToObject)
		queue_rumble_data_mario(m, 5, 30)
	end

	if is_anim_past_end(m) ~= 0 then
		m.actionArg = m.actionArg ~ 1
		if m.input & INPUT_ZERO_MOVEMENT ~= 0 then
			return set_mario_action(m, ACT_HANGING, m.actionArg)
		end
	end

	if update_custom_hang_moving(m) == 2 --[[HANG_LEFT_CEIL]] then
		set_mario_action(m, ACT_FREEFALL, 0)
	end

	return 0
end

ACT_SPAWN_SPIN_AIRBORNE_BETA = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ATTACKING)
function act_spawn_spin_airborne_beta(m)
    m.peakHeight = m.pos.y
    if m.pos.y < m.waterLevel - 100 then
        return set_water_plunge_action(m)
    end

    m.forwardVel = 2
    m.freeze = 1

    update_air_without_turn(m)
    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)

    local airStepResult = perform_air_step(m, 0)
    if airStepResult == AIR_STEP_LANDED then
        m.actionState = m.actionState + 1
        if m.actionState == 1 then
            m.vel.y = 47.0
        end
    end
    if m.actionState == 2 then
        m.action = ACT_SPAWN_SPIN_LANDING
    end
    m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
    return false
end

local function beta_mario_before_phys_step(m)
    if (m.playerIndex ~= 0) then return end

	local slipperyFloors = (m.floor.type == SURFACE_CLASS_SLIPPERY 
    or m.floor.type == SURFACE_CLASS_VERY_SLIPPERY 
    or m.floor.type == SURFACE_HARD_SLIPPERY 
    or m.floor.type == SURFACE_HARD_VERY_SLIPPERY
	or m.floor.type == SURFACE_NOISE_SLIPPERY
    or m.floor.type == SURFACE_NOISE_VERY_SLIPPERY
    or m.floor.type == SURFACE_NOISE_VERY_SLIPPERY_73
    or m.floor.type == SURFACE_NOISE_VERY_SLIPPERY_74
    or m.floor.type == SURFACE_NO_CAM_COL_SLIPPERY
    or m.floor.type == SURFACE_NO_CAM_COL_VERY_SLIPPERY
    or m.floor.type == SURFACE_SLIPPERY
    or m.floor.type == SURFACE_VERY_SLIPPERY
    or m.floor.type == SURFACE_ICE
    or m.area.terrainType == 6)


	local hScale = 1.0
	local vScale = 1.0
	
    -- friction
	if gPlayerSyncTable[0].B3313_Moveset then
    	if not slipperyFloors then

			if _G.charSelectExists and extraCharsOn then
				if (m.character.type == CT_LUIGI and charSelect.character_is_vanilla()) and gCSPlayers[0].movesetToggle then
					bluigiSlideFix = true
				else
					bluigiSlideFix = false
				end
			end

			if (m.character.type == CT_LUIGI and bluigiSlideFix) then
				if (m.action == ACT_BRAKING or m.action == ACT_TURNING_AROUND) then
					m.forwardVel = m.forwardVel + (hScale * 1)
				end
				if (m.action == ACT_MOVE_PUNCHING) then
					m.forwardVel = m.forwardVel + (hScale * 0.1)
				end
			else
				if (m.action == ACT_BRAKING or m.action == ACT_TURNING_AROUND) then
					m.forwardVel = m.forwardVel + (hScale * 2.5)
				end
				if (m.action == ACT_MOVE_PUNCHING) then
					m.forwardVel = m.forwardVel + (hScale * 0.5)
				end
			end
			if (m.controller.stickY >  0) then
				m.slideVelX = (m.slideVelX * 1.03) + (sins(m.faceAngle.y) * 0.005)
				m.slideVelZ = (m.slideVelZ * 1.03) + (coss(m.faceAngle.y) * 0.005)
			else
				m.slideVelX = m.slideVelX + (sins(m.faceAngle.y) * 0.01)
				m.slideVelZ = m.slideVelZ + (coss(m.faceAngle.y) * 0.01)
			end
    	end
	end
end


function mario_on_set_action(m)
	if (m.playerIndex ~= 0) then return end
	-- Prevent pipe softlocks
	if m.action == ACT_EMERGE_FROM_PIPE then
		m.vel.y = m.vel.y + 10
	end
	-- Change exit-save logic
	--[[if m.action == ACT_EXIT_LAND_SAVE_DIALOG then
		m.faceAngle.y = m.faceAngle.y - 32767
		create_dialog_box_with_response(14)
		set_mario_action(m, ACT_JUMP_LAND, 1)
	end]]
	if gPlayerSyncTable[0].B3313_Moveset then
		if m.action == ACT_JUMP or m.action == ACT_DOUBLE_JUMP or m.action == ACT_BACKFLIP or m.action == ACT_SIDE_FLIP or m.action == ACT_DIVE or m.action == ACT_JUMP_KICK or m.action == ACT_BACKWARD_ROLLOUT or m.action == ACT_FORWARD_ROLLOUT or m.action == ACT_WATER_JUMP then
			m.vel.y = m.vel.y + 5
		end
		if m.action == ACT_TWIRLING then
			m.vel.y = m.vel.y + 6
		end
		if m.action == ACT_WALL_KICK_AIR then
			m.vel.y = m.vel.y + 10
		end
		if m.action == ACT_LONG_JUMP then
			m.vel.y = m.vel.y + 1.5
		end
		if m.action == ACT_WALKING and m.forwardVel < 16 and (m.prevAction == ACT_IDLE or m.prevAction == ACT_PANTING or m.prevAction == ACT_DECELERATING or m.prevAction == ACT_BRAKING or m.prevAction == ACT_BRAKING_STOP)  then
			mario_set_forward_vel(m, 16)
		end
		if m.action == ACT_BRAKING then
			set_mario_action(m, ACT_IDLE, 0)
		end
		if m.action == ACT_BACKFLIP_LAND then
			set_mario_action(m, ACT_DOUBLE_JUMP_LAND_STOP, 0)
		end
		if m.action == ACT_GROUND_POUND then
			set_mario_action(m, ACT_GROUND_POUND_B3313, 0)
		end
		if m.action == ACT_AIR_HIT_WALL then
            set_mario_animation(m, MARIO_ANIM_START_WALLKICK)
        end
		if m.action == ACT_SPAWN_SPIN_AIRBORNE then
			set_mario_action(m, ACT_SPAWN_SPIN_AIRBORNE_BETA, 0)
		end
		-- Squatkick
		if enableBeeie09 then
			if m.action == ACT_SLIDE_KICK then
				set_mario_action(m, ACT_SQUAT_KICK_B3313, 0)
			end
			if m.action == ACT_GET_UP then
				set_mario_action(m, ACT_GET_UP_HOLDING, 0)
			end
		end
	end
end

local rotation = {0, 0, 0}
--vec3f_set(rotation, 0, 0, 0)
fakewings = false
extendedFly = false
function mario_update(m)
    local e = gStateExtras[m.playerIndex]
	betaShadingAndTilt(m)
	--if (m.playerIndex ~= 0) then return end
	if gPlayerSyncTable[0].B3313_Moveset then
		if m.action == ACT_BUTT_SLIDE or m.action == ACT_BUTT_SLIDE_AIR then
			set_mario_animation(m, MARIO_ANIM_SLIDE_MOTIONLESS)
		end
		if m.action == ACT_AIR_HIT_WALL then
            m.marioObj.header.gfx.angle.y = m.faceAngle.y + 0x8000
        end
		if m.action == ACT_IDLE then
			m.actionTimer = m.actionTimer + 1
		end
		if (m.action == ACT_TRIPLE_JUMP or m.action == ACT_SPECIAL_TRIPLE_JUMP) and (m.prevAction == ACT_DOUBLE_JUMP_LAND or m.prevAction == ACT_DOUBLE_JUMP_LAND_STOP) then
            if (m.controller.buttonDown & A_BUTTON) ~= 0 then
                m.action = ACT_TWIRLING
                play_character_sound(m, CHAR_SOUND_YAHOO_WAHA_YIPPEE)
            elseif (m.controller.buttonDown & A_BUTTON) ~= 0 and (m.controller.buttonDown & B_BUTTON) ~= 0 then
                m.action = ACT_DIVE
                m.vel.y = 105
            end
        end
		-- Delay Mario's sleeping while in dialog
		local isInDialog = get_dialog_box_state()
		if isInDialog ~= 0 and m.action == ACT_IDLE then
			m.actionTimer = 0
		end
		if m.marioBodyState.wingFlutter == 1 then
			m.vel.y = m.vel.y - 2
		end
		if m.action == ACT_PUNCHING or m.action == ACT_MOVE_PUNCHING then
			if m.actionArg == 3 then
				if m.action == ACT_PUNCHING then
					return set_mario_action(m, ACT_PUNCHING, 6)
				else
					return set_mario_action(m, ACT_MOVE_PUNCHING, 6)
				end
			end
		end
		if (m.action & ACT_FLAG_SWIMMING) == 0 and (m.input & INPUT_IN_POISON_GAS == 0) then
			if m.health > 0x100 then
				if m.health < 0x800 then
					e.healTimer = e.healTimer - 1
					if e.healTimer < 0 then
						m.health = m.health + 0x100
						e.healTimer = 200
					end
				elseif m.health > 0x800 then
					e.healTimer = 200
				end
			end
		end

		--fly from cannon
		-- Visually keep Mario's cap the same during the fake wing cap state
		if gPlayerSyncTable[m.playerIndex].switch_cap_state then
			if m.marioBodyState.capState == 0 or m.marioBodyState.capState ==  2 then m.marioBodyState.capState = 0
			elseif m.marioBodyState.capState == 1 or m.marioBodyState.capState == 3 then m.marioBodyState.capState = 1 end
		end
		-- Initial launch, distinguish from regular flying/launching with a wing cap using fakewings flag
		if m.action == ACT_SHOT_FROM_CANNON and m.flags == m.flags & ~MARIO_WING_CAP then
			if (m.playerIndex == 0) then
				m.flags = m.flags | MARIO_WING_CAP
				fakewings = true
			end
			gPlayerSyncTable[m.playerIndex].switch_cap_state = true
		end
		-- Remove fakewings upon stopping flight
		if (m.action ~= ACT_FLYING and m.action ~= ACT_SHOT_FROM_CANNON) and m.flags & MARIO_WING_CAP ~= 0 and fakewings then
			m.flags = m.flags & ~MARIO_WING_CAP
			fakewings = false
			gPlayerSyncTable[m.playerIndex].switch_cap_state = false
		end
		-- Keep Mario in the air after wing cap timer depletion
		if m.capTimer <= 5 and m.flags & MARIO_WING_CAP ~= 0 and m.action == ACT_FLYING and not fakewings and (m.playerIndex == 0) then
			extendedFly = true
		--else extendedFly = false
		end
		if extendedFly and m.action == ACT_FREEFALL then
			set_mario_animation(m, CHAR_ANIM_WING_CAP_FLY)
			if (m.playerIndex == 0) then
				m.flags = m.flags | MARIO_WING_CAP
				fakewings = true
				m.action = ACT_FLYING
				extendedFly = false
			end
			gPlayerSyncTable[m.playerIndex].switch_cap_state = true
		end
		-- 0.9+ flying
		if enableBeeie09 then
			if (m.flags & MARIO_WING_CAP ~= 0) and m.action == ACT_FLYING and (m.marioBodyState.capState ~= 0 and m.marioBodyState.capState ~= 1) then
				--vec3f_set(rotation, m.faceAngle.x, 0, m.faceAngle.z)          
				m.forwardVel = 45
				m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
				if (m.controller.stickY == 0) then
					m.faceAngle.x = m.faceAngle.x - 79
				end
			end
		end
	end
end

function on_pause_exit()
    m.action = ACT_SPAWN_SPIN_AIRBORNE
end

hook_event(HOOK_BEFORE_PHYS_STEP, beta_mario_before_phys_step)
hook_mario_action(ACT_GROUND_POUND_B3313, act_ground_pound_b3313, INT_GROUND_POUND_OR_TWIRL)
hook_mario_action(ACT_SQUAT_KICK_B3313, act_squatkick_b3313, INT_SLIDE_KICK)
hook_event(HOOK_ALLOW_INTERACT, boo_bounce)
--hook_mario_action(ACT_SPAWN_SPIN_AIRBORNE, act_spawn_spin_airborne, INT_ANY_ATTACK)
hook_mario_action(ACT_SPAWN_SPIN_AIRBORNE_BETA, act_spawn_spin_airborne_beta, INT_ANY_ATTACK)
hook_mario_action(ACT_HANG_MOVING, act_custom_hang_moving)
hook_event(HOOK_ON_SET_MARIO_ACTION, mario_on_set_action)
hook_event(HOOK_ON_PAUSE_EXIT, on_pause_exit)
hook_event(HOOK_MARIO_UPDATE, mario_update)

function beeieMarioAesthetics_command(msg)
    gPlayerSyncTable[0].vanillaMario = not gPlayerSyncTable[0].vanillaMario
	play_character_sound(gMarioStates[0], CHAR_SOUND_HOOHOO)
	play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].pos)
    return true
end

function beeieMoveset_command(msg)
	gPlayerSyncTable[0].B3313_Moveset = not gPlayerSyncTable[0].B3313_Moveset
	play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].pos)
    return true
end

function beeieQOL_command(msg)
	enableBeeie09 = not enableBeeie09
	play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].pos)
    return true
end

function beeieChungus_command(msg)
    chungus = not chungus
	play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].pos)
    return true
end

function bLuigiSlidePatch_command(msg)
	bluigiSlideFix = not bluigiSlideFix
	play_sound(SOUND_MENU_STAR_SOUND, gMarioStates[0].pos)
    return true
end

hook_mod_menu_checkbox("B3313 Moveset", gPlayerSyncTable[0].B3313_Moveset, beeieMoveset_command)
hook_mod_menu_checkbox("Additional Moves (0.9+)", enableBeeie09, beeieQOL_command)
hook_mod_menu_checkbox("Vanilla Mario", gPlayerSyncTable[0].vanillaMario, beeieMarioAesthetics_command)
hook_mod_menu_checkbox("Chungus Mode", chungus, beeieChungus_command)
if charMovesetsOn then hook_mod_menu_checkbox("Luigi Slide Fix (Character Moveset Support)", bluigiSlideFix, bLuigiSlidePatch_command) end