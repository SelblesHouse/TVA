local module = {
	Name = "System Message",
	Description = "Send a message as System",
	Location = "Player",
}

module.Execute = function(Client, Type, Attachment)			
	if Type == "command" then
		module.API.sendModalToPlayer(Client, "What's the message?").Event:Connect(function(Input)
			if Input ~= false then
				local Status
				Status, Input = module.API.filterText(Client, Input)
				if Status then
					module.API.doThisToPlayers(Client, Attachment, function(Player)
						module.Remotes.Event:FireClient(Player, "newMessage", "", {From = "System", Content = Input})
					end)
				else
					module.Remotes.Event:FireClient(Client, "newMessage", "", {From = "System", Content = "Your message to \"" .. tostring(Attachment) .. "\" failed to deliver, please retry later."})
				end
			end
		end)
	end
end

return module