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

## Luarmor runtime (обязательный шаг)

Игровые скрипты и премиум читают из окружения служебные значения, которые
ставит init-рантайм Luarmor v4 (`https://cdn.luarmor.net/v4_init_novemide.lua`).
Автор грузит его стоковым загрузчиком:

```lua
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/0ae9fe4cf963e3a13d25eed0e2ce5940.lua"))()
```

Лоадер делает это сам (`bootRuntime()`) перед запуском любого скрипта.
Без рантайма симптомы такие:

* премиум: `[string "scripts/QuantumOnyxPremium.lua"]:106046: You Are Lost!`
* free: `attempt to index nil with 'RaceList'` / `'QETiqnyEAUPCtf'` / `'ClassName'`

Если рантайм не поднялся, в консоли будет `runtime init failed: ...` — тогда
скрипты запустятся без него и упадут на первом же обращении к этим значениям.
