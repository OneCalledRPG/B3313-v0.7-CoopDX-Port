gLevelValues.exitCastleLevel = 16
gLevelValues.exitCastleArea = 3
gLevelValues.exitCastleWarpNode = 10
gBehaviorValues.KingBobombFVel = 3.0
gBehaviorValues.KingBobombYawVel = 256
gBehaviorValues.KingBobombHealth = 3
gBehaviorValues.KingWhompHealth = 3
gBehaviorValues.KoopaThiAgility = 6.0
gBehaviorValues.KoopaBobAgility = 4.0
gBehaviorValues.MipsStar1Requirement = 15
gBehaviorValues.MipsStar2Requirement = 50
gBehaviorValues.ToadStar1Requirement = 12
gBehaviorValues.ToadStar2Requirement = 25
gBehaviorValues.ToadStar3Requirement = 35
gLevelValues.pssSlideStarTime = 630
gLevelValues.metalCapDuration = 600
gLevelValues.wingCapDuration = 1800
gLevelValues.vanishCapDuration = 600
gLevelValues.metalCapDurationCotmc = 1
gLevelValues.wingCapDurationTotwc = 1
gLevelValues.vanishCapDurationVcutm = 1
--gLevelValues.coinsRequiredForCoinStar = 100
gLevelValues.numCoinsToLife = 0
gServerSettings.stayInLevelAfterStar = 0
gServerSettings.pauseAnywhere = 0
gServerSettings.skipIntro = 1

--local bool_to_num = {[false] = 0,[true] = 1}
coincount = 0
displaycoin = 0
hudBuffer = false
joinedLives = false
warp_delay = 0
transition = 0
castle_grounds_warp_sound = false
displayLives = 0
currLives = 0
allow_negative_lives = false

--[[hook_event(HOOK_ON_MODS_LOADED, funtion()
    displayLives = 2
    hud_set_value(HUD_DISPLAY_LIVES, displayLives)
end)]]

local function life_update(m)
    if m.playerIndex ~= 0 then return end
    
    -- Start with 2 lives
    if not joinedLives then
        displayLives = 2
		currLives = 2
        set_mario_action(m, ACT_FIRST_PERSON, 0)
        joinedLives = true
    end

    -- Handle lives
	if m.numLives > 4 then
        play_sound(SOUND_GENERAL_COLLECT_1UP, m.marioObj.header.gfx.cameraToObject)
		currLives = currLives + 1
		m.numLives = m.numLives - 1
        displayLives = currLives
	end

    -- Handle deaths
	if m.numLives < 4 then
        -- Do not kill player in Peach's Cell quicksand or falling from Balcony to Uncanny Courtyard
		if (gNetworkPlayers[m.playerIndex].currLevelNum == LEVEL_THI and ((gNetworkPlayers[m.playerIndex].currAreaIndex == 6) or (gNetworkPlayers[m.playerIndex].currAreaIndex == 7)))
		or (gNetworkPlayers[m.playerIndex].currLevelNum == LEVEL_RR and (gNetworkPlayers[m.playerIndex].currAreaIndex == 5)) then
			currLives = currLives
		else
			currLives = currLives - 1
		end
		m.numLives = m.numLives + 1
		displayLives = currLives
	end

    if (gNetworkPlayers[0].currLevelNum == LEVEL_THI and gNetworkPlayers[0].currAreaIndex == 1) and castle_grounds_warp_sound then
        play_sound(SOUND_MENU_MARIO_CASTLE_WARP, m.pos)
        castle_grounds_warp_sound = false
    end

	-- life loop-back (negative limit)
	if displayLives < -128 then
		displayLives = 100
	end
	-- life cut-off point (positive limit)
	if displayLives > 100 then
		displayLives = 100
	end

    if displayLives >= 0 then allow_negative_lives = false end

    --hud_set_value(HUD_DISPLAY_LIVES, displayLives)
end

local function on_death(m)
    local m = gMarioStates[0]
    if displayLives == -1 and not allow_negative_lives then
            currLives = 2
            displayLives = 2
            m.health = 0x880
            displayCoin = 0
            coincount = 0
            warp_to_warpnode(LEVEL_THI, 1, 0, 10)
            --play_sound(SOUND_MENU_MARIO_CASTLE_WARP, m.pos)
            castle_grounds_warp_sound = true
            set_mario_action(m, ACT_SPAWN_SPIN_AIRBORNE, 0)
        --end
    end
end
hook_event(HOOK_ON_WARP, on_death)

--[[local function coin_interact(m, o,interactType)
    if (m.playerIndex ~= 0) then
        return
    elseif (m.playerIndex == 0) then
        if interactType == INTERACT_COIN then
            --if (course_is_main_course(gNetworkPlayers[0].currCourseNum)) and (coincount < gLevelValues.coinsRequiredForCoinStar) and ((coincount + o.oDamageOrCoinValue) >= gLevelValues.coinsRequiredForCoinStar)then
            --    bhv_spawn_star_no_level_exit(m.marioObj, 6, bool_to_num[false])
            --end
            coincount = coincount + o.oDamageOrCoinValue
            hud_set_value(HUD_DISPLAY_COINS, displaycoin)
        end
    end
end

local function coin_update(m)
    if m.playerIndex ~= 0 then
        m.numCoins = 0
        return
    end
    m.numCoins = 0
    if coincount >= 100 and displaycoin == 99 then
        coincount = coincount - 100
        displaycoin = 0
        m.numLives = m.numLives + 1
    end
    --if coincount < 0 and displaycoin == 0 then
    --    coincount = coincount + 100
    --    displaycoin = 99
    --    m.numLives = m.numLives - 1
    --    if displayLives == -1 then allow_negative_lives = true end
    --end
    if not hudBuffer then
        if coincount > displaycoin then
            displaycoin = displaycoin + 1
            play_sound(SOUND_GENERAL_COIN, m.marioObj.header.gfx.cameraToObject)
        elseif coincount < displaycoin then
            displaycoin = displaycoin - 1
            --play_sound(SOUND_GENERAL_COIN, m.marioObj.header.gfx.cameraToObject)
        end
        hudBuffer = true
    else
        hudBuffer = false
    end
    hud_set_value(HUD_DISPLAY_COINS, displaycoin)
end]]

local function life_and_coin_update(m)
    life_update(m)
    --coin_update(m)
end

hook_event(HOOK_MARIO_UPDATE, life_and_coin_update)
--hook_event(HOOK_ON_INTERACT, coin_interact)