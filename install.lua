-- ClashOS bootstrap installer for CC: Tweaked
-- Usage:
--   wget run <URL_TO_install.lua> <BASE_URL>
-- Example:
--   wget run https://raw.githubusercontent.com/user/ClashOS/main/install.lua https://raw.githubusercontent.com/user/ClashOS/main

local args = { ... }

local function writeFile(path, content)
  local dir = fs.getDir(path)
  if dir and dir ~= "" then
    fs.makeDir(dir)
  end

  local h = fs.open(path, "w")
  if not h then
    return false, "cannot open file: " .. path
  end

  h.write(content)
  h.close()
  return true
end

local function clearAndTitle()
  term.clear()
  term.setCursorPos(1, 1)
  print("=== ClashOS Bootstrap ===")
  print("")
end

local function askBaseUrl()
  local base = args[1]
  if base and base ~= "" then
    return base
  end

  print("Укажи BASE_URL, откуда скачать installer.lua")
  print("Пример:")
  print("https://raw.githubusercontent.com/<user>/<repo>/main")
  write("> ")
  return read()
end

local startupLoader = [[
local function readSource()
  if not fs.exists("clashos/source.txt") then
    return nil
  end

  local f = fs.open("clashos/source.txt", "r")
  if not f then
    return nil
  end

  local v = f.readAll()
  f.close()
  return v
end

local function startInstalledSystem()
  os.loadAPI("clashos/config.lua")
  os.loadAPI("clashos/commands.lua")
  os.loadAPI("clashos/shell.lua")
  clashos_shell.boot()
  clashos_shell.run()
end

local function runFirstBootInstaller(base)
  term.clear()
  term.setCursorPos(1, 1)
  print("ClashOS: первый запуск")
  print("Источник: " .. base)
  print("")

  shell.run("delete", "installer.lua")
  local ok = shell.run("wget", base .. "/installer.lua", "installer.lua")
  if not ok then
    print("[ERR] Не удалось скачать installer.lua")
    print("Проверь BASE_URL и интернет.")
    print("Повтори bootstrap команду:")
    print("wget run <url_install.lua> <base_url>")
    return
  end

  print("[OK] installer.lua скачан")
  print("Запускаю установщик...")
  shell.run("installer")
end

if fs.exists("clashos/config.lua") and fs.exists("clashos/commands.lua") and fs.exists("clashos/shell.lua") then
  startInstalledSystem()
else
  local base = readSource()
  if not base or base == "" then
    term.clear()
    term.setCursorPos(1, 1)
    print("[ERR] clashos/source.txt не найден")
    print("Выполни bootstrap снова:")
    print("wget run <url_install.lua> <base_url>")
  else
    runFirstBootInstaller(base)
  end
end
]]

clearAndTitle()
local baseUrl = askBaseUrl()
if not baseUrl or baseUrl == "" then
  print("[ERR] BASE_URL пустой. Установка отменена.")
  return
end

local ok1, err1 = writeFile("clashos/source.txt", baseUrl)
if not ok1 then
  print("[ERR] " .. tostring(err1))
  return
end

local ok2, err2 = writeFile("startup.lua", startupLoader)
if not ok2 then
  print("[ERR] " .. tostring(err2))
  return
end

print("[OK] Записан startup.lua загрузчик")
print("[OK] Сохранен источник: " .. baseUrl)
print("")
print("Следующий шаг: reboot")
print("После перезагрузки загрузчик сам скачает installer.lua")
