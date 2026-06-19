function Elements:Section(title)
	title = title or "Section"

	local SectionFrame = Instance.new("Frame")
	SectionFrame.Name = "Section"
	SectionFrame.Parent = NewTab
	SectionFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	SectionFrame.Size = UDim2.new(1, 0, 0, 30)

	local SectionCorner = Instance.new("UICorner")
	SectionCorner.CornerRadius = UDim.new(0, 4)
	SectionCorner.Parent = SectionFrame

	local SectionStroke = Instance.new("UIStroke")
	SectionStroke.Name = "UIStroke"
	SectionStroke.Parent = SectionFrame
	SectionStroke.ApplyStrokeMode = "Border"
	SectionStroke.Thickness = 1
	SectionStroke.LineJoinMode = "Round"

	local SectionTitle = Instance.new("TextLabel")
	SectionTitle.Name = "Title"
	SectionTitle.Parent = SectionFrame
	SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SectionTitle.BackgroundTransparency = 1.000
	SectionTitle.Size = UDim2.new(1, -12, 1, 0)
	SectionTitle.Position = UDim2.new(0, 6, 0, 0)
	SectionTitle.Font = Enum.Font.Ubuntu
	SectionTitle.Text = title
	SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	SectionTitle.TextSize = 14.000
	SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

	-- Viền RGB chuyển màu cho Section
	local rgbT = 0
	RunService.RenderStepped:Connect(function(dt)
		rgbT = rgbT + dt * 1.5
		SectionStroke.Color = Color3.fromHSV(rgbT % 1, 1, 1)
	end)

	local SectionContainer = Instance.new("Frame")
	SectionContainer.Name = "SectionContainer"
	SectionContainer.Parent = SectionFrame
	SectionContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SectionContainer.BackgroundTransparency = 1.000
	SectionContainer.Size = UDim2.new(1, 0, 1, -30)
	SectionContainer.Position = UDim2.new(0, 0, 0, 30)

	local SectionUIListLayout = Instance.new("UIListLayout")
	SectionUIListLayout.Parent = SectionContainer
	SectionUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SectionUIListLayout.Padding = UDim.new(0, 4)

	local SectionPadding = Instance.new("UIPadding")
	SectionPadding.Parent = SectionContainer
	SectionPadding.PaddingLeft = UDim.new(0, 4)
	SectionPadding.PaddingRight = UDim.new(0, 4)
	SectionPadding.PaddingTop = UDim.new(0, 4)
	SectionPadding.PaddingBottom = UDim.new(0, 4)

	local SectionElements = {}
	-- ... các element khác ở đây ...
	return SectionElements
end
-- ============ TOGGLE ============ --
function SectionElements:Toggle(ToggleText, callback)
	ToggleText = ToggleText or "Toggle"
	callback = callback or function() end

	local toggled = false

	local btn = Instance.new("Frame")
	btn.Name = "Toggle"
	btn.Parent = SectionContainer
	btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	btn.Size = UDim2.new(1, 0, 0, 30)

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn

	local btnStroke = Instance.new("UIStroke")
	btnStroke.Name = "UIStroke"
	btnStroke.Parent = btn
	btnStroke.ApplyStrokeMode = "Border"
	btnStroke.Thickness = 1
	btnStroke.LineJoinMode = "Round"
	btnStroke.Color = Color3.fromRGB(81, 81, 81)

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = btn
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Size = UDim2.new(1, -40, 1, 0)
	Title.Position = UDim2.new(0, 8, 0, 0)
	Title.Font = Enum.Font.Ubuntu
	Title.Text = ToggleText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local CheckmarkHolder = Instance.new("Frame")
	CheckmarkHolder.Name = "CheckmarkHolder"
	CheckmarkHolder.Parent = btn
	CheckmarkHolder.AnchorPoint = Vector2.new(1, 0.5)
	CheckmarkHolder.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
	CheckmarkHolder.Position = UDim2.new(1, -8, 0.5, 0)
	CheckmarkHolder.Size = UDim2.new(0, 20, 0, 20)

	local CheckmarkCorner = Instance.new("UICorner")
	CheckmarkCorner.CornerRadius = UDim.new(0, 4)
	CheckmarkCorner.Parent = CheckmarkHolder

	local CheckmarkStroke = Instance.new("UIStroke")
	CheckmarkStroke.Name = "UIStroke"
	CheckmarkStroke.Parent = CheckmarkHolder
	CheckmarkStroke.ApplyStrokeMode = "Border"
	CheckmarkStroke.Thickness = 1
	CheckmarkStroke.LineJoinMode = "Round"
	CheckmarkStroke.Color = Color3.fromRGB(81, 81, 81)

	local Sample = Instance.new("ImageLabel")
	Sample.Name = "Sample"
	Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sample.BackgroundTransparency = 1.000
	Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
	Sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Sample.ImageTransparency = 0.600
	Sample.Visible = false
	Sample.Parent = btn

	local focusing = false
	local hovering = false

	btn.MouseButton1Click:Connect(function()
		if not focusing then
			local ms = game.Players.LocalPlayer:GetMouse()
			if toggled == false then
				game.TweenService:Create(CheckmarkHolder, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					BackgroundColor3 = Color3.fromRGB(115, 191, 92)
				}):Play()
				game.TweenService:Create(CheckmarkStroke, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					Color = Color3.fromRGB(0, 255, 59) 
				}):Play()
				local c = Sample:Clone()
				c.Visible = true
				c.Parent = btn
				local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
				c.Position = UDim2.new(0, x, 0, y)
				local len, size = 0.35, nil
				if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
					size = (btn.AbsoluteSize.X * 1.5)
				else
					size = (btn.AbsoluteSize.Y * 1.5)
				end
				c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
				for i = 1, 10 do
					c.ImageTransparency = c.ImageTransparency + 0.05
					task.wait(len / 12)
				end
				c:Destroy()
			else
				game.TweenService:Create(CheckmarkHolder, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					BackgroundColor3 = Color3.fromRGB(63, 63, 63) 
				}):Play()
				game.TweenService:Create(CheckmarkStroke, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					Color = Color3.fromRGB(81, 81, 81) 
				}):Play()
				local c = Sample:Clone()
				c.Visible = true
				c.Parent = btn
				local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
				c.Position = UDim2.new(0, x, 0, y)
				local len, size = 0.35, nil
				if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
					size = (btn.AbsoluteSize.X * 1.5)
				else
					size = (btn.AbsoluteSize.Y * 1.5)
				end
				c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
				for i = 1, 10 do
					c.ImageTransparency = c.ImageTransparency + 0.05
					task.wait(len / 12)
				end
				c:Destroy()
			end
			toggled = not toggled
			pcall(callback, toggled)
		end
	end)

	btn.MouseEnter:Connect(function()
		if not focusing then
			game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				BackgroundColor3 = Color3.fromRGB(54, 54, 54)
			}):Play()
			game.TweenService:Create(btnStroke, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Color = Color3.fromRGB(162, 162, 162)
			}):Play()
			hovering = true
		end 
	end)

	btn.MouseLeave:Connect(function()
		if not focusing then
			game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			}):Play()
			game.TweenService:Create(btnStroke, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Color = Color3.fromRGB(81, 81, 81)
			}):Play()
			hovering = false
		end
	end)

	return {}
end

-- ============ BUTTON ============ --
function SectionElements:Button(ButtonText, callback)
	ButtonText = ButtonText or "Button"
	callback = callback or function() end

	local btn = Instance.new("TextButton")
	btn.Name = "Button"
	btn.Parent = SectionContainer
	btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Font = Enum.Font.Ubuntu
	btn.Text = ButtonText
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14.000

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn

	local btnStroke = Instance.new("UIStroke")
	btnStroke.Name = "UIStroke"
	btnStroke.Parent = btn
	btnStroke.ApplyStrokeMode = "Border"
	btnStroke.Thickness = 1
	btnStroke.LineJoinMode = "Round"
	btnStroke.Color = Color3.fromRGB(81, 81, 81)

	local Sample = Instance.new("ImageLabel")
	Sample.Name = "Sample"
	Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sample.BackgroundTransparency = 1.000
	Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
	Sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Sample.ImageTransparency = 0.600
	Sample.Visible = false
	Sample.Parent = btn

	local hovering = false

	btn.MouseButton1Click:Connect(function()
		local ms = game.Players.LocalPlayer:GetMouse()
		local c = Sample:Clone()
		c.Visible = true
		c.Parent = btn
		local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
		c.Position = UDim2.new(0, x, 0, y)
		local len, size = 0.35, nil
		if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
			size = (btn.AbsoluteSize.X * 1.5)
		else
			size = (btn.AbsoluteSize.Y * 1.5)
		end
		c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
		for i = 1, 10 do
			c.ImageTransparency = c.ImageTransparency + 0.05
			task.wait(len / 12)
		end
		c:Destroy()
		pcall(callback)
	end)

	btn.MouseEnter:Connect(function()
		game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			BackgroundColor3 = Color3.fromRGB(54, 54, 54)
		}):Play()
		game.TweenService:Create(btnStroke, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			Color = Color3.fromRGB(162, 162, 162)
		}):Play()
		hovering = true
	end)

	btn.MouseLeave:Connect(function()
		game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			BackgroundColor3 = Color3.fromRGB(26, 26, 26)
		}):Play()
		game.TweenService:Create(btnStroke, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			Color = Color3.fromRGB(81, 81, 81)
		}):Play()
		hovering = false
	end)

	return {}
end

-- ============ KEYBIND ============ --
function SectionElements:Keybind(KeybindTitle, oldKey, callback)
	KeybindTitle = KeybindTitle or "Keybind"
	oldKey = oldKey or "None"
	callback = callback or function() end

	local Keybind = Instance.new("Frame")
	Keybind.Name = "Keybind"
	Keybind.Parent = SectionContainer
	Keybind.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Keybind.Size = UDim2.new(1, 0, 0, 30)

	local UICorner_36 = Instance.new("UICorner")
	UICorner_36.CornerRadius = UDim.new(0, 4)
	UICorner_36.Parent = Keybind

	local UIStroke_Idk791 = Instance.new("UIStroke")
	UIStroke_Idk791.Name = "UIStroke"
	UIStroke_Idk791.Parent = Keybind
	UIStroke_Idk791.ApplyStrokeMode = "Border"
	UIStroke_Idk791.Color = Color3.fromRGB(81, 81, 81)
	UIStroke_Idk791.LineJoinMode = "Round"
	UIStroke_Idk791.Thickness = 1
	UIStroke_Idk791.Transparency = 0

	local Title_14 = Instance.new("TextLabel")
	Title_14.Name = "Title"
	Title_14.Parent = Keybind
	Title_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_14.BackgroundTransparency = 1.000
	Title_14.Size = UDim2.new(1, -20, 1, 0)
	Title_14.Font = Enum.Font.Ubuntu
	Title_14.Text = KeybindTitle
	Title_14.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_14.TextSize = 14.000
	Title_14.TextXAlignment = Enum.TextXAlignment.Left

	local UIPadding_24 = Instance.new("UIPadding")
	UIPadding_24.Parent = Keybind
	UIPadding_24.PaddingBottom = UDim.new(0, 6)
	UIPadding_24.PaddingLeft = UDim.new(0, 6)
	UIPadding_24.PaddingRight = UDim.new(0, 6)
	UIPadding_24.PaddingTop = UDim.new(0, 6)

	local Sample = Instance.new("ImageLabel")
	Sample.Name = "Sample"
	Sample.Parent = Keybind
	Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sample.BackgroundTransparency = 1.000
	Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
	Sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Sample.ImageTransparency = 0.600

	local Box = Instance.new("Frame")
	Box.Name = "Box"
	Box.Parent = Keybind
	Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Box.BackgroundTransparency = 0.900
	Box.BorderColor3 = Color3.fromRGB(53, 53, 53)
	Box.Position = UDim2.new(0.897233188, 0, 0, 0)
	Box.Size = UDim2.new(0, 22, 0, 20)

	local UICorner_37 = Instance.new("UICorner")
	UICorner_37.CornerRadius = UDim.new(0, 4)
	UICorner_37.Parent = Box

	local UIStroke_qqqaa = Instance.new("UIStroke")
	UIStroke_qqqaa.Name = "UIStroke"
	UIStroke_qqqaa.Parent = Box
	UIStroke_qqqaa.ApplyStrokeMode = "Border"
	UIStroke_qqqaa.Color = Color3.fromRGB(81, 81, 81)
	UIStroke_qqqaa.LineJoinMode = "Round"
	UIStroke_qqqaa.Thickness = 1
	UIStroke_qqqaa.Transparency = 0

	local KeybindC = Instance.new("TextButton")
	KeybindC.Name = "KeybindC"
	KeybindC.Parent = Keybind
	KeybindC.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KeybindC.BackgroundTransparency = 1.000
	KeybindC.Position = UDim2.new(0.897233188, 0, 0, 0)
	KeybindC.Size = UDim2.new(0, 26, 0, 20)
	KeybindC.Font = Enum.Font.SourceSans
	KeybindC.Text = oldKey
	KeybindC.TextColor3 = Color3.fromRGB(255, 255, 255)
	KeybindC.TextSize = 14.000

	local UIPadding_25 = Instance.new("UIPadding")
	UIPadding_25.Parent = KeybindC
	UIPadding_25.PaddingRight = UDim.new(0, 4)

	local focusing = false
	local hovering = false

	KeybindC.MouseButton1Click:Connect(function()
		focusing = true
		KeybindC.Text = "..."
		local inputBegan
		inputBegan = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local key = input.KeyCode
				KeybindC.Text = key.Name
				callback(key)
			elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
				KeybindC.Text = input.UserInputType.Name
				callback(input.UserInputType)
			end
			focusing = false
			inputBegan:Disconnect()
		end)
	end)

	Keybind.MouseEnter:Connect(function()
		if not focusing then
			game.TweenService:Create(Keybind, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				BackgroundColor3 = Color3.fromRGB(54, 54, 54)
			}):Play()
			game.TweenService:Create(UIStroke_Idk791, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Color = Color3.fromRGB(162, 162, 162)
			}):Play()
			hovering = true
		end 
	end)

	Keybind.MouseLeave:Connect(function()
		if not focusing then
			game.TweenService:Create(Keybind, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			}):Play()
			game.TweenService:Create(UIStroke_Idk791, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Color = Color3.fromRGB(81, 81, 81)
			}):Play()
			hovering = false
		end
	end)

	return {}
end
-- ============ LABEL ============ --
function Elements:Label(LabelText)
	LabelText = LabelText or "This is a label"

	local Labell = {}

	local Label = Instance.new("Frame")
	local UIPadding_11 = Instance.new("UIPadding")
	local Title_5 = Instance.new("TextLabel")
	local Icon_6 = Instance.new("ImageLabel")
	local UIPadding_12 = Instance.new("UIPadding")
	local UICorner_7 = Instance.new("UICorner")
	local UIStroke_8 = Instance.new("UIStroke")

	Label.Name = "Label"
	Label.Parent = NewTab
	Label.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Label.Size = UDim2.new(1, 0, 0, 26)

	UIPadding_11.Parent = Label
	UIPadding_11.PaddingBottom = UDim.new(0, 6)
	UIPadding_11.PaddingLeft = UDim.new(0, 6)
	UIPadding_11.PaddingRight = UDim.new(0, 6)
	UIPadding_11.PaddingTop = UDim.new(0, 6)

	Title_5.Name = "Title"
	Title_5.Parent = Label
	Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_5.BackgroundTransparency = 1.000
	Title_5.Size = UDim2.new(1, 0, 1, 0)
	Title_5.Font = Enum.Font.Ubuntu
	Title_5.Text = LabelText
	Title_5.TextWrapped = true
	Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_5.TextSize = 14.000
	Title_5.TextXAlignment = Enum.TextXAlignment.Left
	Title_5.TextYAlignment = Enum.TextYAlignment.Top

	Icon_6.Name = "Icon"
	Icon_6.Parent = Title_5
	Icon_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_6.BackgroundTransparency = 1.000
	Icon_6.Position = UDim2.new(0, -20, 0, 0)
	Icon_6.Size = UDim2.new(0, 14, 0, 14)
	Icon_6.Image = "rbxassetid://10889394367"
	Icon_6.ImageColor3 = Color3.fromRGB(127, 127, 127)

	UIPadding_12.Parent = Title_5
	UIPadding_12.PaddingLeft = UDim.new(0, 20)

	UICorner_7.CornerRadius = UDim.new(0, 4)
	UICorner_7.Parent = Label

	UIStroke_8.Name = "UIStroke"
	UIStroke_8.Parent = Label
	UIStroke_8.ApplyStrokeMode = "Border"
	UIStroke_8.Color = Color3.fromRGB(81, 81, 81)
	UIStroke_8.LineJoinMode = "Round"
	UIStroke_8.Thickness = 1
	UIStroke_8.Transparency = 0

	function Labell:SetText(LabelSetText)
		LabelText = LabelSetText
		Labell:_update()
	end

	function Labell:_update()
		Title_5.Text = LabelText
		Title_5.Size = UDim2.new(Title_5.Size.X.Scale, Title_5.Size.X.Offset, 0, math.huge)
		Title_5.Size = UDim2.new(Title_5.Size.X.Scale, Title_5.Size.X.Offset, 0, Title_5.TextBounds.Y)
		game.TweenService:Create(Label, TweenInfo.new(0.2), {Size = UDim2.new(Label.Size.X.Scale, Label.Size.X.Offset, 0, Title_5.TextBounds.Y + 12)}):Play()
	end

	Labell:_update()
	return Labell
end

-- ============ INFO LABEL ============ --
function Elements:InfoLabel(InfoText)
	InfoText = InfoText or "This is a info"

	local InfoLabell = {}

	local Info = Instance.new("Frame")
	local UIPadding_9 = Instance.new("UIPadding")
	local Title_4 = Instance.new("TextLabel")
	local Icon_5 = Instance.new("ImageLabel")
	local UIPadding_10 = Instance.new("UIPadding")
	local UICorner_6 = Instance.new("UICorner")
	local UIStroke_7 = Instance.new("UIStroke")

	Info.Name = "Info"
	Info.Parent = NewTab
	Info.BackgroundColor3 = Color3.fromRGB(3, 32, 43)
	Info.Size = UDim2.new(1, 0, 0, 26)

	UIPadding_9.Parent = Info
	UIPadding_9.PaddingBottom = UDim.new(0, 6)
	UIPadding_9.PaddingLeft = UDim.new(0, 6)
	UIPadding_9.PaddingRight = UDim.new(0, 6)
	UIPadding_9.PaddingTop = UDim.new(0, 6)

	Title_4.Name = "Title"
	Title_4.Parent = Info
	Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.BackgroundTransparency = 1.000
	Title_4.Size = UDim2.new(1, 0, 1, 0)
	Title_4.Font = Enum.Font.Ubuntu
	Title_4.Text = InfoText
	Title_4.TextWrapped = true
	Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.TextSize = 14.000
	Title_4.TextXAlignment = Enum.TextXAlignment.Left
	Title_4.TextYAlignment = Enum.TextYAlignment.Top

	Icon_5.Name = "Icon"
	Icon_5.Parent = Title_4
	Icon_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_5.BackgroundTransparency = 1.000
	Icon_5.Position = UDim2.new(0, -20, 0, 0)
	Icon_5.Size = UDim2.new(0, 14, 0, 14)
	Icon_5.Image = "rbxassetid://10889391188"
	Icon_5.ImageColor3 = Color3.fromRGB(12, 170, 218)

	UIPadding_10.Parent = Title_4
	UIPadding_10.PaddingLeft = UDim.new(0, 20)

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = Info

	UIStroke_7.Name = "UIStroke"
	UIStroke_7.Parent = Info
	UIStroke_7.ApplyStrokeMode = "Border"
	UIStroke_7.Color = Color3.fromRGB(11, 136, 177)
	UIStroke_7.LineJoinMode = "Round"
	UIStroke_7.Thickness = 1
	UIStroke_7.Transparency = 0

	function InfoLabell:SetText(InfoLabelSetText)
		InfoText = InfoLabelSetText
		InfoLabell:_update()
	end

	function InfoLabell:_update()
		Title_4.Text = InfoText
		Title_4.Size = UDim2.new(Title_4.Size.X.Scale, Title_4.Size.X.Offset, 0, math.huge)
		Title_4.Size = UDim2.new(Title_4.Size.X.Scale, Title_4.Size.X.Offset, 0, Title_4.TextBounds.Y)
		game.TweenService:Create(Info, TweenInfo.new(0.2), {Size = UDim2.new(Info.Size.X.Scale, Info.Size.X.Offset, 0, Title_4.TextBounds.Y + 12)}):Play()
	end

	InfoLabell:_update()
	return InfoLabell
end

-- ============ WARNING LABEL ============ --
function Elements:WarningLabel(WarningText)
	WarningText = WarningText or "This is a warning"

	local WarningLabell = {}

	local Warning = Instance.new("Frame")
	local UIPadding_7 = Instance.new("UIPadding")
	local Title_3 = Instance.new("TextLabel")
	local Icon_4 = Instance.new("ImageLabel")
	local UIPadding_8 = Instance.new("UIPadding")
	local UICorner_5 = Instance.new("UICorner")
	local UIStroke_6 = Instance.new("UIStroke")

	Warning.Name = "Warning"
	Warning.Parent = NewTab
	Warning.BackgroundColor3 = Color3.fromRGB(43, 36, 3)
	Warning.Size = UDim2.new(1, 0, 0, 26)

	UIPadding_7.Parent = Warning
	UIPadding_7.PaddingBottom = UDim.new(0, 6)
	UIPadding_7.PaddingLeft = UDim.new(0, 6)
	UIPadding_7.PaddingRight = UDim.new(0, 6)
	UIPadding_7.PaddingTop = UDim.new(0, 6)

	Title_3.Name = "Title"
	Title_3.Parent = Warning
	Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.BackgroundTransparency = 1.000
	Title_3.Size = UDim2.new(1, 0, 1, 0)
	Title_3.Font = Enum.Font.Ubuntu
	Title_3.Text = WarningText
	Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.TextSize = 14.000
	Title_3.TextWrapped = true
	Title_3.TextXAlignment = Enum.TextXAlignment.Left
	Title_3.TextYAlignment = Enum.TextYAlignment.Top

	Icon_4.Name = "Icon"
	Icon_4.Parent = Title_3
	Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_4.BackgroundTransparency = 1.000
	Icon_4.Position = UDim2.new(0, -20, 0, 0)
	Icon_4.Size = UDim2.new(0, 14, 0, 14)
	Icon_4.Image = "rbxassetid://10889384842"
	Icon_4.ImageColor3 = Color3.fromRGB(214, 178, 14)

	UIPadding_8.Parent = Title_3
	UIPadding_8.PaddingLeft = UDim.new(0, 20)

	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = Warning

	UIStroke_6.Name = "UIStroke"
	UIStroke_6.Parent = Warning
	UIStroke_6.ApplyStrokeMode = "Border"
	UIStroke_6.Color = Color3.fromRGB(165, 137, 11)
	UIStroke_6.LineJoinMode = "Round"
	UIStroke_6.Thickness = 1
	UIStroke_6.Transparency = 0

	function WarningLabell:SetText(WarningLabelSetText)
		WarningText = WarningLabelSetText
		WarningLabell:_update()
	end

	function WarningLabell:_update()
		Title_3.Text = WarningText
		Title_3.Size = UDim2.new(Title_3.Size.X.Scale, Title_3.Size.X.Offset, 0, math.huge)
		Title_3.Size = UDim2.new(Title_3.Size.X.Scale, Title_3.Size.X.Offset, 0, Title_3.TextBounds.Y)
		game.TweenService:Create(Warning, TweenInfo.new(0.2), {Size = UDim2.new(Warning.Size.X.Scale, Warning.Size.X.Offset, 0, Title_3.TextBounds.Y + 12)}):Play()
	end

	WarningLabell:_update()
	return WarningLabell
end
