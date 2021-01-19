
inSafeZone = false
safeZone = nil

safeZones = {
	-- {x, y, z, arie}
	["showroom"] = {-43.726108551026,-1101.1746826172,35.20348739624, 40},
	["spawn"] = {-536.8734741211,-219.0591430664,37.64977645874, 50},
	["spital"] = {-474.73635864258,-327.21185302734,34.370166778564, 40},
	["spawn2"] = {-746.40222167968,-2284.4399414062,13.0600233078, 60},
	["politie"] = {439.99670410156,-982.80767822266,30.689601898194, 44},
	["VIP"] = {-2262.5891113282,335.64697265625,174.60206604004,60},
	["swat"] = {-1102.8555908204,-262.93338012696,37.739303588868, 35},
	--["drugs"] = {-77.744812011719,6224.2241210938,31.090030670166,50},
	["SPITAL"] = {344.14971923828,-584.93725585938,28.791460037232,60},
	["tractari"] = {-466.04959106446,-800.80249023438,30.542766571044, 30},
	["skinshop1"] = {72.2545394897461,-1399.10229492188,29.3761386871338,15},
	["skinshop2"] ={449.81854248047,-993.30865478516,30.689584732056,15},
	["skinshop3"] ={-703.77685546875,-152.258544921875,37.4151458740234,15},
	["skinshop4"] ={-167.863754272461,-298.969482421875,39.7332878112793,15},
	["skinshop5"] ={428.694885253906,-800.1064453125,29.4911422729492,15},
	["skinshop6"] ={-829.413269042969,-1073.71032714844,11.3281078338623,15},
	["skinshop7"] ={-1193.42956542969,-772.262329101563,17.3244285583496,15},
	["skinshop8"] ={-1447.7978515625,-242.461242675781,49.8207931518555,15},
	["skinshop9"] ={282.3452758789,-281.8674621582,53.942691802978,15},
	["skinshop10"] ={11.6323690414429,6514.224609375,31.8778476715088,15},
	["skinshop11"] ={1696.29187011719,4829.3125,42.0631141662598,15},
	["skinshop12"] ={138.05464172364,-739.94018554688,258.15176391602,15},--SRI
	["skinshop13"] ={123.64656829834,-219.440338134766,54.5578384399414,15},
	["skinshop14"] ={618.093444824219,2759.62939453125,42.0881042480469,15},
	["skinshop15"] ={1190.55017089844,2713.44189453125,38.2226257324219,15},
	["skinshop16"] ={-3172.49682617188,1048.13330078125,20.8632030487061,15},
	["skinshop17"] ={152.37425231934,-1001.380493164,-98.999992370606,15},--Spawn
	["skinshop18"] ={-1108.44177246094,2708.92358398438,19.1078643798828,15},
	["skinshop19"] ={-1063.3767089844,-236.71369934082,44.021137237549,15} -- Pentru baza SWA
}

function pvp_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline, center)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(center)
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
     DrawText(0.220, 0.800)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z
		
		for i, v in pairs(safeZones)do
			x, y, z = v[1], v[2], v[3]
			radius = v[4]
			if(GetDistanceBetweenCoords(x, y, z,px,py,pz) < radius)then
				inSafeZone = true
				safeZone = i
			end
		end
		if(safeZone ~= nil)then
			x2, y2, z2 = safeZones[safeZone][1], safeZones[safeZone][2], safeZones[safeZone][3]
			radius2 = safeZones[safeZone][4]
			if(GetDistanceBetweenCoords(x2, y2, z2,px,py,pz) > radius2)then
				inSafeZone = false
				safeZone = nil
			end
		end
	end
end)

safeZoneColor = 0
safeZoneText = ""
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if (inSafeZone)then
			if(safeZoneColor == 0)then
				safeZoneText = "~w~SAFE ZONE"
				safeZoneColor = 1
			else
				safeZoneText = "~p~SAFE ZONE"
				safeZoneColor = 0
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		ped = GetPlayerPed(-1)
		if (inSafeZone)then
			DisableControlAction(0,24,true)
		--	DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			--DisableControlAction(0,37,true)--TAB
			--DisableControlAction(0,22,true) -- SpaceBar
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			pvp_drawTxt(0.5, 0.06, 0.0, 0.0, 0.5, safeZoneText, 255, 255, 255, 170, 1, 1)
			SetEntityInvincible(ped, true)
			SetPlayerInvincible(PlayerId(), true)
			ClearPedBloodDamage(ped)
			ResetPedVisibleDamage(ped)
			ClearPedLastWeaponDamage(ped)
			SetEntityProofs(ped, true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(ped, false)
			NetworkSetFriendlyFireOption(false)
		else
			SetEntityInvincible(ped, false)
			SetPlayerInvincible(PlayerId(), false)
			ClearPedLastWeaponDamage(ped)
			SetEntityProofs(ped, false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(ped, true)
			NetworkSetFriendlyFireOption(true)
		end
	end
end)