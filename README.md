# Quantum Onyx — open release

Деобфусцированная версия Quantum Onyx. Без key-system, без Luarmor, без шифрования строк.

Что внутри:

| Файл | Что это |
|---|---|
| `QuantumOnyx.lua` | лоадер с GUI: выбирает скрипт по `game.PlaceId` и грузит его с GitHub |
| `scripts/QuantumOnyxPremium.lua` | премиум-пайлоад (Blox Fruits) — бывший `test.lua`, развёрнут в читаемый Lua |
| `scripts/BloxFruits.lua` | free-скрипт Blox Fruits |
| `scripts/CutTrees.lua` | free-скрипт Cut Trees |
| `scripts/KickALuckyBlock.lua` | free-скрипт Kick a Lucky Block |
| `lib/Library.lua`, `lib/KaitunLibrary.lua`, `lib/Visuals.lua` | хаб (UI-библиотека) |
| `lib/Weebo.lua` | библиотека вебхуков/нотификаций (Luraph — расшифровать не удалось, оставлена как есть) |

## Как запустить

1. Поправь `BASE_URL` в `QuantumOnyx.lua` на свою ссылку:

   ```lua
   local BASE_URL = "https://raw.githubusercontent.com/<USER>/<REPO>/main/"
   ```

   Скрипты внутри `scripts/` и `lib/` тоже указывают на этот URL — заменить можно
   одним проходом: `python tools/repoint_urls.py release/scripts/*.lua release/lib/*.lua`
   (в репозитории лежит готовый скрипт).

2. Залей `QuantumOnyx.lua`, `scripts/`, `lib/` в репозиторий.

3. В эксплойтере:

   ```lua
   loadstring(game:HttpGet("https://raw.githubusercontent.com/<USER>/<REPO>/main/QuantumOnyx.lua"))()
   ```

   или если файлы уже в workspace эксплойтера:

   ```lua
   loadstring(readfile("QuantumOnyx.lua"))()
   ```

4. В GUI жми **LOAD** (или **PREMIUM** — отдельная кнопка на премиум-сборку Blox Fruits).

Если не хочешь GitHub: положи `scripts/` и `lib/` в workspace эксплойтера и замени
в `QuantumOnyx.lua` вызов `loadRemote` на чтение `readfile(...)`.

## Что было сделано с кодом

* **Строки.** Оба обфускатора (Luarmor v4 и IronBrew) держали все строки в зашифрованной
  таблице. Таблица расшифрована, константы подставлены литералами: `"FindFirstChild"`,
  `"Auto Kill All Bosses"`, `"IslandESP"` и т.д. — видно прямо в коде.
* **Крипто.** Удалены: таблица строк, декодер `u()`, кэш `n`/`R`, функция поиска `X()`.
* **Форматирование.** Один statement — одна строка, нормальный отступ, тела функций
  развёрнуты. Файл читается как обычный Lua.
* **Проверка.** AST отформатированного файла побайтово совпадает с AST исходника
  (проверка `tools/ast_equiv.js`) — значит переформатирование ничего не сломало.

## Чего нет (и почему)

* **Key-system вырезан.** В самом премиум-пайлоаде проверки ключа не было — она была
  только в `QuantumOnyx.lua` (обвязка Luarmor SDK). Скрипт запускается сразу.
* **Структура управления осталась плоской.** Luarmor/IronBrew компилируют скрипт в один
  диспетчер `while U do if U < 0x...` — это бинарный поиск по адресам блоков.
  Luau (Roblox) не поддерживает `goto`, поэтому «человеческая» структура
  `if/else` потребовала бы полного релоопера с дублированием кода. Сейчас читаемо
  построчно, но if-дерево осталось машинным.
  Полностью развёрнутый (goto-вариант, для чтения и портирования фич руками) лежит
  в `out/premium/premium.devirt.lua`.
* **Имена локальных переменных** (`j`, `qk`, `nk`, …) — это внутренние регистры
  обфускатора, оригинальные имена стёрты безвозвратно.
* **`lib/Weebo.lua`** — Luraph, не расшифрован (отдельная задача: своя VM с байткодом).
* **`api.quantumonyx.cc`** — внешний API автора, в коде остались обращения к нему
  (проверка обновлений/телеметрия). Если он умрёт — скрипт это переживёт, но проверку
  версии стоит вырезать.

## Как это сделано (инструменты)

Всё в папке `tools/` основного репозитория:

| Утилита | Назначение |
|---|---|
| `deobf_luarmor.py` | расшифровка таблицы строк Luarmor v4 |
| `deobf_ironbrew.py` | расшифровка ASCII85-таблицы IronBrew |
| `devirt_vm.js` | девиртуализация диспетчера (CFG + goto-вариант) |
| `build_release.js` | сборка чистого релиза: снятие крипто + форматирование |
| `ast_equiv.js` | проверка, что форматирование не изменило семантику |
| `validate_devirt.js` | проверка, что файл парсится и все `goto` разрешаются |
| `extract_map.js` | карта «блок → строки → переходы» |

Полный разбор — в `REPORT.md`.
