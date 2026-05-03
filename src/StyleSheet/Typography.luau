--!strict

local Palette = require("@self/Palette")

export type Registrar = (sheet: StyleSheet) -> ()

local function rule(selector: string, props: { [string]: any }): Registrar
	return function(sheet: StyleSheet)
		local styleRule = Instance.new("StyleRule")
		styleRule.Selector = selector
		styleRule:SetProperties(props)
		styleRule.Parent = sheet
	end
end

local function font(uri: string, weight: Enum.FontWeight?, style: Enum.FontStyle?): Font
	return Font.new(uri, weight or Enum.FontWeight.Regular, style or Enum.FontStyle.Normal)
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

local FAMILY_URIS: { [string]: string } = table.freeze({
	["font-sans"] = FONTS.BuilderSans,
	["font-serif"] = FONTS.Merriweather,
	["font-mono"] = FONTS.BuilderMono,
	["font-builder"] = FONTS.BuilderSans,
	["font-builder-ext"] = FONTS.BuilderExtended,
	["font-roboto"] = FONTS.Roboto,
	["font-roboto-condensed"] = FONTS.RobotoCondensed,
	["font-roboto-mono"] = FONTS.RobotoMono,
	["font-source-sans"] = FONTS.SourceSansPro,
	["font-nunito"] = FONTS.Nunito,
	["font-montserrat"] = FONTS.Montserrat,
	["font-oswald"] = FONTS.Oswald,
	["font-josefin"] = FONTS.JosefinSans,
	["font-titillium"] = FONTS.TitilliumWeb,
	["font-jura"] = FONTS.Jura,
	["font-michroma"] = FONTS.Michroma,
	["font-inconsolata"] = FONTS.Inconsolata,
	["font-arimo"] = FONTS.Arimo,
	["font-accanthis"] = FONTS.AccanthisADF,
	["font-roman-antique"] = FONTS.RomanAntique,
	["font-balthazar"] = FONTS.Balthazar,
	["font-bangers"] = FONTS.Bangers,
	["font-fredoka"] = FONTS.FredokaOne,
	["font-luckiest"] = FONTS.LuckiestGuy,
	["font-sarpanch"] = FONTS.Sarpanch,
	["font-denk"] = FONTS.DenkOne,
	["font-amatic"] = FONTS.AmaticSC,
	["font-creepster"] = FONTS.Creepster,
	["font-highway"] = FONTS.HighwayGothic,
	["font-grenze"] = FONTS.GrenzeGotisch,
	["font-special-elite"] = FONTS.SpecialElite,
	["font-press-start"] = FONTS.PressStart2P,
	["font-comic"] = FONTS.ComicNeue,
	["font-indie-flower"] = FONTS.IndieFlower,
	["font-kalam"] = FONTS.Kalam,
	["font-patrick-hand"] = FONTS.PatrickHand,
	["font-permanent-marker"] = FONTS.PermanentMarker,
	["font-fondamento"] = FONTS.Fondamento,
	["font-guru"] = FONTS.Guru,
})

local WEIGHTS: { [string]: Enum.FontWeight } = table.freeze({
	["font-thin"] = Enum.FontWeight.Thin,
	["font-extralight"] = Enum.FontWeight.ExtraLight,
	["font-light"] = Enum.FontWeight.Light,
	["font-normal"] = Enum.FontWeight.Regular,
	["font-medium"] = Enum.FontWeight.Medium,
	["font-semibold"] = Enum.FontWeight.SemiBold,
	["font-bold"] = Enum.FontWeight.Bold,
	["font-extrabold"] = Enum.FontWeight.ExtraBold,
	["font-black"] = Enum.FontWeight.Heavy,
})

local STYLES: { [string]: Enum.FontStyle } = table.freeze({
	["italic"] = Enum.FontStyle.Italic,
	["not-italic"] = Enum.FontStyle.Normal,
})

local FONT_SIZES: { [string]: number } = table.freeze({
	["text-xs"] = 10,
	["text-sm"] = 12,
	["text-base"] = 14,
	["text-lg"] = 18,
	["text-xl"] = 20,
	["text-2xl"] = 24,
	["text-3xl"] = 30,
	["text-4xl"] = 36,
	["text-5xl"] = 48,
	["text-6xl"] = 60,
	["text-7xl"] = 72,
	["text-8xl"] = 96,
	["text-9xl"] = 128,
})

local OPACITIES: { number } = table.freeze({
	0, 5, 10, 20, 25, 30, 40, 50, 60, 70, 75, 80, 90, 95, 100,
})

local LINE_HEIGHTS: { [string]: number } = table.freeze({
	["leading-none"] = 1,
	["leading-tight"] = 1.25,
	["leading-snug"] = 1.375,
	["leading-normal"] = 1.5,
	["leading-relaxed"] = 1.625,
	["leading-loose"] = 2,
	["leading-3"] = 0.75,
	["leading-4"] = 1,
	["leading-5"] = 1.25,
	["leading-6"] = 1.5,
	["leading-7"] = 1.75,
	["leading-8"] = 2,
	["leading-9"] = 2.25,
	["leading-10"] = 2.5,
})

local RULES: { [string]: Registrar } = {}

for tag, uri in FAMILY_URIS do
	RULES[tag] = rule(`.{tag}`, { FontFace = font(uri) })
end
for tag, weight in WEIGHTS do
	RULES[tag] = rule(`.{tag}`, { FontFace = font(FONTS.BuilderSans, weight) })
end
for tag, style in STYLES do
	RULES[tag] = rule(`.{tag}`, { FontFace = font(FONTS.BuilderSans, Enum.FontWeight.Regular, style) })
end
for tag, size in FONT_SIZES do
	RULES[tag] = rule(`.{tag}`, { TextSize = size })
end
for tag, height in LINE_HEIGHTS do
	RULES[tag] = rule(`.{tag}`, { LineHeight = height })
end

for hue, palette in Palette.PALETTE do
	for shade, color in palette do
		local tag = `text-{hue}-{shade}`
		RULES[tag] = rule(`.{tag}`, { TextColor3 = color })
	end
end

RULES["text-white"] = rule(".text-white", { TextColor3 = Palette.WHITE })
RULES["text-black"] = rule(".text-black", { TextColor3 = Palette.BLACK })
RULES["text-transparent"] = rule(".text-transparent", { TextTransparency = 1 })

for _, opacity in OPACITIES do
	local tag = `text-opacity-{opacity}`
	RULES[tag] = rule(`.{tag}`, { TextTransparency = 1 - opacity / 100 })
end

RULES["text-left"] = rule(".text-left", { TextXAlignment = Enum.TextXAlignment.Left })
RULES["text-center"] = rule(".text-center", { TextXAlignment = Enum.TextXAlignment.Center })
RULES["text-right"] = rule(".text-right", { TextXAlignment = Enum.TextXAlignment.Right })
RULES["align-top"] = rule(".align-top", { TextYAlignment = Enum.TextYAlignment.Top })
RULES["align-middle"] = rule(".align-middle", { TextYAlignment = Enum.TextYAlignment.Center })
RULES["align-bottom"] = rule(".align-bottom", { TextYAlignment = Enum.TextYAlignment.Bottom })
RULES["truncate"] = rule(".truncate", { TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = false })
RULES["text-wrap"] = rule(".text-wrap", { TextWrapped = true })
RULES["text-nowrap"] = rule(".text-nowrap", { TextWrapped = false })
RULES["text-scaled"] = rule(".text-scaled", { TextScaled = true })
RULES["rich-text"] = rule(".rich-text", { RichText = true })
RULES["underline"] = rule(".underline", { RichText = true })
RULES["line-through"] = rule(".line-through", { RichText = true })

return table.freeze({
	RULES = table.freeze(RULES),
	FAMILY_URIS = FAMILY_URIS,
	WEIGHTS = WEIGHTS,
	STYLES = STYLES,
	FONTS = FONTS,
})
