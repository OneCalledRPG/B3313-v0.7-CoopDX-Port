-- name:[v0.7] \\#F78AF5\\B\\#F94A36\\3\\#4C5BFF\\3\\#EDD83D\\1\\#16C31C\\3
-- description: \\#F78AF5\\B\\#F94A36\\3\\#4C5BFF\\3\\#EDD83D\\1\\#16C31C\\3\\#dcdcdc\\ v0.7 Coop\nWill you play the game, or will it play you?\n\n Original hack by Chris R Lillo and B3313's contributers\n Ported by TikalSM64, blocky.cmd, and the B3313 Coop Port Team
-- incompatible: romhack

gLevelValues.fixCollisionBugs = true
gLevelValues.fixCollisionBugsRoundedCorners = false
gLevelValues.fixCollisionBugsFalseLedgeGrab = false
gLevelValues.fixCollisionBugsGroundPoundBonks = false
gLevelValues.fixCollisionBugsPickBestWall = false

function waterUpwarpFix()
	--Affects clipping out of bounds in water, ground collision issues in some levels
    if gNetworkPlayers[0].currLevelNum == LEVEL_WF and (gNetworkPlayers[0].currAreaIndex == 3 or gNetworkPlayers[0].currAreaIndex == 4 or gNetworkPlayers[0].currAreaIndex == 5)
    or gNetworkPlayers[0].currLevelNum == LEVEL_WMOTR and (gNetworkPlayers[0].currAreaIndex == 5 or gNetworkPlayers[0].currAreaIndex == 6) then
        gLevelValues.fixCollisionBugs = false
    else
        gLevelValues.fixCollisionBugs = true
    end
end
hook_event(HOOK_ON_WARP, waterUpwarpFix)

camera_set_use_course_specific_settings(0)
camera_set_romhack_override(RCO_NONE)
rom_hack_cam_set_collisions(1)
camera_romhack_allow_centering(0)
camera_set_use_course_specific_settings(false)
camera_romhack_allow_only_mods(1)

--gLevelValues.respawnBlueCoinsSwitch = true

-- Texture Override for things that don't work automatically
texture_override_set("texture_transition_bowser_half", get_texture_info("beta_skull_transition"))

gLevelValues.wingCapDurationTotwc = 1
gLevelValues.metalCapDurationCotmc = 1
gLevelValues.vanishCapDurationVcutm = 1

gLevelValues.entryLevel = LEVEL_THI
gLevelValues.skipCreditsAt = LEVEL_BOB

-- Music
smlua_audio_utils_replace_sequence(0x02, 0x11, 75, "02_Seq_custom")
smlua_audio_utils_replace_sequence(0x03, 0x22, 75, "03_Seq_custom")
smlua_audio_utils_replace_sequence(0x04, 0x0E, 75, "04_Seq_custom")
smlua_audio_utils_replace_sequence(0x05, 0x13, 75, "05_Seq_custom")
smlua_audio_utils_replace_sequence(0x06, 0x0F, 75, "06_Seq_custom")
smlua_audio_utils_replace_sequence(0x07, 0x12, 75, "07_Seq_custom")
smlua_audio_utils_replace_sequence(0x08, 0x0B, 75, "08_Seq_custom")
smlua_audio_utils_replace_sequence(0x09, 0x22, 75, "09_Seq_custom")
smlua_audio_utils_replace_sequence(0x0A, 0x10, 75, "0A_Seq_custom")
smlua_audio_utils_replace_sequence(0x0B, 0x14, 75, "0B_Seq_custom")
smlua_audio_utils_replace_sequence(0x0C, 0x15, 75, "0C_Seq_custom")
smlua_audio_utils_replace_sequence(0x0D, 0x16, 75, "0D_Seq_custom")
smlua_audio_utils_replace_sequence(0x0E, 0x0D, 75, "0E_Seq_custom")
smlua_audio_utils_replace_sequence(0x0F, 0x18, 75, "0F_Seq_custom")
smlua_audio_utils_replace_sequence(0x10, 0x12, 75, "10_Seq_custom")
smlua_audio_utils_replace_sequence(0x11, 0x19, 75, "11_Seq_custom")
smlua_audio_utils_replace_sequence(0x12, 0x1F, 75, "12_Seq_custom")
smlua_audio_utils_replace_sequence(0x13, 0x21, 75, "13_Seq_custom")
smlua_audio_utils_replace_sequence(0x14, 0x1A, 75, "14_Seq_custom")
smlua_audio_utils_replace_sequence(0x15, 0x0E, 75, "15_Seq_custom")
smlua_audio_utils_replace_sequence(0x16, 0x1B, 75, "16_Seq_custom")
smlua_audio_utils_replace_sequence(0x17, 0x1A, 75, "17_Seq_custom")
smlua_audio_utils_replace_sequence(0x19, 0x19, 75, "19_Seq_custom")
smlua_audio_utils_replace_sequence(0x1B, 0x14, 75, "1B_Seq_custom")
smlua_audio_utils_replace_sequence(0x1C, 0x20, 75, "1C_Seq_custom")
smlua_audio_utils_replace_sequence(0x1D, 0x1E, 75, "1D_Seq_custom")
smlua_audio_utils_replace_sequence(0x1E, 0x1B, 75, "1E_Seq_custom")
smlua_audio_utils_replace_sequence(0x1F, 0x1A, 75, "1F_Seq_custom")
smlua_audio_utils_replace_sequence(0x20, 0x23, 75, "20_Seq_custom")
smlua_audio_utils_replace_sequence(0x21, 0x24, 75, "21_Seq_custom")
smlua_audio_utils_replace_sequence(0x25, 0x0F, 50, "25_Seq_custom")
smlua_audio_utils_replace_sequence(0x26, 0x13, 75, "26_Seq_custom") 
smlua_audio_utils_replace_sequence(0x27, 0x25, 75, "27_Seq_custom")
smlua_audio_utils_replace_sequence(0x2A, 0x25, 75, "2A_Seq_custom")
smlua_audio_utils_replace_sequence(0x2B, 0x11, 75, "2B_Seq_custom")
smlua_audio_utils_replace_sequence(0x2C, 0x0C, 75, "2C_Seq_custom")
smlua_audio_utils_replace_sequence(0x33, 0x1E, 75, "33_Seq_custom")
smlua_audio_utils_replace_sequence(0x34, 0x0E, 75, "34_Seq_custom")
smlua_audio_utils_replace_sequence(0x35, 0x0C, 75, "35_Seq_custom")
smlua_audio_utils_replace_sequence(0x36, 0x25, 125, "36_Seq_custom")
smlua_audio_utils_replace_sequence(0x38, 0x14, 75, "38_Seq_custom")
smlua_audio_utils_replace_sequence(0x3A, 0x0E, 75, "3A_Seq_custom")
smlua_audio_utils_replace_sequence(0x3B, 0x25, 75, "3B_Seq_custom")
smlua_audio_utils_replace_sequence(0x3C, 0x14, 75, "3C_Seq_custom")
smlua_audio_utils_replace_sequence(0x3D, 0x24, 75, "3D_Seq_custom")
smlua_audio_utils_replace_sequence(0x3E, 0x11, 75, "3E_Seq_custom")
smlua_audio_utils_replace_sequence(0x3F, 0x1A, 75, "3F_Seq_custom")
smlua_audio_utils_replace_sequence(0x40, 0x1E, 75, "40_Seq_custom")
smlua_audio_utils_replace_sequence(0x41, 0x1C, 75, "41_Seq_custom")
smlua_audio_utils_replace_sequence(0x44, 0x0C, 75, "44_Seq_custom")
smlua_audio_utils_replace_sequence(0x45, 0x13, 75, "45_Seq_custom")
smlua_audio_utils_replace_sequence(0x4A, 0x13, 75, "4A_Seq_custom")
smlua_audio_utils_replace_sequence(0x4B, 0x0E, 75, "4B_Seq_custom")
smlua_audio_utils_replace_sequence(0x4C, 0x15, 75, "4C_Seq_custom")
smlua_audio_utils_replace_sequence(0x4D, 0x25, 75, "4D_Seq_custom")
smlua_audio_utils_replace_sequence(0x4E, 0x0E, 75, "4E_Seq_custom")
smlua_audio_utils_replace_sequence(0x50, 0x0C, 75, "50_Seq_custom")
smlua_audio_utils_replace_sequence(0x51, 0x25, 75, "51_Seq_custom")
smlua_audio_utils_replace_sequence(0x52, 0x25, 65, "52_Seq_custom")


-- Star Positions
vec3f_set(gLevelValues.starPositions.KoopaBobStarPos, 3030, 4500, -4600)
vec3f_set(gLevelValues.starPositions.KoopaThiStarPos, 7100, -1300, -6000)
vec3f_set(gLevelValues.starPositions.KingBobombStarPos, 8256.0, 7504.0, -12072.0)
vec3f_set(gLevelValues.starPositions.KingWhompStarPos, 5880.0, 1333.0, -6896.0)
vec3f_set(gLevelValues.starPositions.EyerockStarPos, 1465.0, 595.0, -6676.0)
vec3f_set(gLevelValues.starPositions.BigBullyStarPos, -6934.0, 805.0, -1260.0)
vec3f_set(gLevelValues.starPositions.ChillBullyStarPos, -610.0, 5539.0, 166.0)
vec3f_set(gLevelValues.starPositions.BigPiranhasStarPos, 0.0, 0.0, 0.0)
vec3f_set(gLevelValues.starPositions.TuxieMotherStarPos, 3176.0, 2945.0, -8506.0)
vec3f_set(gLevelValues.starPositions.WigglerStarPos, 10400.0, 1548.0, -460.0)
vec3f_set(gLevelValues.starPositions.PssSlideStarPos, -6358.0, -4300.0, 4700.0)
vec3f_set(gLevelValues.starPositions.RacingPenguinStarPos, -7339.0, -5700.0, -6774.0)
vec3f_set(gLevelValues.starPositions.TreasureChestStarPos, -1800.0, -2500.0, -1700.0)
vec3f_set(gLevelValues.starPositions.GhostHuntBooStarPos, -21196.0, 6322.0, -12547.0)
vec3f_set(gLevelValues.starPositions.KleptoStarPos, 1795.0, 451.0, -10902.0)
vec3f_set(gLevelValues.starPositions.MerryGoRoundStarPos, -22394.0, 8418.0, -16318.0)
vec3f_set(gLevelValues.starPositions.MrIStarPos, -11882.0, 785.0, -4157.0)
vec3f_set(gLevelValues.starPositions.BalconyBooStarPos, 9330.0, 5973.0, -11664.0)
vec3f_set(gLevelValues.starPositions.BigBullyTrioStarPos, -6934.0, 805.0, -1260.0)

hook_event(HOOK_USE_ACT_SELECT, function () return false end)



