local tSafezones = {
	{ Vector(-2370.954590, -7620.546875, -367.968750), Vector(-2031.867065, -7315.019043, -200.051880), eDoorEnt = ents.FindByName("house_bunker")[1] }, --Bunker
	{ Vector(-500.388367, 622.416382, -299.467529), Vector(-118.301453, 899.709595, -162.377579), eDoorEnt = ents.FindByName("church_door")[1] }, --Church basemenent
	{ Vector(-5109.528809, -14295.058594, -170.640640), Vector(-4778.313965, -13913.342773, -53.214287) } --Shelter at ocean
}

local trig = ents.FindByName("nuke_trigger")
if IsValid(trig[1]) then
	trig[1]:Remove()
end

function LacIsl_NukeFire()
	local eWorld = game.GetWorld()
	local eAttacker = ents.FindByName("shelter_button")[1]:GetInternalVariable( "m_hActivator" )

	local tFilter = {}

	for _, tData in ipairs( tSafezones ) do
		if ( ( tData.eDoorEnt == nil ) or ( IsValid( tData.eDoorEnt ) and ( tData.eDoorEnt:GetInternalVariable( "m_toggle_state" ) == 1 ) ) ) then
			local tEntities = ents.FindInBox( tData[1], tData[2] )

			for _, eEnt in ipairs( tEntities ) do
				if ( eEnt:IsPlayer() or eEnt:IsNPC() ) then
					tFilter[eEnt] = true
				end
			end
		end
	end

	for _, eEnt in ipairs( ents.GetAll() ) do
		if ( not tFilter[eEnt] and ( eEnt:IsPlayer() or eEnt:IsNPC() ) ) then
			eEnt:TakeDamage( eEnt:Health(), eAttacker, eWorld )
		end
	end
end

