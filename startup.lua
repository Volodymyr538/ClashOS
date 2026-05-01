-- Dev entrypoint for repository mode.
-- In-game installer writes its own startup.lua to the target computer.

if fs.exists("clashos/config.lua") and fs.exists("clashos/commands.lua") and fs.exists("clashos/shell.lua") then
  os.loadAPI("clashos/config.lua")
  os.loadAPI("clashos/commands.lua")
  os.loadAPI("clashos/shell.lua")

  clashos_shell.boot()
  clashos_shell.run()
else
  print("ClashOS не установлен. Запустите installer.lua")
end
