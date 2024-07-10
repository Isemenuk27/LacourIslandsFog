do
	local mealEnts = ents.FindByName("meal")

	if math.random(0, 100) <= 20 then	
		for i,v in ipairs(mealEnts) do
			v:Fire("Enable")
		end
	else
		for i,v in ipairs(mealEnts) do
			v:Fire("Kill")
		end
	end
end

do
	local randomlightevent = ents.FindByName("randevent_lights") randomlightevent = randomlightevent[1]

	if IsValid( randomlightevent ) then
		for i = 1, 4 do
			if math.random(0, 100) <= 25 then
				randomlightevent:Fire( tostring("FireUser".. i) )
			end
		end
	end
end

do
	local function rollPosters( eEnt1, eEnt2, nChance )
		if ( math.random(0, 100) <= nChance ) then
			SafeRemoveEntity( eEnt1 )
			if ( IsValid( eEnt2 ) ) then
				eEnt2:Fire( "Enable" )
			end
		else
			SafeRemoveEntity( eEnt2 )
			if ( IsValid( eEnt1 ) ) then
				eEnt1:Fire( "Enable" )
			end
		end
	end

	rollPosters( ents.FindByName("kino_date_normal")[2], ents.FindByName("kino_date_kek")[1], 10 )
	rollPosters( ents.FindByName("kino_redalium")[1], ents.FindByName("kino_greenalium")[1], 50 )
	rollPosters( ents.FindByName("kino_poster_chtc")[1], ents.FindByName("kino_poster_bfoot")[1], 50 )
	rollPosters( ents.FindByName("kino_leetworld")[1], ents.FindByName("kino_breakingbad")[1], 50 )
end

function LA_PlayAirAlert()
	local birdEnts = ents.FindByClass("npc_seagull")
	table.Add(birdEnts, ents.FindByClass("npc_pigeon"))
	table.Add(birdEnts, ents.FindByClass("npc_crow"))
	for i,v in ipairs(birdEnts) do
		v:Fire("FlyAway")
	end

	if math.random(0, 100) <= 5 then
		for i,v in ipairs( ents.FindByName("airalarm_rand") ) do
			sound.Play( "la.AirAlert", v:GetPos() )
		end
	end
end