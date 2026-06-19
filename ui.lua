--// THƯ VIỆN UI THUẦN TÚY - PHẦN 1: CORE SYSTEMS
local Library = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Hàm xử lý hiệu ứng chuyển động mượt mà
function Library:tween(instance, properties, duration)
	duration = duration or 0.2
	TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), properties):Play()
end

-- Hàm xử lý Kéo Thả (Drag UI) cho cả Máy tính và Điện thoại
local function MakeDraggable(dragFrame, moveFrame)
	local dragging, dragInput, dragStart, startPos
	dragFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = moveFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	dragFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			moveFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
--// THƯ VIỆN UI THUẦN TÚY - PHẦN 2: MAIN FRAME & RGB BORDER
function Library:Create(WindowText)
	WindowText = WindowText or "Hitbox Expander"

	-- Gui Gốc
	local MainGui = Instance.new("ScreenGui")
	MainGui.Name = "PureRGB_UI"
	MainGui.Parent = game.CoreGui
	MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Khung chính (Main Frame) - Bo góc nhẹ chuẩn tỉ lệ
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = MainGui
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.Position = UDim2.new(0.3, 0, 0.25, 0)
	Main.Size = UDim2.new(0, 500, 0, 320)
	Main.ClipsDescendants = false -- Không cắt góc để LED phát sáng toàn diện

	local UICorner_Main = Instance.new("UICorner")
	UICorner_Main.CornerRadius = UDim.new(0, 10) 
	UICorner_Main.Parent = Main

	-- TÍCH HỢP VIỀN LED RGB ĐỔI MÀU LIÊN TỤC
	local MainStroke = Instance.new("UIStroke")
	MainStroke.Name = "MainRGBStroke"
	MainStroke.Parent = Main
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.LineJoinMode = Enum.LineJoinMode.Round
	MainStroke.Thickness = 2.5

	local RGBGradient = Instance.new("UIGradient")
	RGBGradient.Name = "RGBGradient"
	RGBGradient.Parent = MainStroke
	RGBGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
		ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(148, 0, 211))
	}

	-- Vòng lặp Render đổi màu LED tuần hoàn
	local tickCount = 0
	RunService.RenderStepped:Connect(function(dt)
		tickCount = tickCount + dt * 100
		if tickCount >= 360 then tickCount = 0 end
		RGBGradient.Rotation = tickCount
	end)

	-- Thanh tiêu đề (Topbar)
	local Topbar = Instance.new("Frame")
	Topbar.Name = "Topbar"
	Topbar.Parent = Main
	Topbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	Topbar.Size = UDim2.new(1, 0, 0, 35)

	local UICorner_Top = Instance.new("UICorner")
	UICorner_Top.CornerRadius = UDim.new(0, 10)
	UICorner_Top.Parent = Topbar
	MakeDraggable(Topbar, Main)

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Topbar
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 12, 0, 0)
	Title.Size = UDim2.new(1, -50, 1, 0)
	Title.Font = Enum.Font.Ubuntu
	Title.Text = WindowText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- Nút Đóng (Close)
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Name = "CloseBtn"
	CloseBtn.Parent = Topbar
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Position = UDim2.new(1, -30, 0, 0)
	CloseBtn.Size = UDim2.new(0, 30, 1, 0)
	CloseBtn.Font = Enum.Font.Ubuntu
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
	CloseBtn.TextSize = 14
	CloseBtn.MouseButton1Click:Connect(function() MainGui:Destroy() end)

	-- Khu vực thanh điều hướng trái (Navigation)
	local Navigation = Instance.new("Frame")
	Navigation.Name = "Navigation"
	Navigation.Parent = Main
	Navigation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Navigation.Position = UDim2.new(0, 0, 0, 35)
	Navigation.Size = UDim2.new(0, 130, 1, -35)

	local ButtonHolder = Instance.new("Frame")
	ButtonHolder.Name = "ButtonHolder"
	ButtonHolder.Parent = Navigation
	ButtonHolder.BackgroundTransparency = 1
	ButtonHolder.Size = UDim2.new(1, 0, 1, 0)

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = ButtonHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)

	-- Vùng chứa trang nội dung (Content Container)
	local ContentContainer = Instance.new("Frame")
	ContentContainer.Name = "ContentContainer"
	ContentContainer.Parent = Main
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Position = UDim2.new(0, 135, 0, 40)
	ContentContainer.Size = UDim2.new(1, -140, 1, -45)

	local TabsFolder = Instance.new("Folder")
	TabsFolder.Name = "TabsFolder"
	TabsFolder.Parent = ContentContainer

	function Library:ToggleUI() Main.Visible = not Main.Visible end
--// THƯ VIỆN UI THUẦN TÚY - PHẦN 3: TABS & ELEMENTS SYSTEM
	local Tabs = {}
	local first = true

	function Tabs:Tab(TabText, TabIcon)
		TabText = TabText or "Untitled"

		local Active = Instance.new("TextButton")
		Active.Name = TabText.."_TabButton"
		Active.Parent = ButtonHolder
		Active.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Active.BackgroundTransparency = 1
		Active.Size = UDim2.new(1, 0, 0, 30)
		Active.Font = Enum.Font.Ubuntu
		Active.Text = "   " .. TabText
		Active.TextColor3 = Color3.fromRGB(199, 199, 199)
		Active.TextSize = 12
		Active.TextXAlignment = Enum.TextXAlignment.Left

		local NewTab = Instance.new("ScrollingFrame")
		NewTab.Name = TabText.."_Tab"
		NewTab.Parent = TabsFolder
		NewTab.BackgroundTransparency = 1
		NewTab.Size = UDim2.new(1, 0, 1, 0)
		NewTab.AutomaticCanvasSize = "Y"
		NewTab.CanvasSize = UDim2.new(0, 0, 0, 0)
		NewTab.ScrollBarThickness = 2

		local UIListLayout_2 = Instance.new("UIListLayout")
		UIListLayout_2.Parent = NewTab
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 6)

		if first then
			first = false
			NewTab.Visible = true
			Active.BackgroundTransparency = 0.9
			Active.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			NewTab.Visible = false
		end

		Active.MouseButton1Click:Connect(function()
			for _, v in pairs(TabsFolder:GetChildren()) do v.Visible = false end
			for _, v in pairs(ButtonHolder:GetChildren()) do
				if v:IsA("TextButton") then
					Library:tween(v, {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(199, 199, 199)})
				end
			end
			NewTab.Visible = true
			Library:tween(Active, {BackgroundTransparency = 0.9, TextColor3 = Color3.fromRGB(255, 255, 255)})
		end)

		local Elements = {}

		-- 1. Section (Tiêu đề phân mục)
		function Elements:Section(title)
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Name = "Section_"..title
			SectionFrame.Parent = NewTab
			SectionFrame.BackgroundTransparency = 1
			SectionFrame.Size = UDim2.new(1, 0, 0, 20)

			local Text = Instance.new("TextLabel")
			Text.Parent = SectionFrame
			Text.Size = UDim2.new(1, 0, 1, 0)
			Text.BackgroundTransparency = 1
			Text.Font = Enum.Font.Ubuntu
			Text.Text = "——  " .. title .. "  ——"
			Text.TextColor3 = Color3.fromRGB(150, 150, 150)
			Text.TextSize = 13
			Text.TextXAlignment = Enum.TextXAlignment.Center
		end

		-- 2. TextBox (Ô nhập văn bản / Số liệu Hitbox)
		function Elements:TextBox(text, callback)
			callback = callback or function() end
			local TextBoxFrame = Instance.new("Frame")
			TextBoxFrame.Parent = NewTab
			TextBoxFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			TextBoxFrame.Size = UDim2.new(1, -10, 0, 32)

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = TextBoxFrame

			local Label = Instance.new("TextLabel")
			Label.Parent = TextBoxFrame
			Label.BackgroundTransparency = 1
			Label.Position = UDim2.new(0, 8, 0, 0)
			Label.Size = UDim2.new(0, 180, 1, 0)
			Label.Font = Enum.Font.Ubuntu
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextSize = 14
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local Input = Instance.new("TextBox")
			Input.Parent = TextBoxFrame
			Input.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Input.Position = UDim2.new(1, -105, 0.5, -11)
			Input.Size = UDim2.new(0, 100, 0, 22)
			Input.Font = Enum.Font.Ubuntu
			Input.PlaceholderText = "Type here!"
			Input.Text = ""
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.TextSize = 12
			Input.ClearTextOnFocus = false

			local UICorner2 = Instance.new("UICorner")
			UICorner2.CornerRadius = UDim.new(0, 4)
			UICorner2.Parent = Input

			Input.FocusLost:Connect(function(enterPressed)
				callback(Input.Text)
			end)
		end

		-- 3. Toggle (Nút công tắc Bật / Tắt)
		function Elements:Toggle(ToggleName, callback)
			ToggleName = ToggleName or "Toggle"
			callback = callback or function() end

			local Toggle = Instance.new("TextButton")
			Toggle.Name = "Toggle"
			Toggle.Parent = NewTab
			Toggle.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			Toggle.Size = UDim2.new(1, -10, 0, 32)
			Toggle.Text = ""
			Toggle.AutoButtonColor = false

			local UICorner_8 = Instance.new("UICorner")
			UICorner_8.CornerRadius = UDim.new(0, 4)
			UICorner_8.Parent = Toggle

			local Title_6 = Instance.new("TextLabel")
			Title_6.Parent = Toggle
			Title_6.BackgroundTransparency = 1
			Title_6.Position = UDim2.new(0, 8, 0, 0)
			Title_6.Size = UDim2.new(1, -40, 1, 0)
			Title_6.Font = Enum.Font.Ubuntu
			Title_6.Text = ToggleName
			Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_6.TextSize = 14
			Title_6.TextXAlignment = Enum.TextXAlignment.Left

			local CheckmarkHolder = Instance.new("Frame")
			CheckmarkHolder.Parent = Toggle
			CheckmarkHolder.AnchorPoint = Vector2.new(1, 0.5)
			CheckmarkHolder.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
			CheckmarkHolder.Position = UDim2.new(1, -8, 0.5, 0)
			CheckmarkHolder.Size = UDim2.new(0, 16, 0, 16)

			local UICorner_9 = Instance.new("UICorner")
			UICorner_9.CornerRadius = UDim.new(0, 2)
			UICorner_9.Parent = CheckmarkHolder

			local toggled = false
			Toggle.MouseButton1Click:Connect(function()
				toggled = not toggled
				if toggled then
					Library:tween(CheckmarkHolder, {BackgroundColor3 = Color3.fromRGB(115, 191, 92)})
				else
					Library:tween(CheckmarkHolder, {BackgroundColor3 = Color3.fromRGB(63, 63, 63)})
				end
				pcall(callback, toggled)
			end)
		end

		-- 4. InfoLabel (Thông báo xanh lam dạng chữ)
		function Elements:InfoLabel(InfoText)
			local Info = Instance.new("Frame")
			Info.Parent = NewTab
			Info.BackgroundColor3 = Color3.fromRGB(3, 32, 43)
			Info.Size = UDim2.new(1, -10, 0, 28)

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Info

			local Title = Instance.new("TextLabel")
			Title.Parent = Info
			Title.BackgroundTransparency = 1
			Title.Position = UDim2.new(0, 8, 0, 0)
			Title.Size = UDim2.new(1, -16, 1, 0)
			Title.Font = Enum.Font.Ubuntu
			Title.Text = "ℹ️  " .. InfoText
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
		end

		return Elements
	end
	return Tabs
end

return Library
