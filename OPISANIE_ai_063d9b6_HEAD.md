# Изменения в ветке `ai`: коммиты с `063d9b61d2e0a2b9e1c8ea8ff3ab8a9358a0d7d1` и далее

**Диапазон:** `063d9b6` (merge «Merge branch 'main' into Kefiring») .. `HEAD`
**Non-merge коммитов:** 58
**Затронуто M/D-файлов (без AI-контента):** 180
**Удалено файлов:** 13

> Правила отбора: только non-merge коммиты; только M/D-правки существующих файлов.
> Создание новых файлов не описывается; их последующие модификации помечены «(файл добавлен в диапазоне)».
> Исключён AI-контент: `ai_strategy*`, `ai_strategy_plans`, `ai_templates`, `ai_navy`, `bots*`/`bot_*`, ханки `ai_will_do`/`is_ai`.
> Русские названия — из `E:\SteamLibrary\...\localisation\russian` и модовой локализации.

---

## 1. Удалённые файлы (D)

| Файл | Коммит | Что это было |
|---|---|---|
| `common/characters/ITA.txt` | `1e6cd8c` «104» | Весь файл персонажей Италии (3689 строк: Муссолини, командиры корпусов и т.д.) |
| `common/characters/SOV.txt` | `1e6cd8c` «104» | Весь файл персонажей СССР (4257 строк: Сталин, командиры и т.д.) |
| `common/national_focus/TIB.txt` | `a571c55` «98» | Дерево фокусов Тибета (118 строк) |
| `common/national_focus/belgium.txt` | `24d3f32` «половина» | Дерево фокусов Бельгии (8751 строк) — **пересоздано заново в `2d78f37` «102» (8793 строк)** |
| `common/national_focus/congo_shared.txt` | `24d3f32` «половина» | Общее дерево Конго (10393 строк) — **пересоздано заново в `2d78f37` «102» (10382 строк)** |
| `common/opinion_modifiers/TS_volunteers_opinion_modifiers.txt` | `26fed1f` «100» | Модификаторы мнения волонтёров (8 строк) |
| `common/scripted_diplomatic_actions/TS_volunteers_diplomatic_actions.txt` | `26fed1f` «100» | Скриптовые дипломатические действия волонтёров (75 строк) |
| `common/peace_conference/cost_modifiers/cant_ins_cap.txt` | `a7a0e71` «обнова» | Модификатор стоимости мирной конференции «нельзя капитулировать» (84 строк) |
| `common/scripted_triggers/diplomacy_scripted_triggers.txt` | `77d61b6` «103» | Скриптовые триггеры дипломатии (2314 строк) — заменены на `omega_diplomacy_triggers.txt` |
| `common/units/equipment/modules/00_tank_modules.txt` | `6a1301e` «96» | Модули танковых шасси (2282 строк) |
| `history/countries/BEL - Belgium.txt` | `a7a0e71` «обнова» | История Бельгии (619 строк) |
| `interface/battleplantools.gui` | `a7a0e71` «обнова» | Интерфейс «батлплан-тулз» (600 строк) |
| `localisation/russian/victory_points_l_russian.yml` | `a7a0e71` «обнова» | Локализация Victory Points (2140 строк) |

---

## 2. Изменённые файлы (M) — «было → стало»

### 2.1. Деревья национальных фокусов (`common/national_focus/`)

**Общие паттерны по всем файлам:**
- Условия доступности: `has_completed_focus = X` → `has_country_flag = X` (переход с флагов вместо завершённых фокусов; фокусы вырезаны, но флаги живут)
- Оптимизация триггеров: `any_other_country` / `any_country` → `any_collection_element = { collection = game:all_majors }` и `any_country_with_original_tag = { original_tag_to_check = ... }`
- Условия подчинения: `is_subject` / `is_subject_of` переработаны; добавлены `NOT = { is_subject = yes }` и т.п.
- Массовое снижение стоимостей фокусов `cost` (10→5, 10→2/3, 5→2/3)
- Введение глобального флага **`VUP_Hist_version`** («Исторический режим»): альтернативные/ненационалистические ветки скрываются через `available = { NOT = { has_global_flag = VUP_Hist_version } }` или `if = { limit = { has_global_flag = VUP_Hist_version } always = no }`

**По файлам (кратко):**

- **`afghanistan.txt`** — добавлены фокусы со стоимостью 5/5/10/10; координаты; добавлены ядра/штаты.
- **`australia_taog.txt`** — условие `VUP_Hist_version` на ветку.
- **`baltic_shared.txt`** — `is_subject`-условия переработаны; `any_collection_element`; `any_country_with_original_tag`; добавлены ядра/штаты.
- **`brazil.txt`** (файл добавлен в диапазоне) — пересоздано дерево (8055 строк): стоимости 5/10/3/4, идеи, ПП, оборудование, исслед. слоты.
- **`bulgaria.txt`** — стоимости: было `10,5,5,5,5,5,5,10,10,5` → стало `5,2,2,2,2,2,5,5,2`; убраны идеи; `is_subject`; координаты.
- **`canada.txt`** — стоимости 10→5 (2 фокуса); `add_political_power`; `original_tag`.
- **`china_communist_sea.txt`** — идеи; `any_collection_element`.
- **`denmark.txt`** — переработаны `is_subject`-условия.
- **`estonia.txt`** — `any_collection_element`.
- **`finland.txt`** — `VUP_Hist_version`; `any_collection_element`; `original_tag`.
- **`france.txt`** — стоимости: было `10,5,10,5,5,5,5,5,5,5,5,5` → стало `5,10,5,10,4,3,3,1,3,3,3`; идеи; ПП; `is_subject`; координаты.
- **`free_france.txt`** — стоимости: было `5,5,5,10,5,5,5,5,5,5,10` → стало `2,10,5,1,5,5,5,10,5,5,10,2,2,2,5`; идеи; оборудование; координаты.
- **`germany.txt`** — стоимости: было `10,5,5,5,10,5,5,2,5,2,5,5` → стало `6,3,3,3,5,4,4`; идеи; `is_subject`; координаты.
- **`hungary_wuw.txt`** — `VUP_Hist_version`; `is_subject`; `any_collection_element`.
- **`iceland.txt`** — `is_subject`.
- **`india_goe.txt`** — `VUP_Hist_version`; новый фокус cost 5; идеи; оборудование; координаты.
- **`indonesia.txt`** — стоимости: было `5,5,5,5,5,10` → стало `3,3,3,3,3,5`; `VUP_Hist_version`.
- **`iraq.txt`** — новый фокус cost 5; убраны идеи; `is_subject`; координаты; ядра/штаты.
- **`italy.txt`** — стоимости: было `1,5,1,2,2,2,5,5,10,5` → стало `3,1,3,3,3,10,5`; идеи; оборудование; `is_subject`; координаты.
- **`japan.txt`** — `VUP_Hist_version`; `is_subject`; `any_collection_element`; координаты.
- **`latvia.txt` / `lithuania.txt` / `mexico.txt` / `nordic_shared.txt`** — мелкие правки (координаты, условия).
- **`manchukuo_TSR.txt`** — `is_subject`-условия переработаны.
- **`Mongolia.txt`** — `VUP_Hist_version`; `is_subject`; координаты.
- **`netherlands.txt`** — стоимости массово: было `5,5,10,10,10,...,10` → стало `3,3,5,5,5,...,5` (30 фокусов подешевели); `is_subject`.
- **`norway.txt` / `portugal.txt`** — `any_collection_element`; `original_tag`.
- **`persia.txt` / `philippines.txt`** — `original_tag`; ядра/штаты.
- **`poland.txt`** — `VUP_Hist_version`; новые фокусы cost 10; координаты.
- **`romania.txt`** — стоимости: было `10,5,5,3,10,3,3` → стало `5,3,3,2,5,2,2`; ядра/штаты.
- **`siam.txt`** — новые фокусы cost 5; `is_subject`; координаты.
- **`south_africa.txt`** — стоимости: было `10×8,5` → стало `5×9,2`; координаты.
- **`soviet.txt`** — стоимости: было `10,10,10,10,10,10,5,10,10,10,10,3,10,10,5,5,5,1,1,1,3,5,5,3,3,5,3,3,3,5,5,5,5,5,5,5,5,5,5,10` → стало `1,5,5,3,5,5,2,5,5,5,5,2,5,5,4,1`; `swap_ideas`; идеи; ПП; исслед. слот; `any_collection_element`; координаты; ядра/штаты.
- **`spain.txt`** — `VUP_Hist_version`; `swap_ideas`; `any_collection_element`; координаты.
- **`sweden.txt`** — `VUP_Hist_version`; убраны идеи; `any_collection_element`.
- **`switzerland.txt`** — стоимости 10→5 (2 фокуса).
- **`turkey.txt`** — стоимости: было `10,10` → стало `5,5,10`; координаты.
- **`uk.txt`** — `VUP_Hist_version`; стоимости: было `10,10,10,10,10` → стало `5,8,8,8,8`; `swap_ideas`; идеи; ПП; исслед. слот; `is_subject`; координаты; ядра/штаты.
- **`usa.txt`** — `VUP_Hist_version`; стоимости: 13 фокусов `10→5`; идеи; координаты.
- **`yugoslavia.txt`** — `VUP_Hist_version`; убраны идеи; координаты; ядра/штаты.

**Специальные файлы:**
- **`SNG_shared_branch.txt`** — +2609 строк: добавлена ветка СНГ (50 фокусов, стоимости 2/5/10, идеи, ПП, исслед. слоты, ядра/штаты).
- **`belgium.txt`** (файл добавлен в диапазоне) — удалён в `24d3f32`, пересоздан в `2d78f37` (8793 строк): `VUP_Hist_version`, стоимости 0–10/150, `swap_ideas`, идеи, оборудование, `has_full_control_of_state`, ветка «всё скрыто» через `always = no`.
- **`congo_shared.txt`** (файл добавлен в диапазоне) — удалён в `24d3f32`, пересоздан в `2d78f37` (10382 строк): аналогично Бельгии.
- **`00_vre_cut_focus_stubs.txt`** (файл добавлен в диапазоне) — заглушки «Vanila Reborn edit» для вырезанных фокусов: `country = { factor = 0 }`, `available = { always = no }`, `ai_will_do = { factor = 0 }` — чтобы `has_completed_focus` на вырезанные id не падал с ошибкой.

### 2.2. Решения (`common/decisions/`)

- **`AST.txt`** — вес AI: `factor = 5` → `10`; убран модификатор `is_historical_focus_on = yes → factor = 0`.
- **`BEL.txt`** — `fire_only_once = yes` → `days_re_enable = 180`; добавлен `set_country_flag = sent_eu_invitation_flag` (days=365); `any_country = { is_in_faction_with = ROOT }` заменён.
- **`BRA.txt`** — добавлен блок `BRA_industrial_decisions` (инвестиции в сельские штаты и т.д.).
- **`BUL.txt`** — убраны `remove_core_of`, `start_resistance`, `set_compliance`/`set_resistance` (штат 106).
- **`DEN.txt`** — `any_country = { has_war_with = ROOT }` → `any_enemy_country`.
- **`ENG.txt`** — переименовано/переработано решение `ENG_invoke_the_alliance_of_1373` (иконка `generic_prepare_civil_war` → другая; условия `has_war`/`democratic`).
- **`FRA.txt`** — −1189/+231: добавлен `every_country`-цикл по подданным с `puppet = { target = PREV end_wars = no }`.
- **`GER.txt`** — убрано решение `GER_cancel_mefos` (иконка `ger_mefo_bills`, `base = 0`, `cost = 0`, `fire_only_once = no`).
- **`HOL.txt`** (файл добавлен в диапазоне) — новый блок решений с комментариями `###modded only ai wil do`.
- **`INS.txt`** — добавлены ядра штатов `1061,1062,1064,1023,1024,1059` для INS.
- **`ITA.txt`** — убрано `colonial_government_in_east_africa` (иконка, `fire_only_once`, `has_completed_focus = ITA_ministry_of_italian_africa`).
- **`JAP.txt`** — добавлен `INS = { is_puppet = yes }`; убраны условия по HOL/INS (`has_capitulated`, `NOT has_war_with`).
- **`RAJ_GOE.txt`** — иконка `GFX_decision_SWI_swiss_democratic_tradition_campaign` → `GFX_decision_generic_political_address`; `is_subject = yes`; убран `add_autonomy_ratio = -0.05`.
- **`SOV.txt`** — `any_country = { is_major = yes }` → `any_country_with_original_tag_of = { target = {ENG FRA GER ITA USA JAP} }`.
- **`TUR.txt`** (файл добавлен в диапазоне) — новый блок `political_actions` (6557 строк): `TUR_recall_ataturk_to_active_service` и т.д.
- **`USA.txt`** — `any_neighbor_country = { tag = USB }` → `USB = { is_neighbor_of = ROOT }`.
- **`formable_nation_decisions.txt`** — добавлены `highlight_states` (штаты 47,185,731,184,48...); убран `news_event = wtt_news.59`.
- **`vup_fra_decisions.txt`** — `political_power > 49` → `has_political_power > 49`; добавлен `check_variable war_goal_time` / `add_to_variable`.
- **`vup_ger_decisions.txt`** — очищено решение `GER_stupid_AI`; убраны `GER_HUN_SLO` и пр. (условия `has_country_flag = VUP_Hist_version`).
- **`vup_per_decisions.txt`** — добавлен `add_equipment_to_stockpile = { convoy_1 ×10000 }`; закомментированы `annex_country = { target = BRA/AFG }`.
- **`categories/00_decision_categories.txt`** — добавлена категория `scripted_gui = MTG_naval_treaties_ui`; видимость: `NOT = { original_tag = MAN AND is_ai = yes }`.
- **`categories/ger_operation.txt`** — новая категория `GER_operation` (иконка `military_operation`, `scripted_gui = GER_opmap_ui`).
- **`categories/vup_ger_decision_categories.txt`** — `priority` изменён на 67.
- **`bots.txt`** — исключён (AI-контент: `bot_VUP_Hist_version` и пр.).

### 2.3. Идеи (`common/ideas/`)

- **`_economic.txt`** — `level = 2` → `7`; убраны `is_minor = yes`; добавлен модификатор `original_tag = JAP` + `has_idea = export_focus` + `has_active_mission = JAP_government_faction_demands_trade_law_change` → `factor = 10`; `factor = 300` → `600`; дата резины `1943.1.1` → `1938.8.1`; `date > 1941.6.1` → `1939.1.1`; добавлены `tag = COG/SIA`.
- **`france.txt`** — добавлена идея `FRA_ne_stroit_bazi_mor` («Нельзя строить морские базы»): `industrial_capacity_factory = 0.1` при `has_global_flag = VUP_Hist_version`, `production_speed_naval_base_factor = -5`.
- **`japan.txt`** — `naval_strike_attack/targetting/agility_factor`: `0.12` → `0.15`.
- **`omega_ideas.txt`** — добавлены идеи `debaf_pexa_ideas` («Уязвимость пехоты», `army_infantry_defence_factor = -0.15`), `no_farm_gen` («Не фармим гена») и пр.
- **`usa.txt`** — `specialization_nuclear_speed_factor = 0.05` → `0.1`.
- **`zzz_generic.txt`** — добавлены `on_add`/`on_remove` → `MTG_naval_treaty_sync_ui_membership_effect`.
- **`army_spirits.txt`** (файл добавлен в диапазоне) — +1310 строк: армейские духи (`academy_spirit`, `bold_attack_spirit`, `has_military_academy` и пр.).
- **`bots.txt`** — исключён (AI-контент: `is_ai = yes`).
- **`GER.txt`** — добавлены `available = { always = no }` (скрытые идеи-заглушки).
- **`_manpower.txt`** — `base = 0` + модификатор `add = 100` при `has_completed_focus = SIA_national_savings_bond`.

### 2.4. Технологии (`common/technologies/`)

- **Общий паттерн:** `factor = N` → `base = 0` + `modifier = { add = N ... }` (переход на аддитивные бонусы).
- **`infantry.txt`** — `soft_attack = 0.05` → `0.1`; `factor = 0.7/3/5` → `base = 0` + `add = 3/5`; добавлен модификатор `add = 5, tag = ENG`.
- **`industry.txt`** — `factor = 50/40` → `28`; `15` → `5/0`; `factor = 25/20` → `100`.
- **`support.txt`** — добавлены `xp_research_type = army`, `xp_boost_cost = 50`, `xp_research_bonus = 0.50`; убраны старые `factor`-модификаторы по датам.
- **`MTG_naval_Support.txt`** — `factor` → `base`/`add`; добавлен `original_tag = NOR → add = 100`; даты `1938.1.1`/`1939.1.1`; `original_tag = GER/INS/JAP` перекомментированы.
- **`bba_air_techs.txt`** — массово убраны `ai_will_do`-ханки с `factor = 30000` и перечислением тегов (MAN, ITA, FRA, AFG, ALB, ARG...).
- **`artillery.txt`**, **`electronic_mechanical_engineering.txt`**, **`MTG_naval.txt`** — мелкие правки (`base = 0`, `add`).

### 2.5. Доктрины (`common/doctrines/`)

- **`land_grand_doctrines.txt`** — добавлен `category_army = { breakthrough = 0.15 }`; `out_of_supply_factor = -0.10` → `-0.15`.
- **`combat_support_subdoctrines.txt`** — `max_organisation = 5` → `10`; добавлен `logistics_company = { supply_consumption_factor = -0.05 }`.
- **`operations_subdoctrines.txt`** — добавлен `armored_car_recon` (`battalion_mult`: `category_light_infantry`, `soft_attack = 0.05`, `defense = 0.05`).
- **`land_doctrine_tracks.txt`** — `category_cavalry` добавлен; убраны `category_all_infantry`, `category_line_artillery`, `category_artillery`, `category_tanks`, `category_all_armor`.

### 2.6. События (`events/`)

- **`LAR_occupation.txt`** — был закомментированным no-op (`hidden = yes`, «collaboration governments are cut»); стало: реальное событие `occupied_countries.1` («instantiate a collabration government»).
- **`BBA_Italy.txt`** — `any_country = { is_in_faction_with = ROOT }` → `any_allied_country`; `is_core_of = RDS` (втрое).
- **`BBA_Switzerland.txt`** — добавлены модификаторы `factor = 0` с `SWI_is_historical_ai = yes`.
- **`BFTB_Bulgaria.txt`** — убраны варианты ответов («Refuse» и пр.), `ai_chance` с `factor = 5`.
- **`BFTB_Turkey.txt`** — `has_war_support < 20` → `< 0.2`; `add_offsite_building industrial_complex level = 4` → `3` (ITA).
- **`DOD_Hungary.txt`** — `puppet = CZE` → `puppet = { target = CZE end_wars = no }`; `set_autonomy ... end_wars = no`; добавлены `exists = yes`.
- **`DOD_Romania.txt`** — `any_other_country = { is_major = yes }` → `any_collection_element = { collection = game:all_majors }`.
- **`Germany.txt`** — `any_other_country` → прямая проверка `96 = { owner = { ... } }` (штат 96); убран `owns_state`.
- **`GOE_Raj.txt`** — добавлен `custom_effect_tooltip = generic_skip_one_line_tt`; новое событие `GOE_RAJ.52` (Mountbatten).
- **`MTG_Britain.txt`** — `remove_from_tech_sharing_group = commonwealth_research` переставлен/добавлен; убраны дубли `country_event = GOE_RAJ.30`.
- **`NSB_Poland.txt`** — `any_other_country = { is_major = yes }` → `any_collection_element = { collection = game:all_majors NOT = { tag = ROOT } }`.
- **`USA.txt`** — убран `random_list` с `USA_congress_investment`-модификатором.
- **`WTT_NewsEvents.txt`** — `any_country = { has_war_with = ROOT }` → `any_enemy_country`.
- **`WWU_Germany.txt`** — `any_country = { original_tag = USA }` → `any_country_with_original_tag = { original_tag_to_check = USA }`.
- **`SEA_Nat_China.txt`** — добавлено событие `SEA_china.30` (скрытый диспетчер: запрос на снятие «девяти держав»).
- **`TOA_Generic_Events.txt`** — добавлено условие `has_start_date < 1939.01.01`.
- **`AAT_Finland.txt`**, **`Finland.txt`**, **`France.txt`**, **`SEA_Japan.txt`**, **`omega_events.txt`** — существовали до диапазона; в диапазоне получили правки (см. коммиты `a7a0e71`, `24f19dd` и др.).

### 2.7. История (`history/`)

- **`countries/ENG - Britain.txt`** — design_team: `mio:ENG_cammell_laird_organization` / `mio:ENG_harland_wolff_organization` → `mio:ENG_yarrow_shipbuilders_organization`.
- **`countries/FRA - France.txt`** — +84 строк: динамические модификаторы `FRA_fabriki` (days=1322) по штатам 29, 785 и т.д.
- **`countries/GER - Germany.txt`** — `set_research_slots = 5`; `set_global_flag = VUP_Hist_version`; `photo_reconnaisance = 1` вынесен на уровень выше.
- **`countries/HON - Honduras.txt`** — закомментированы `air_superiority`, `mass_assault`, `pocket_defence`, `defence_in_depth`.
- **`countries/IRE - Ireland.txt`** — убраны `air_superiority`, `grand_battle_plan`, `trench_warfare`, `fleet_in_being`, `battlefleet_concentration`.
- **`countries/ITA - Italy.txt`** — закомментирован блок `1936.1.1.13 add_ideas = { no_farm_gen }`.
- **`countries/JAP - Japan.txt`** — добавлены идеи `JAP_1936_fake_state_shintoism_idea`, `JAP_1936_fake_industrial_idea`; убраны другие.
- **`countries/ROM - Romania.txt`** — добавлен `complete_national_focus = ROM_crack_down_on_extremism`.
- **`countries/SOV - Soviet union.txt`** — +202 строк: флаги персонажей (`SOV_bronislav_kaminski`, `SOV_konstantin_voskoboinik` → `set_character_flag`).
- **`countries/USA - USA.txt`** — убран блок `1939.1.1` (`add_political_power = 1199`, `add_command_power = 100`, министры).
- **`general/generic_advisors.txt`** — существовал до; в диапазоне правки (см. `bb84b0f`, `a7a0e71`).
- **`states/`** — Австралия: удалены штаты 1074, 870, 871, 873 (в диапазоне — только M/D у оставшихся); Эстония: `3174 1 Voru` → `3174 3 Parnu`; `9221 1` → `9221 3 #Tartu`; Великобритания: закомментированы `dockyard` (119-Northern Ireland, 132-North-west England, 133-Strathclyde, 136-Aberdeenshire); Афганистан 267: `air_base = 1`; Бомбей 429: `victory_points` переструктурированы (+12269 Janjira); Arunachal Pradesh 434: VP `1116 1` → `2`, +`10810 1 Nyingchi`; East Africa 544: `manpower 1226000` → `1604000`; Jiansu 598 / China 6 606 / China 7 607: добавлен `add_dynamic_modifier = yellow_river_blown` (days=300); China 1 601: переписаны ресурсы; Manica e Sofala 896: `manpower 188600` → `831900`; Zambezia-Mocambique 897: `1386000` → `1812000`; Slovakia 70 / Czechoslovakia 9: переструктурированы лендмарки (`landmark_prague_castle`, `landmark_bojnice_castle`); Madras States 982: `aluminium = 4`.
- **`units/`** — `unlock_marines/motorized/mountineers/paratroopers/rangers/tanks/tanks_mot`: `artillery = 1` → `artillery = { x = 0 y = 0 }` + `field_guns = { x = 0 y = 2 }`; позиции `marine/infantry/ranger_battalion/mountaineers` переставлены; `FRA_1936.txt` +1 строка; `GER_1936_nsb.txt` убран `industrial_manufacturer = mio:GER_henschel_kassel_organization`; `USA_1936_naval_mtg.txt` убраны 2× `mio:USA_newport_news_shipbuilding_organization`.

### 2.8. Персонажи и черты (`common/characters/`, `common/country_leader/`, `common/unit_leader/`)

- **`characters/FRA.txt`** — `has_completed_focus = FRA_aggressive_focus` → `has_country_flag = FRA_aggressive_focus` (так же `FRA_defensive_focus`).
- **`characters/GER.txt`** — добавлен портрет `GFX_portrait_ger_wilhelm_iii_small`; трейты `winter_specialist` → `old_guard`; `skill = 4` / `attack_skill = 5` / `defense_skill = 3` убраны/переписаны.
- **`characters/JAP.txt`** — `has_active_mission = JAP_army_faction_demands_military_factories` → `JAP_army_faction_demands_political_appointment` (×3).
- **`country_leader/00_traits.txt`** — `sprite = 10` → `13` (частично), добавлены `sprite = 10`.
- **`unit_leader/00_traits.txt`** — `type = { land }` → `{ land navy }`; добавлен `CHI_watched_officer` (personality_trait, `new_commander_weight`).
- **`unit_leader/NSB_traits.txt`** — добавлен `communist_sympathizer` (`type = all`, `trait_type = personality_trait`, `gain_xp = { always = no }`).

### 2.9. Прочее (`common/` и `map/`)

- **`defines.lua`** — см. отдельный блок ниже (2.10).
- **`military_industrial_organization/organizations/ENG_organization.txt`** — добавлены теги `HON, IRE, CUB` (×2).
- **`.../FRA_organization.txt`** — добавлены `HON, IRE, CUB`; убрано `allowed = { tag = FRA has_dlc = "Arms Against Tyranny" }`.
- **`.../SOV_organization.txt`** — `include = generic_naval_aircraft_organization` → `generic_medium_aircraft_organization`.
- **`occupation_laws/occupation_laws.txt`** — переработаны модификаторы (−113/+152): убраны `FROM = { has_government = democratic }`, `has_active_resistance = no`, `add = 200`.
- **`intelligence_agency_upgrades/intelligence_agency_upgrades.txt`** — `factor = 2` → `10`; добавлен модификатор `factor = 5` при `original_tag = GER` и пр.
- **`autonomous_states/wtt_imperial_protectorate.txt`** — `cic_to_overlord_factor`/`mic_to_overlord_factor`: `0.9` → `0.95`.
- **`units/equipment/tank_chassis.txt`** — добавлены `scaled_by_reliability = { max_strength = 0.5 }`, `module_add_stats_multiplier = { soft_attack = -0.05 hard_attack = -0.05 }`.
- **`units/infantry.txt`** — `support_equipment = 10` → `5`; `max_strength = 25` → `27.5`; `soft_attack = 0.1` закомментирован.
- **`countries/cosmetic.txt`** — добавлен `samanid_empire_tag` (цвет `rgb { 0 165 114 }`).
- **`scripted_effects/00_scripted_effects.txt`** — добавлен `MTG_naval_treaty_mark_over_allowance_effect` (бейдж-флаг панели сигнатариев).
- **`scripted_triggers/omega_diplomacy_triggers.txt`** — «Оправдание на ИИ с 1937» → «с июня 1938» (`date > 1937.1.1` → `1938.6.1`); добавлены условия `VUP_Hist_version`, `is_ai = no`; переработаны географические проверки (Азия/Южная Америка/Австралия).
- **`dynamic_modifiers/FRA_import_dynamic_modifiers.txt`** — убран `production_speed_naval_base_factor = -1`; добавлен `sov_fabriki` («Индустриализация», `local_building_slots_factor = 0.40`).
- **`map/adjacencies.csv`** — убраны 3 «impassable»-связи Гибралтара (`13228;4135`, `10094;4135`, `7153;4135`).
- **`map/buildings.txt`** — переставлены координаты зданий на карте (`naval_base_spawn`, `coastal_bunker`, `bunker`); добавлены новые позиции `supply_node`, `special_project_facility_spawn`, `naval_supply_hub` (штаты 552, 1018, 1019, 528, 533, 1020 и т.д.).
- **`common/ai_equipment/generic_planes.txt`** — исключён (AI-контент).

### 2.10. `common/defines/defines.lua` (19 касаний)

- `DAYS_BETWEEN_CHECK_BEST_TEMPLATE`: `30` → `7` (ИИ чаще считает шаблоны).
- `FIELD_MARSHAL_DIVISIONS_CAP = 30`, `CORPS_COMMANDER_DIVISIONS_CAP = 30` — добавлены.
- `MAX_ARMY/NAVY/AIR_EXPERIENCE`: `999` → `9999`.
- `SPECIAL_FORCES_CAP_MIN`: `168` → `196`.
- `STOP_TRAINING_FULLY_TRAINED_FACTOR`: `1` → `0.95`; `MAX_FULLY_TRAINED_SHIP_RATIO_FOR_TRAINING`: `1` → `0.95`.
- Добавлены `DEPLOYED_UNIT_MANPOWER_RATIO_TO_BUFFER_WARTIME = 0.4`, `..._PEACETIME = 0.2`.
- Добавлены `RESEARCH_AHEAD_OF_TIME_FACTOR = 10`, `MAX_AHEAD_RESEARCH_PENALTY = 10`.
- `WANTED_UNITS_MAX_WANTED_CAP`: `9999` → `999999999999`.
- Добавлены `PEACE_BID_FOLD_TURNS_AGAINST_OTHER_AI = 3`, `PEACE_BID_FOLD_AGAINST_PLAYER_CHANCE = 0`.
- `CONSTRUCTION_PRIO_INFRASTRUCTURE`: `1` → `2`; `CONSTRUCTION_PRIO_SUPPLY_BUILDING`: `5` → ... (в vanilla-значения 0.20/1.10); добавлен полный блок приоритетов строительства (`CIV_FACTORY 0.80`, `MIL_FACTORY 0.70`, `RAILWAY 4.00`, `RAILWAY_GUN_REPAIR 15.00`, `UNSPECIFIED 0.50`, факторы `OCCUPIED_TERRITORY 1.00`, `OWNED_NONCORE 1.50`, `OWNED_CORE 2.00`, `REPAIRING 0.30`).
- `AIR_WING_ATTACK_LOGISTICS_NO_TRUCK_DISRUPTION_FACTOR = 0.1` (ваниль 0.2); `AIR_WING_ATTACK_LOGISTICS_TRUCK_DAMAGE_FACTOR = 0.2` (ваниль 0.5).

### 2.11. Интерфейс (`interface/`)

- **`frontendmainview.gui`** — добавлен контейнер `owned_dlc_item` (кнопка `dlc_button`, `GFX_frontend_banner_dlc018`, `owned_tick`, `GFX_BPT_area_defense_setting_tick`).
- **`ingamemenu.gui`** — размер `320×475` → `320×435`; добавлены скрытые кнопки `homepage_button`, `privacy_policy_button`; контейнер `second_row`.
- **`topbar.gui`** — добавлен `national_focus_shortcut` (кнопка за экраном `x=-9000 y=-9000`, `GFX_shield_medium`).
- **`operativeleader.gui`** — добавлен `operative_target_flag` (`GFX_flag_small`, scale 0.7).
- **`goals_shine.gfx`** — `goal_generic_construct_military.dds` → `goal_generic_construct_mil_factory.dds` (×3).
- **`airselectionview.gui`**, **`battleplantools.gui`** — удалены (см. п.1).

### 2.12. Локализация (`localisation/`)

- **`russian/omega_l_russian.yml`** — +475: новые ключи (`FRA_fabriki` «Запрет на стройку в мейне», `Kefir_delat_plaki_plaki` «Не надо пушить герму с границ :)», `COL_neutral_game` «Нейтральные страны», `GER_yug_capcap` «Судьба Югославии», `sov_fabriki` «Индустриализация», **`VUP_Hist_version` «Исторический режим»**, `no_farm_gen` «Не фармим гена» и пр.).
- **`russian/WUW_decisions_l_russian.yml`** — +19: `BEL_invest_in_member_industry_decision` «Инвестировать в [FROM.GetAdjRuLower]ую промышленность», `BEL_proclaim_the_european_federation` «Провозгласить Европейскую Федерацию», `more_likely_to_accept_federalization_tt` переписан.
- **`russian/bba_focus_l_russian.yml`** — мелкая правка `ITA_peace_preservation_ns_tt`.
- **`russian/loading_tips_l_russian.yml`** — существовал до; в диапазоне +323 (цитаты Муссолини, Монтгомери, Петра I и пр.).
- **`russian/victory_points_l_russian.yml`** — удалён (2140 строк).
- **`horsttool_l_english.yml` / `horsttool_l_russian.yml`** — удалены (были в `localisation/` корне); в `localisation/english|russian/` — переписаны (`horsttool` — GM-инструмент).
- **`replace/missing_tech_l_english.yml`** — удалён (3 строки).

---

## 3. Сводная таблица коммитов (58)

| Коммит | Сообщение | Суть (по M/D-файлам) |
|---|---|---|
| `36f3de3` | 35 | Мелкие правки (ai_strategy/hist — AI, исключено) |
| `365634d` | 36 | more_unit_levels локализация (новый файл) |
| `43eefb2` | 37 | Мелкие правки |
| `5ad6b84` | 38 | — |
| `493907e` | 39 | Правки фокусов/решений |
| `a02cd2e` | 37 | ai_navy NOR (AI, исключено) |
| `279ecbe` | 94(фикс опыта) | Исправление опыта |
| `c094612` | 95 | Правки |
| `20c0f69` | save | Сохранение |
| `6a1301e` | 96(обновил папку юнит) | Удалён `00_tank_modules.txt`; правки `tank_chassis.txt`, `infantry.txt`, `spain.txt` |
| `1a3e063` | 40 | Правки |
| `c3723bb` | merge main | merge (исключён) |
| `96052f5` | 41 | ai_strategy production_air (AI) |
| `8f2aa83` | 42 | Правки |
| `24d3f32` | половина | Удалены `belgium.txt`, `congo_shared.txt` фокусы; массовые правки decisions/ideas/doctrines |
| `1876c98` | 43 | Правки |
| `f340d70` | 43 | Правки |
| `98b3586` | 44 | Правки |
| `296d28b` | 97 мини патч | `FRA_import_dynamic_modifiers`, `ideas/france`, `omega_ideas`, `Mongolia`, `SNG_shared_branch`, `belgium` (файл добавлен) |
| `d0a7bf1` | 45 | ai_templates GER_JAP (AI) |
| `b4be440` | мега патч 98 | Мелкий хотфикс |
| `54a044a` | 46 | ai_navy NOR (AI) |
| `fb94415` | 47 | Правки |
| `a7a0e71` | обнова | Массовая правка фокусов (germany 922, italy 1236, hungary 785...); удалены `BEL` history, `victory_points` loc, `battleplantools.gui`, `cant_ins_cap` |
| `a124f9b` | Update germany.txt | Правка germany.txt |
| `672eb40` | фикс | Правки |
| `3374f9b` | 48 | Правки |
| `e1cf51a` | фиксы | Правки фокусов (france, netherlands, soviet, switzerland, uk, usa...); `LAR_occupation` |
| `a93785f` | Update soviet.txt | Правка soviet.txt |
| `a571c55` | 98 | Удалён `TIB.txt`; правки `generic.txt` (новый), фокусов |
| `0aba95d` | 49 | Правки |
| `4d387e1` | 99 | Правки |
| `ea7e4c2` | 50 | `army_spirits.txt` (новый), `HOL.txt` (новый), правки ideas; ai_strategy GER (AI) |
| `26fed1f` | 100(ультра мега хист) | Удалены `TS_volunteers_*` (opinion_modifiers, diplomatic_actions) |
| `b63d28d` | 51 | Правки |
| `7a8f1b7` | 101 | `gaid_hist`/`gaid_nonhist`/`vup_gaid` (новые, AI-категории) |
| `6612b2f` | italy hist fix | История Италии |
| `2d78f37` | 102 | Пересозданы `belgium.txt`, `congo_shared.txt` фокусы |
| `eb1fc00` | 52 | Правки |
| `0b8fcea` | 53 | ai_faction_theaters (AI); правки |
| `b586060` | 54 | `TUR.txt` decisions (новый, 6557 строк) |
| `77d61b6` | 103 | Удалён `diplomacy_scripted_triggers.txt`; `omega_diplomacy_triggers` +988; `omega_events` +1868; defines; фокусы; `map/adjacencies.csv` |
| `e6faafa` | 103 конец сисикала | `core_l_russian.yml` (новый) |
| `2e1f8db` | 55 | Правки |
| `1e6cd8c` | 104 | Удалены `characters/ITA.txt`, `characters/SOV.txt`; правки `GER.txt`, `unit_leader/00_traits.txt`, history GER/ITA/SOV |
| `a9daca9` | 1 | Удаление 78 строк |
| `6b4365f` | 105 | Правки |
| `e9fff16` | хот фикс 2 | Мелкий хотфикс |
| `818e094` | 106 | Правки |
| `f89452a` | 107 | — |
| `24f19dd` | 56 | Правки (ideas/bots — AI; omega_events) |
| `f16c306` | 57 | Правки |
| `6d65089` | 57 | Правки |
| `4ad5fb1` | 58 | ai_strategy production (AI); `bots_start`, `bots_swap` (AI) |
| `a69b46c` | 59 | Правки |
| `67e6cba` | 60 | ai_bonus_weights (AI) |
| `40bd945` | 61 | Правки |
| `e8240f9` | fix | Финальный фикс |

---

*Отчёт сформирован по диапазону `063d9b6..HEAD` (58 non-merge коммитов). AI-контент исключён по правилам. Создание новых файлов не описывается; их последующие модификации помечены «(файл добавлен в диапазоне)».*
