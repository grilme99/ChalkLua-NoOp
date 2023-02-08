--[[
	* Copyright (c) Brooke Rhodes. All rights reserved.
	* Licensed under the MIT License (the "License");
	* you may not use this file except in compliance with the License.
	* You may obtain a copy of the License at
	*
	*     https://opensource.org/licenses/MIT
	*
	* Unless required by applicable law or agreed to in writing, software
	* distributed under the License is distributed on an "AS IS" BASIS,
	* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	* See the License for the specific language governing permissions and
	* limitations under the License.
]]

--!nonstrict

--- This is a no-op implementation of ChalkLua licensed under MIT. The version provided in CorePackages doesn't come
--- with a license and isn't of much use to game or library developers because we probably won't be running Luau on the
--- command line anyway (the only time Chalk is useful).

local Chalk = { level = 2 }

local ansiStyles = {
	modifier = {
		"reset",
		"bold",
		"dim",
		"italic",
		"underline",
		"overline",
		"inverse",
		"hidden",
		"strikethrough",
	},

	color = {
		"black",
		"red",
		"green",
		"yellow",
		"blue",
		"magenta",
		"cyan",
		"white",

		"blackBright",
		"gray",
		"grey",
		"redBright",
		"greenBright",
		"yellowBright",
		"blueBright",
		"magentaBright",
		"cyanBright",
		"whiteBright",
	},

	bgColor = {
		"bgBlack",
		"bgRed",
		"bgGreen",
		"bgYellow",
		"bgBlue",
		"bgMagenta",
		"bgCyan",
		"bgWhite",

		"bgBlackBright",
		"bgGray",
		"bgGrey",
		"bgRedBright",
		"bgGreenBright",
		"bgYellowBright",
		"bgBlueBright",
		"bgMagentaBright",
		"bgCyanBright",
		"bgWhiteBright",
	},
}

local styles = {}

for _, group in ansiStyles do
	for styleName in group do
		styles[styleName] = true
	end
end

local function isStringJsNull(str)
	return str == nil or type(str) == "string" and #str == 0
end

setmetatable(Chalk, {
	__call = function(_, str)
		if isStringJsNull(str) then
			return ""
		end

		return tostring(str)
	end,
})

local function compositeStyler(_style, _otherStyle)
	return createNoOpStyler()
end

local function applyStyle(_self, str)
	if isStringJsNull(str) then
		return ""
	end

	-- Styles are no-op in this implementation
	return tostring(str)
end

function createNoOpStyler()
	local styler = {
		open = "",
		close = "",
	}

	setmetatable(styler, {
		__call = function(self, str)
			return applyStyle(self, str)
		end,
		__concat = function(self, other)
			return compositeStyler(self, other)
		end,
	})

	return styler
end

for styleName, _style in pairs(styles) do
	Chalk[styleName] = createNoOpStyler()
end

Chalk["reset"] = createNoOpStyler()

Chalk["rgb"] = function(_red, _green, _blue)
	return createNoOpStyler()
end

Chalk["bgRgb"] = function(_red, _green, _blue)
	return createNoOpStyler()
end

Chalk["hex"] = function(_hex)
	return createNoOpStyler()
end

Chalk["bgHex"] = function(_hex)
	return createNoOpStyler()
end

Chalk["ansi"] = function(_ansi)
	return createNoOpStyler()
end

Chalk["bgAnsi"] = function(_ansi)
	return createNoOpStyler()
end

Chalk["ansi256"] = function(_ansi)
	return createNoOpStyler()
end

Chalk["bgAnsi256"] = function(_ansi)
	return createNoOpStyler()
end

return Chalk
