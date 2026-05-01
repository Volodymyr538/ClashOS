local VERSION = "0.1.0"

local function writeFile(path, content)
  local dir = fs.getDir(path)
  if dir and dir ~= "" then
    fs.makeDir(dir)
  end

  local file = fs.open(path, "w")
  if not file then
    return false, "Не удалось открыть " .. path
  end

  file.write(content)
  file.close()
  return true
end

local function banner()
  term.clear()
  term.setCursorPos(1, 1)
  print("=== ClashOS Installer v" .. VERSION .. " ===")
  print("")
end

local function ask(prompt, default)
  write(prompt)
  if default then
    write(" [" .. default .. "]")
  end
  write(": ")
  local value = read()
  if value == "" and default then
    return default
  end
  return value
end

local function install(installPath)
  local startupContent = ([[
local ok, err = pcall(function()
  os.loadAPI("%s/clashos/config.lua")
  os.loadAPI("%s/clashos/commands.lua")
  os.loadAPI("%s/clashos/shell.lua")

  if shell and shell.run then
    clashos_shell.boot()
    clashos_shell.run()
  else
    print("Ошибка: shell API недоступно")
  end
end)

if not ok then
  print("Ошибка загрузки ClashOS: " .. tostring(err))
end
]]):format(installPath, installPath, installPath)

  local configContent = [[
clashos_config = {
  name = "ClashOS",
  version = "0.1.0",
  prompt = "clash> ",
}
]]

  local commandsContent = [[
clashos_commands = {}

local function command_help()
  print("Доступные команды:")
  print("  help     - показать это сообщение")
  print("  clear    - очистить экран")
  print("  echo ... - вывести текст")
  print("  time     - показать игровое время")
  print("  reboot   - перезагрузка")
  print("  shutdown - выключение")
end

function clashos_commands.run(command, args)
  if command == "help" then
    command_help()
  elseif command == "clear" then
    term.clear()
    term.setCursorPos(1, 1)
  elseif command == "echo" then
    print(table.concat(args, " "))
  elseif command == "time" then
    print("Игровое время: " .. textutils.formatTime(os.time(), true))
  elseif command == "reboot" then
    os.reboot()
  elseif command == "shutdown" then
    os.shutdown()
  elseif command == "" then
    -- no-op
  else
    print("Неизвестная команда: " .. command)
  end
end
]]

  local shellContent = [[
clashos_shell = {}

function clashos_shell.boot()
  term.clear()
  term.setCursorPos(1, 1)
  print(clashos_config.name .. " v" .. clashos_config.version)
  print("Введите 'help' для списка команд")
  print("")
end

function clashos_shell.run()
  while true do
    write(clashos_config.prompt)
    local line = read() or ""

    local parts = {}
    for p in string.gmatch(line, "%S+") do
      table.insert(parts, p)
    end

    local command = parts[1] or ""
    table.remove(parts, 1)

    clashos_commands.run(command, parts)
  end
end
]]

  local files = {
    [installPath .. "/startup.lua"] = startupContent,
    [installPath .. "/clashos/config.lua"] = configContent,
    [installPath .. "/clashos/commands.lua"] = commandsContent,
    [installPath .. "/clashos/shell.lua"] = shellContent,
  }

  for path, content in pairs(files) do
    local ok, err = writeFile(path, content)
    if not ok then
      return false, err
    end
    print("[OK] " .. path)
  end

  return true
end

banner()
print("Добро пожаловать в установщик ClashOS")
print("")

local installPath = ask("Путь установки", "")
if installPath == "" then
  installPath = ""
end

print("")
print("Начинаю установку...")

local ok, err = install(installPath)
if not ok then
  print("[ERR] " .. tostring(err))
  return
end

print("")
print("Установка завершена.")
print("Перезагрузите компьютер для запуска ClashOS.")
