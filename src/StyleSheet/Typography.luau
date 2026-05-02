--!strict

local function createStyleRule(sheet: StyleSheet, selector: string, props: { [string]: any })
	local rule = Instance.new("StyleRule")
	rule.Selector = selector
	rule:SetProperties(props)
	rule.Parent = sheet
	return rule
end

local function createFont(uri: string, weight: Enum.FontWeight?, style: Enum.FontStyle?): Font
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

local FAMILY_RULES: { [string]: string } = table.freeze({
	["rw-font-sans"] = FONTS.BuilderSans,
	["rw-font-serif"] = FONTS.Merriweather,
	["rw-font-mono"] = FONTS.BuilderMono,
	["rw-font-builder"] = FONTS.BuilderSans,
	["rw-font-builder-ext"] = FONTS.BuilderExtended,
	["rw-font-roboto"] = FONTS.Roboto,
	["rw-font-roboto-condensed"] = FONTS.RobotoCondensed,
	["rw-font-roboto-mono"] = FONTS.RobotoMono,
	["rw-font-source-sans"] = FONTS.SourceSansPro,
	["rw-font-nunito"] = FONTS.Nunito,
	["rw-font-montserrat"] = FONTS.Montserrat,
	["rw-font-oswald"] = FONTS.Oswald,
	["rw-font-josefin"] = FONTS.JosefinSans,
	["rw-font-titillium"] = FONTS.TitilliumWeb,
	["rw-font-jura"] = FONTS.Jura,
	["rw-font-michroma"] = FONTS.Michroma,
	["rw-font-inconsolata"] = FONTS.Inconsolata,
	["rw-font-arimo"] = FONTS.Arimo,
	["rw-font-accanthis"] = FONTS.AccanthisADF,
	["rw-font-roman-antique"] = FONTS.RomanAntique,
	["rw-font-balthazar"] = FONTS.Balthazar,
	["rw-font-bangers"] = FONTS.Bangers,
	["rw-font-fredoka"] = FONTS.FredokaOne,
	["rw-font-luckiest"] = FONTS.LuckiestGuy,
	["rw-font-sarpanch"] = FONTS.Sarpanch,
	["rw-font-denk"] = FONTS.DenkOne,
	["rw-font-amatic"] = FONTS.AmaticSC,
	["rw-font-creepster"] = FONTS.Creepster,
	["rw-font-highway"] = FONTS.HighwayGothic,
	["rw-font-grenze"] = FONTS.GrenzeGotisch,
	["rw-font-special-elite"] = FONTS.SpecialElite,
	["rw-font-press-start"] = FONTS.PressStart2P,
	["rw-font-comic"] = FONTS.ComicNeue,
	["rw-font-indie-flower"] = FONTS.IndieFlower,
	["rw-font-kalam"] = FONTS.Kalam,
	["rw-font-patrick-hand"] = FONTS.PatrickHand,
	["rw-font-permanent-marker"] = FONTS.PermanentMarker,
	["rw-font-fondamento"] = FONTS.Fondamento,
	["rw-font-guru"] = FONTS.Guru,
})

local WEIGHTS: { [string]: Enum.FontWeight } = table.freeze({
	["rw-font-thin"] = Enum.FontWeight.Thin,
	["rw-font-extralight"] = Enum.FontWeight.ExtraLight,
	["rw-font-light"] = Enum.FontWeight.Light,
	["rw-font-normal"] = Enum.FontWeight.Regular,
	["rw-font-medium"] = Enum.FontWeight.Medium,
	["rw-font-semibold"] = Enum.FontWeight.SemiBold,
	["rw-font-bold"] = Enum.FontWeight.Bold,
	["rw-font-extrabold"] = Enum.FontWeight.ExtraBold,
	["rw-font-black"] = Enum.FontWeight.Heavy,
})

local STYLES: { [string]: Enum.FontStyle } = table.freeze({
	["rw-italic"] = Enum.FontStyle.Italic,
	["rw-not-italic"] = Enum.FontStyle.Normal,
})

local FONT_SIZES = table.freeze({
	["rw-text-xs"] = 10,
	["rw-text-sm"] = 12,
	["rw-text-base"] = 14,
	["rw-text-lg"] = 18,
	["rw-text-xl"] = 20,
	["rw-text-2xl"] = 24,
	["rw-text-3xl"] = 30,
	["rw-text-4xl"] = 36,
	["rw-text-5xl"] = 48,
	["rw-text-6xl"] = 60,
})

local function register(sheet: StyleSheet)
	for tag, uri in FAMILY_RULES do
		createStyleRule(sheet, `.{tag}`, {
			FontFace = createFont(uri),
		})
	end
	for tag, weight in WEIGHTS do
		createStyleRule(sheet, `.{tag}`, {
			FontFace = createFont(FONTS.BuilderSans, weight),
		})
	end
	for tag, style in STYLES do
		createStyleRule(sheet, `.{tag}`, {
			FontFace = createFont(FONTS.BuilderSans, Enum.FontWeight.Regular, style),
		})
	end
	for tag, size in FONT_SIZES do
		createStyleRule(sheet, `.{tag}`, {
			TextSize = size,
		})
	end

	createStyleRule(sheet, ".rw-text-left", { TextXAlignment = Enum.TextXAlignment.Left })
	createStyleRule(sheet, ".rw-text-center", { TextXAlignment = Enum.TextXAlignment.Center })
	createStyleRule(sheet, ".rw-text-right", { TextXAlignment = Enum.TextXAlignment.Right })

	createStyleRule(sheet, ".rw-align-top", { TextYAlignment = Enum.TextYAlignment.Top })
	createStyleRule(sheet, ".rw-align-middle", { TextYAlignment = Enum.TextYAlignment.Center })
	createStyleRule(sheet, ".rw-align-bottom", { TextYAlignment = Enum.TextYAlignment.Bottom })

	createStyleRule(sheet, ".rw-truncate", { TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = false })
	createStyleRule(sheet, ".rw-text-wrap", { TextWrapped = true })
	createStyleRule(sheet, ".rw-text-nowrap", { TextWrapped = false })
	createStyleRule(sheet, ".rw-text-scaled", { TextScaled = true })
	createStyleRule(sheet, ".rw-rich-text", { RichText = true })
end

return table.freeze({
	register = register,
	FAMILY_RULES = FAMILY_RULES,
	WEIGHTS = WEIGHTS,
	STYLES = STYLES,
	FONTS = FONTS,
})
