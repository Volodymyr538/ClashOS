# ClashOS (для CC: Tweaked)

ClashOS — минимальная терминальная ОС для компьютеров из мода **CC: Tweaked**.

## Быстрый старт через `wget run`

На компьютере CC: Tweaked выполни:

```lua
wget run <URL_ДО_install.lua> <BASE_URL_ПРОЕКТА>
```

Пример:

```lua
wget run https://raw.githubusercontent.com/<user>/<repo>/main/install.lua https://raw.githubusercontent.com/<user>/<repo>/main
```

Что делает bootstrap:
- создаёт `startup.lua` (загрузчик ClashOS),
- сохраняет `clashos/source.txt` с `BASE_URL`,
- после `reboot` автоматически скачивает `installer.lua` и запускает установку.

## Установка после перезагрузки

1. Выполни `reboot`.
2. Загрузчик скачает `installer.lua`.
3. Следуй шагам установщика в терминале.
4. После завершения снова перезагрузи компьютер.

## Что уже есть в MVP

- Текстовый установщик `installer.lua`.
- Загрузчик через `startup.lua`.
- Терминальная оболочка `clashos/shell.lua`.
- Встроенные команды: `help`, `clear`, `echo`, `time`, `reboot`, `shutdown`.

## Структура проекта

- `install.lua` — bootstrap для `wget run`.
- `installer.lua` — мастер установки.
- `startup.lua` — точка входа в репозитории.
- `clashos/config.lua` — настройки.
- `clashos/shell.lua` — REPL-оболочка.
- `clashos/commands.lua` — встроенные команды.
