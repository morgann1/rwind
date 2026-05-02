--!strict

local function createStyleRule(sheet: StyleSheet, selector: string, props: { [string]: any })
	local rule = Instance.new("StyleRule")
	rule.Selector = selector
	rule:SetProperties(props)
	rule.Parent = sheet
	return rule
end

local FONTS = table.freeze({
	BuilderSans = "rbxasset://fonts/families/BuilderSans.json",
	BuilderExtended = "rbxasset://fonts/families/BuilderExtended.json",
	BuilderMono = "rbxasset://fonts/families/BuilderMono.json",
	Arimo = "rbxasset://fonts/families/Arimo.json",
	Roboto = "rbxasset://fonts/families/Roboto.json",
	RobotoCondensed = "rbxasset://fonts/families/RobotoCondensed.json",
	RobotoMono = "rbxasset://fonts/families/RobotoMono.json",
	SourceSansPro = "rbxasset://fonts/families/SourceSansPro.json",
	Nunito = "rbxasset://fonts/families/Nunito.json",
	Montserrat = "rbxasset://fonts/families/Montserrat.json",
	Oswald = "rbxasset://fonts/families/Oswald.json",
	JosefinSans = "rbxasset://fonts/families/JosefinSans.json",
	TitilliumWeb = "rbxasset://fonts/families/TitilliumWeb.json",
	Jura = "rbxasset://fonts/families/Jura.json",
	Michroma = "rbxasset://fonts/families/Michroma.json",
	Inconsolata = "rbxasset://fonts/families/Inconsolata.json",
	Merriweather = "rbxasset://fonts/families/Merriweather.json",
	AccanthisADF = "rbxasset://fonts/families/AccanthisADFStd.json",
	RomanAntique = "rbxasset://fonts/families/RomanAntique.json",
	Balthazar = "rbxasset://fonts/families/Balthazar.json",
	Bangers = "rbxasset://fonts/families/Bangers.json",
	FredokaOne = "rbxasset://fonts/families/FredokaOne.json",
	LuckiestGuy = "rbxasset://fonts/families/LuckiestGuy.json",
	Sarpanch = "rbxasset://fonts/families/Sarpanch.json",
	DenkOne = "rbxasset://fonts/families/DenkOne.json",
	AmaticSC = "rbxasset://fonts/families/AmaticSC.json",
	Creepster = "rbxasset://fonts/families/Creepster.json",
	HighwayGothic = "rbxasset://fonts/families/HighwayGothic.json",
	GrenzeGotisch = "rbxasset://fonts/families/GrenzeGotisch.json",
	SpecialElite = "rbxasset://fonts/families/SpecialElite.json",
	PressStart2P = "rbxasset://fonts/families/PressStart2P.json",
	ComicNeue = "rbxasset://fonts/families/ComicNeueAngular.json",
	IndieFlower = "rbxasset://fonts/families/IndieFlower.json",
	Kalam = "rbxasset://fonts/families/Kalam.json",
	PatrickHand = "rbxasset://fonts/families/PatrickHand.json",
	PermanentMarker = "rbxasset://fonts/families/PermanentMarker.json",
	Fondamento = "rbxasset://fonts/families/Fondamento.json",
	Guru = "rbxasset://fonts/families/Guru.json",
})
