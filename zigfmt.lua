VERSION = "0.1.1"
PLUGIN_NAME = "zigfmt"

local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

local COMMAND_NAME = "zigfmt"
local LINTER_NAME = "zigfmt"

local function fullOptionName(name)
  return PLUGIN_NAME .. "." .. name
end

local ONSAVE_OPTION_NAME = "fmt"
local ONSAVE_OPTION = fullOptionName(ONSAVE_OPTION_NAME)
local LINTER_OPTION_NAME = "lint"
local LINTER_OPTION = fullOptionName(LINTER_OPTION_NAME)

-- /path/to/test.zig:1:51: error: expected ';', found '}'
local ERROR_PATTERN = "%f:%l:%c: %m"

config.RegisterCommonOption(PLUGIN_NAME, ONSAVE_OPTION_NAME, true)
config.RegisterCommonOption(PLUGIN_NAME, LINTER_OPTION_NAME, true)

function init()
  config.MakeCommand(COMMAND_NAME, zigfmt, config.NoComplete)
  config.AddRuntimeFile(PLUGIN_NAME, config.RTHelp, "help/zigfmt.md")

  if linter then
    linter.makeLinter(LINTER_NAME, "zig", "zig", {"fmt", "--check", "%f"}, ERROR_PATTERN, {}, false, false, 0, 0, function(buf)
      return buf.Settings[LINTER_OPTION]
    end)
  end
end

function onSave(bp)
  local shouldFmt = bp.Buf:FileType() == "zig" and bp.Buf.Settings[ONSAVE_OPTION]
  if shouldFmt then
    zigfmt(bp)
  end
  return true
end

function zigfmt(bp)
  bp:Save()
  local output, err = shell.ExecCommand("zig", "fmt", bp.Buf.Path)
  -- any failure here is a parse error, the linter will handle that
  if err then
    return
  end
  -- no files were changed (zig fmt prints the name of changed files)
  if output == "" then
    return
  end
  -- the file was changed by zig fmt, so reload it
  bp.Buf:ReOpen()
  micro.InfoBar():Message("Formatted " .. bp.Buf.Path)
end
