# Quantum Onyx — open release

Деобфусцированная версия. Без key-system, без Luarmor, без шифрования строк.

## Структура

```
QuantumOnyx.lua                     лоадер с GUI (без ключей)
scripts/QuantumOnyxPremium.lua      премиум-пайлоад Blox Fruits (бывший test.lua)
Games/BloxFruits.lua                free Blox Fruits
Games/CutTrees.lua
Games/KickALuckyBlock.lua
Games/SlimeRNG.lua                  Luraph, как есть
Util/Library.lua                    хаб (UI-библиотека)
Util/KaitunLibrary.lua
Util/LibraryModule/Themes.lua
Util/BloxFruitModule/bypass.lua
Util/BloxFruitModule/HookMeta.lua
Util/BloxFruitModule/Preload/{Data,UI_Tabs,Funcs,helper}.lua   открытые модули
Util/BloxFruitModule/Preload/Visuals.lua
Util/BloxFruitModule/Preload/Weebo.lua                         Luraph, как есть
dev/niulai.lua
```

Пути важны: payload ищет модули по путям автора (`Util/Library.lua`,
`Util/BloxFruitModule/Preload/Weebo.lua`, `dev/niulai.lua`, …) — структура репозитория
зеркалит оригинальную, иначе загрузка падает на 404-HTML.

## Запуск

```powershell
$USER = "kolyamips"
$REPO = "onyxcracked123123"
$BASE = "https://raw.githubusercontent.com/$USER/$REPO/main/"

cd C:\Users\mopsm\OneDrive\Desktop\deobfuscator\release
python ..\tools\repoint_urls.py --base $BASE .
git add .
git commit -m "fix release layout: mirror repo paths, all raw urls repointed"
git push -u origin main
```

В эксплойтере:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/kolyamips/onyxcracked123123/main/QuantumOnyx.lua"))()
```

В GUI кнопки на все скрипты; у скрипта, подходящего под текущий `PlaceId`, стоит звёздочка.
Blox Fruits = PlaceId `994732206`. Если игра не определилась — жми нужную кнопку вручную.

## Что сделано с кодом

* **Строки.** Оба обфускатора (Luarmor v4, IronBrew) держали все строки в зашифрованной
  таблице. Таблица расшифрована, константы подставлены литералами.
* **Крипто.** Удалены: таблица строк, декодер `u()`, кэш `n`/`R`, функция `X()`.
* **Форматирование.** Один statement — одна строка, нормальный отступ, тела функций развёрнуты.
* **Проверка.** AST отформатированного файла совпадает с AST исходника (`tools/ast_equiv.js`).

## Ограничения

* **Key-system вырезан.** В премиум-пайлоаде проверки ключа не было — она была только в
  обёртке `QuantumOnyx.lua` (Luarmor SDK, `script_id = 0ae9fe4cf963e3a13d25eed0e2ce5940`).
  Скрипт запускается сразу.
* **Структура управления плоская.** Luarmor/IronBrew компилируют скрипт в один диспетчер
  `while U do if U < 0x...`. Luau (Roblox) не поддерживает `goto`, поэтому человеческая
  структура `if/else` не восстановлена — нужен релоопер с дублированием кода.
  Полностью развёрнутый goto-вариант (для чтения и ручного портирования) — в
  `out/premium/premium.devirt.lua`.
* **Имена локальных переменных** (`j`, `qk`, `nk`, `Ck[0x10]`) — внутренние регистры
  обфускатора, оригиналы стёрты.
* **`lib/Weebo.lua`** и `Games/SlimeRNG.lua` — Luraph, не расшифрованы.
* **`api.quantumonyx.cc`** — внешний API автора, остался в коде (проверка обновлений).

## Инструменты

| Утилита | Назначение |
|---|---|
| `tools/deobf_luarmor.py` | расшифровка таблицы строк Luarmor v4 |
| `tools/deobf_ironbrew.py` | расшифровка ASCII85-таблицы IronBrew |
| `tools/devirt_vm.js` | девиртуализация диспетчера (CFG → goto-вариант) |
| `tools/build_release.js` | снятие крипто + форматирование |
| `tools/assemble_release.py` | сборка папки release с правильной структурой |
| `tools/repoint_urls.py` | перевод raw-ссылок на свой репозиторий |
| `tools/check_paths.py` | проверка, что все запрошенные пути есть в release |
| `tools/ast_equiv.js` | проверка, что форматирование не изменило семантику |

Полный разбор — в `REPORT.md`.

## Luarmor runtime и почему нужен ключ

Скрипты читают из окружения служебные значения, которые ставит init-рантайм
Luarmor v4. Он **требует валидный `script_key`** — проверка на сервере
`api.luarmor.net`, поэтому без ключа официальный загрузчик показывает:

```
Auth Error
You need a script_key to access this script. No key found.
```

В лоадере есть `BOOT_RUNTIME` (по умолчанию `false`). Если появится рабочий
ключ, включи его и задай ключ до запуска:

```lua
getgenv().script_key = "<ключ>"
BOOT_RUNTIME = true   -- в коде лоадера
```

Без рантайма симптомы ровно те, что видны в консоли:

* премиум: `:106046: You Are Lost!` — VM ушла в trap, состояние `nil`;
* free: `attempt to index nil with 'RaceList' / 'QETiqnyEAUPCtf' / 'ClassName'`.

Это не ошибка распаковки: файлы побайтово совпадают с живым репозиторием автора,
а в payload 1367 таких чтений и ни одной записи — значения приходят только из
рантайма.
