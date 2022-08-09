local QBCore = exports['qb-core']:GetCoreObject()

local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		TriggerServerEvent('qb-driveschool:server:AddLicense', 'thdriver')
		QBCore.Functions.Notify(Lang:t("passed_test"), "success")
	else
		QBCore.Functions.Notify(Lang:t("failed_test"), "error")
	end
end

function StartDriveTest(type)
    QBCore.Functions.SpawnVehicle(Config.VehicleModels[type], function(vehicle)
        SetVehicleNumberPlateText(vehicle, "TESTDRIVE" .. tostring(math.random(1000, 9999)))
        SetEntityHeading(vehicle, Config.Zones.VehicleSpawnPoint.Pos.h)
        exports['LegacyFuel']:SetFuel(vehicle, 100.0)
        --Menu.hidden = true
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle)
        SetVehicleUndriveable(vehicle, false)
        WashDecalsFromVehicle(vehicle, 1.0)
		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)
    end, Config.Zones.VehicleSpawnPoint.Pos, true)
end

function StopDriveTest(success)
	if success then
		QBCore.Functions.Notify(Lang:t("passed_test"), "success")
		TriggerServerEvent('qb-driveschool:server:AddLicense', CurrentTestType)
	else
		QBCore.Functions.Notify(Lang:t("failed_test"), "error")
	end
	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenDMVSchoolMenu()
	local MenuSchoolOptions = {
		{
			header = Lang:t("driving_school"),
			isMenuHeader = true
		},
	}

	for k, v in pairs(Config.Licenses) do
		MenuSchoolOptions[#MenuSchoolOptions+1] = {
			header = v.name,
			txt = Lang:t('school_item', {value = v.price}),
			params = {
				isServer = true,
				event = "qb-driveschool:server:StartTest",
				args = {
					type = k,
				}
			}
		}
	end
	exports['qb-menu']:openMenu(MenuSchoolOptions)

end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})
	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

RegisterNetEvent('qb-driveschool:client:StartTest', function(type)
	if type == "thdriver" then
		StartTheoryTest()
	else
		StartDriveTest(type)
	end
end)

--Creation Markers
local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--Create markers for drive school
CreateThread(function()
    while true do
        Wait(5)
        local inRange = false
        local pos = GetEntityCoords(PlayerPedId())
		local SchoolDistance = #(pos - Config.Zones.DMVSchool.Pos)
		if SchoolDistance < 20 then
			inRange = true
			DrawMarker(2, Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
			if SchoolDistance < 1 then
				DrawText3Ds(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z, Lang:t('drive_school_e'))
				if IsControlJustReleased(0, 38) then
					OpenDMVSchoolMenu()
				end
			end
		end                
        if not inRange then
            Wait(1000)
        end
    end
end)

--Create Blip for School
CreateThread(function()
	local SchoolBlip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)
	SetBlipSprite(SchoolBlip, 545)
	SetBlipColour(SchoolBlip, 4)
	SetBlipScale(SchoolBlip, 0.6)
	SetBlipDisplay(SchoolBlip, 4)
	SetBlipAsShortRange(SchoolBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(Lang:t('driving_school_blip'))
	EndTextCommandSetBlipName(SchoolBlip)
end)



-- Block UI
CreateThread(function()
	while true do
		Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Wait(500)
		end
	end
end)

-- Drive test
CreateThread(function()
	while true do

		Wait(0)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				QBCore.Functions.Notify(Lang:t("driving_test_complete"), "primary")

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Wait(500)
		end
	end
end)

-- Speed / Damage control
CreateThread(function()
	while true do
		Wait(10)

		if CurrentTest == 'drive' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							QBCore.Functions.Notify(Lang:t("driving_too_fast", {value = Config.SpeedLimits[CurrentZoneType]}), "error")
							QBCore.Functions.Notify(Lang:t("errors", {value = DriveErrors, value2 = Config.MaxErrors}), "error")

						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					QBCore.Functions.Notify(Lang:t("you_damaged_veh"), "error")
					QBCore.Functions.Notify(Lang:t("errors", {value = DriveErrors, value2 = Config.MaxErrors}), "error")

					-- avoid stacking faults
					LastVehicleHealth = health
					Wait(1500)
				end
			end
		else
			-- not currently taking driver test
			Wait(500)
		end
	end
end)
