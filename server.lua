--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		-- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Deposit Money', 'Invalid amount', 'CHAR_BANK_MAZE', 9)
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
                -- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Deposit Money', '存入 ~g~$' .. amount .. '~s~', 'CHAR_BANK_MAZE', 9)
		TriggerEvent("esx:bankdeposit", xPlayer.name, amount)
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
                 -- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Withdraw Money', 'Invalid amount', 'CHAR_BANK_MAZE', 9)
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
                 -- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Withdraw Money', '取出 ~r~$' .. amount .. '~s~', 'CHAR_BANK_MAZE', 9)
		TriggerEvent("esx:bankwithdraw", xPlayer.name, amount)
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(tarage, amount)
	local _source = source
	local sourcexPlayer = ESX.GetPlayerFromId(_source)
	local taragexPlayer = ESX.GetPlayerFromId(tarage)
	local balance = sourcexPlayer.getAccount('bank').money
	
	if _source == tarage then
                -- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', '你無法匯款給你自己!', 'CHAR_BANK_MAZE', 9)
	else
		if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
                        -- advanced notification with bank icon
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', '沒有足夠的錢匯款!', 'CHAR_BANK_MAZE', 9)
		else
			sourcexPlayer.removeAccountMoney('bank', tonumber(amount))
			taragexPlayer.addAccountMoney('bank', tonumber(amount))
                        -- advanced notification with bank icon
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer Money', '你匯款 ~r~$' .. amount .. '~s~ 給 ~r~' .. tarage .. ' .', 'CHAR_BANK_MAZE', 9)
			TriggerClientEvent('esx:showAdvancedNotification', tarage, 'Bank', 'Transfer Money', '你收到 ~r~$' .. amount .. '~s~ 來自 ~r~' .. _source .. ' 的匯款.', 'CHAR_BANK_MAZE', 9)
		end
		
	end
end)



