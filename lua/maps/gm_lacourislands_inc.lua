include("clock.lua")
include("random_events.lua")
include("nukescript.lua")

local tSun = ents.FindByClass( "env_sun" )

if ( #tSun > 0 ) then
	 tSun[1]:SetKeyValue( "sun_dir", "0.88 -0.19 0.44" )
	 tSun[1]:SetKeyValue( "suncolor", "255, 255, 255" )
end

local eFog = ents.FindByClass( "env_fog_controller" )[1]

if ( IsValid( eFog ) ) then
	eFog:Fire( "SetFarZ", 3400 )
	eFog:Fire( "SetEndDist", 3333.5 )
	eFog:Fire( "SetStartDist", 120 )
	eFog:Fire( "SetColor", "138 148 160" )
end

local eTonemap = ents.FindByName( "global_tonemap" )[1]

if ( IsValid( eTonemap ) ) then
	eTonemap:Fire( "SetBloomScale", 0.7, .5 )
	eTonemap:Fire( "SetAutoExposureMin", 0.2, .5 )
	eTonemap:Fire( "SetAutoExposureMax", 1.6, .5 )
end

sound.Add( {
	name = "la.AirAlert",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 120,
	pitch = {100, 100},
	sound = {
		")isemenuk/airalert.wav"
	}
} )

sound.Add( {
	name = "la.Domofon",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = {100, 100},
	sound = {
		")isemenuk/domofon.wav"
	}
} )

sound.Add( {
	name = "la.Prostir_sbox",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	sound = {
		")isemenuk/prostir_sbox.mp3"
	}
} )

local tAlwaysNoCollideWithPly = {
	["models/isemenuk/keypad.mdl"] = true,
	["models/dav0r/buttons/switch.mdl"] = true,
	["models/isemenuk/radio_microphone.mdl"] = true,
	["models/props_junk/cardboard_box004a.mdl"] = true,
	["models/props_junk/garbage_newspaper001a.mdl"] = true,
	["models/props_lab/cactus.mdl"] = true,
	["models/isemenuk/book.mdl"] = true,
	["models/isemenuk/newspaper.mdl"] = true,
	["models/isemenuk/photocard.mdl"] = true,
	["models/isemenuk/lightswitch.mdl"] = true,
	["models/isemenuk/clipboard.mdl"] = true,
	["models/isemenuk/key.mdl"] = true,
	["models/props_vents/vent_medium_grill002.mdl"] = true,
	["models/props_vents/vent_medium_grill001.mdl"] = true,
	["models/props_wasteland/light_spotlight02_lamp.mdl"] = true,
	["models/props_junk/shoe001a.mdl"] = true,
	["models/props_lab/huladoll.mdl"] = true,
	["models/props_combine/breenclock.mdl"] = true,
	["models/props_junk/glassbottle01a.mdl"] = true,
	["models/props_c17/utilityconnecter005.mdl"] = true,
	["models/props_citizen_tech/firetrap_buttonpad.mdl"] = true,
	["models/props_trainstation/payphone_reciever001a.mdl"] = true,
}

local function disableCollision( tEnts )
	for _, eEnt in ipairs( tEnts ) do
		if ( tAlwaysNoCollideWithPly[eEnt:GetModel()] ) then
			eEnt:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		end
	end
end

function LA_SetNoCollideWithPly()
	disableCollision( ents.FindByClass( "prop_physics" ) )
	disableCollision( ents.FindByClass( "prop_dynamic" ) )
end

LA_SetNoCollideWithPly()

function LA_DoorLocker(DoorName)
	for i,v in ipairs(ents.FindByName(DoorName)) do
		if v:GetInternalVariable( "m_eDoorState" ) == 0 then
			if v:GetInternalVariable( "m_bLocked" ) then
				v:Fire("Unlock")
			else
				v:Fire("Lock")
			end
		end
	end
end
