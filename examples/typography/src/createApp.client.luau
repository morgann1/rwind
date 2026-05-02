--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local Tailwind = require(ReplicatedStorage.Tailwind)

local App = require(script.Parent.App)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

Tailwind.install()
Tailwind.mount(playerGui)

local root = ReactRoblox.createRoot(Instance.new("Folder"))
root:render(ReactRoblox.createPortal(React.createElement(App), playerGui))
