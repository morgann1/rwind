local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local Tailwind = require(ReplicatedStorage.Tailwind)

local e = React.createElement
local rw = Tailwind.rw

local function App()
	return e("ScreenGui", {}, {
		e("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
			Text = "Hello, world!",
			TextColor3 = Color3.fromHex("FFFFFF"),
			[React.Tag] = rw("font-roman-antique", "text-6xl"),
		}),
	})
end

return App
