# ClashOS (для CC: Tweaked)

ClashOS — минимальная терминальная ОС для компьютеров из мода **CC: Tweaked**.

 codex/create-clashos-for-cc-tweaked-687xhd
## Быстрый старт через `wget run`

На компьютере CC: Tweaked выполни:
## Что уже есть

- Текстовый установщик `installer.lua`.
- Начальный загрузчик `startup.lua`.
- Системная оболочка `clashos/shell.lua`.
- Базовые команды:
  - `help`
  - `clear`
  - `echo`
  - `time`
  - `reboot`
  - `shutdown`

## Как поставить в Minecraft

codex/create-clashos-for-cc-tweaked-7ejldg

## Быстрый старт через `wget run`

На компьютере CC: Tweaked можно запустить bootstrap-скрипт одной командой:
 main

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

 codex/create-clashos-for-cc-tweaked-687xhd
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

 main
1. Поставь мод **CC: Tweaked**.
2. Создай компьютер и открой терминал.
3. Скопируй файлы ClashOS в корень компьютера (вручную или через pastebin/http).
4. Запусти:
   ```lua
   installer
   ```
5. После установки перезагрузи компьютер.

## Структура

- `installer.lua` — мастер установки
- `startup.lua` — входная точка после загрузки
- `clashos/config.lua` — настройки
- `clashos/shell.lua` — REPL-оболочка
- `clashos/commands.lua` — встроенные команды

## Идеи для следующих версий

- Пользователи и пароли
- Файловый менеджер
- Пакетный менеджер
- GUI-режим (Basalt)
- Сеть/чат между компьютерами
main
