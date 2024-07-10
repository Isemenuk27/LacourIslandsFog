if ( game.GetMap() != "gm_lacour_islands_fog" ) then return end

if ( SERVER ) then
	local cWaterDamageCvar = CreateConVar("la_waterdamage", "1", FCVAR_ARCHIVE, "")


	local function LA_CheckDamage( bEnable )
		if ( not bEnable ) then
			bEnable = cWaterDamageCvar:GetBool()
		end

		local sFire = bEnable and "Enable" or "Disable"

		for _, eEnt in ipairs( ents.FindByName( "water_damage_trigger" ) ) do
			if ( IsValid( eEnt ) ) then
				eEnt:Fire( sFire )
			end
		end
	end

	cvars.AddChangeCallback("la_waterdamage", function( sCvarName, _, sNew )
		LA_CheckDamage( ( tonumber( sNew ) or 0 ) > 0 )
	end)

	local function LA_DisableCubemaps( ePly )
		if ( not IsConCommandBlocked( "mat_fastspecular" ) ) then
			ePly:ConCommand( "mat_fastspecular 0" )
		end

		ePly:ChatPrint( "If you have performance issues, try entering these commands:" )
		ePly:ChatPrint( "r_waterforcereflectentities 0 (Turns off reflection of props in water)" )
		ePly:ChatPrint( "cl_detaildist 0 (Turn off details on displacement)" )
	end

	hook.Add( "PlayerInitialSpawn", "CubemapDisabler", LA_DisableCubemaps )
	hook.Add( "PostCleanupMap", "LA.WaterDamage", LA_CheckDamage )
	hook.Add( "InitPostEntity", "LA.WaterDamage2", LA_CheckDamage )
else
	local cMat = Material( "models/isemenuk/skydome_gradient" )
	util.PrecacheModel( "models/isemenuk/skydome_fog.mdl" )

	eSkyDomeLacours = eSkyDomeLacours or NULL
	SafeRemoveEntity( eSkyDomeLacours )

	local function spawnDome()
		eSkyDomeLacours = ClientsideModel( "models/isemenuk/skydome_fog.mdl" )
		eSkyDomeLacours:SetNoDraw( true )
		print( "Spawned dome ")
	end

	hook.Add( "InitPostEntity", "LacourFog", spawnDome )

	hook.Add("PostDraw2DSkyBox", "LacourFog", function()
		if ( not IsValid( eSkyDomeLacours ) ) then
			timer.Simple( 0, spawnDome )
			return
		end

		render.OverrideDepthEnable( true, false )

		cam.Start3D( vector_origin, EyeAngles() )
			render.SetMaterial( cMat )
			local nFogR, nFogG, nFogB = render.GetFogColor()
			render.SetColorModulation( nFogR / 255, nFogG / 255, nFogB / 255 )
	        eSkyDomeLacours:DrawModel()
	    cam.End3D()

	    render.OverrideDepthEnable( false, false )
	end)
end