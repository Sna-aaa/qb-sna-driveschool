local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('qb-driveschool:server:AddLicense', function(license)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local licenses = Player.PlayerData.metadata["licences"]

	if license == 'driver' or license == 'bike' or license == 'truck' or license == 'thdriver' then
		licenses[license] = true
	end
	if license == "thdriver" then
		Player.Functions.AddItem('driving_test_permit', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, 'driving_test_permit', "add")
	else
		local permit = Player.Functions.GetItemByName("driving_test_permit")
		if permit then
			Player.Functions.RemoveItem('driving_test_permit', 1)
			TriggerClientEvent("inventory:client:ItemBox", src, 'driving_test_permit', "remove")
		end
	end
	Player.Functions.SetMetaData("licences", licenses)
	if license ~= "thdriver" then
		local permit = Player.Functions.GetItemByName("driver_license")
		if permit then
			TriggerClientEvent('QBCore:Notify', src, Lang:t("license_updated"), 'success')
		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t("goto_cityhall"), 'success')
		end
	end
end)


RegisterServerEvent('qb-driveschool:server:StartTest', function(data)
	local type = data.type
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local licenses = Player.PlayerData.metadata["licences"]
	local launch = false

	if type == "thdriver" then
		launch = true
	else
		if licenses['thdriver'] then
			launch = true
		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t("no_code"), 'error')
		end
	end
	if launch then
		if Player.PlayerData.money["cash"] >= Config.Licenses[type].price then
			if Config.Licenses[type].price > 0 then
				Player.Functions.RemoveMoney("cash", Config.Licenses[type].price, "Drive Test")
				TriggerClientEvent('QBCore:Notify', src, Lang:t('you_paid', {value = Config.Licenses[type].price}), 'success')
			end
			TriggerClientEvent("qb-driveschool:client:StartTest", src, type)
		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t("not_enough_money"), 'error')
		end
	end
end)
