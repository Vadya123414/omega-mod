--Оптимизация
NDefines.NGame.GAME_SPEED_SECONDS = { 1000.0, 0.19, 0.12, 0.07, 0.0 }; -- СКОРОСТЬ 4 РАВНА 0.1 В ВАНИЛЛЕ  Игровые скорости для каждого уровня. Должно быть 5 записей, последняя — 0 для неограниченной скорости.]
NDefines.NGame.LAG_DAYS_FOR_LOWER_SPEED = 60;
NDefines.NGame.LAG_DAYS_FOR_PAUSE = 100;
NDefines_Graphics.NGraphics.CAPITAL_ICON_CUTOFF = 800						-- 1100 
NDefines_Graphics.NGraphics.DRAW_MAP_OBJECTS_CUTOFF = 250 					-- 550 
NDefines_Graphics.NGraphics.MAP_BUILDINGS_SHRINK_DISTANCE = 100				-- 180
NDefines.NCountry.INTERPOLATED_FRONT_STEPS_SHORT = 1					-- Чтобы линия фронта у ИИ не отрисовывалась красиво, на ум бота это не повлияет, просто визуал
NDefines.NNavy.CONVOY_LOSS_HISTORY_TIMEOUT_MONTHS = 3 -- 24. Ограничивает историю потерь конвоев тремя месяцами вместо двух лет.
NDefines.NNavy.NAVAL_COMBAT_RESULT_TIMEOUT_YEARS = 0.25 -- 2 . (0.25 года = 3 месяца) Очищает всплывающие окна морских сражений спустя 3 месяца (0.25 года) вместо 2 лет.
NDefines.NResistance.GARRISON_LOG_MAX_MONTHS = 3 --  12. Сокращает время хранения истории потерь в гарнизонах с одного года до 3 месяцев
NDefines.NMilitary.GENERATE_AI_DIV_COMMAND_HISTORY_ENTRIES = false -- Полностью отключает запись истории приказов и маршрутов перемещения для всех дивизий ИИ.
NDefines.NAir.BOMBERS_DIVISION_FACTOR = 200 -- По умолчанию 30. Чтобы меньше летало 3D-моделек самолётов, то есть чтобы не лагало в лейте, когда авиации до жопы
NDefines.NAir.FIGHTERS_DIVISION_FACTOR = 200 -- По умолчанию 30. Чтобы меньше летало 3D-моделек самолётов, то есть чтобы не лагало в лейте, когда авиации до жопы
NDefines.NAir.MISSILES_DIVISION_FACTOR = 200 -- По умолчанию 60. Чтобы меньше летало 3D-моделек самолётов, то есть чтобы не лагало в лейте, когда авиации до жопы
NDefines.NAir.TRANSPORT_DIVISION_FACTOR = 200 -- По умолчанию 30. Чтобы меньше летало 3D-моделек самолётов, то есть чтобы не лагало в лейте, когда авиации до жопы
NDefines.NNavy.NAVAL_ACCIDENTS_DAYS_TO_LIVE = 30 -- По умолчанию 120. Снижение лога аварий
NDefines.NAI.DAYS_BETWEEN_CHECK_BEST_EQUIPMENT = 30 -- По умолчанию 7. Думают дольше, например апнуть ли шаблон
NDefines.NAI.UPGRADE_DIVISION_RELUCTANCE = 14 -- По умолчанию 7. Думают дольше, например апнуть ли шаблон
NDefines.NAI.DAYS_BETWEEN_CHECK_BEST_TEMPLATE = 30 -- По умолчанию 7. ИИ реже рассчитывает дизайн шаблонов.
NDefines.NDiplomacy.DIPLOMACY_HOURS_BETWEEN_REQUESTS = 96 -- По умолчанию 24. Оценка дипломатии и торговли для ИИ ограничена частотой раз в 4 дня. ИИ реже отправляет дипломатические запросы.
NDefines.NAI.REMOVE_OBSOLETE_TEMPLATE_DAYS = 90 -- По умолчанию 180. ИИ быстрее очищает пустые неиспользуемые шаблоны, чтобы сэкономить оперативную память.
NDefines.NAI.DAYS_BETWEEN_CHECK_BEST_DOCTRINE = 90 -- По умолчанию 30. ИИ реже проверяет наличие улучшений доктрины.
NDefines.NAI.RESEARCH_DAYS_BETWEEN_WEIGHT_UPDATE = 20 -- По умолчанию 7. Выбирает теху дольше 

--Армия
--NDefines.NMilitary.FIELD_MARSHAL_DIVISIONS_CAP = 72;
--NDefines.NMilitary.CORPS_COMMANDER_DIVISIONS_CAP = 72;
--NDefines.NMilitary.BASE_DIVISION_BRIGADE_GROUP_COST = 1;
--NDefines.NMilitary.BASE_DIVISION_BRIGADE_CHANGE_COST = 1;
--NDefines.NMilitary.BASE_DIVISION_SUPPORT_SLOT_COST = 1;
--NDefines.NMilitary.ANTI_AIR_TARGETTING_TO_CHANCE = 0.02;              --  Шанс попадания ПВО по штурму
--NDefines.NMilitary.MIN_DIVISION_BRIGADE_HEIGHT = 5;	-- Анлок 5 ячейки в столбце шаблона дивизии 
NDefines.NMilitary.UNIT_LEADER_MODIFIER_COOLDOWN_ON_GROUP_CHANGE = 0 -- Скорость перевода генерала в другую армию
NDefines.NMilitary.UNIT_LEADER_ASSIGN_TRAIT_COST = 0 -- Cтоимость трейтов генералов
NDefines.NMilitary.MAX_ARMY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_NAVY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_AIR_EXPERIENCE  = 999;
NDefines.NMilitary.ENCIRCLED_DISBAND_MANPOWER_FACTOR = 0;  --  Какая часть людских ресурсов возвращается в ваш общий пул при ручном расформировании подразделения, находящегося в окружении.
-- NDefines.NMilitary.COHESION_IMMOBILE_PLANNING_SPEED_MULTIPLIER = 1.0;	-- Скоростью накопления бонусов планирования для неподвижных дивок
-- NDefines.NMilitary.PLANNING_CAP_COMMS_SCALING = { 1.0, 1.0, 1.0, 1.0, 1.0 };		-- Значение по индексу J — это масштаб, применяемый к лимиту планирования, когда штаб находится на J провинций позади линии фронта
-- NDefines.NMilitary.PLANNING_CAP_NO_HQ_SCALING = 1.0;								-- Масштаб, применяемый к лимиту планирования при отсутствии штаба (нет лидера, лидер не развернут или не тот же корневой приказ)
-- NDefines.NMilitary.PLANNING_SPEED_COMMS_SCALING = { 1.0, 1.0, 1.0, 1.0, 1.0 };		-- То же, что и PLANNING_CAP_COMMS_SCALING, но для скорости планирования
-- NDefines.NMilitary.PLANNING_SPEED_NO_HQ_SCALING = 1.0;								-- То же, что и PLANNING_CAP_NO_HQ_SCALING, но для скорости планирования
NDefines.NMilitary.DEPLOY_TRAINING_MAX_LEVEL = 2; -- Левел во время развёртки
--NDefines.NMilitary.LEADER_MOD_COMMS_SCALING = { 1.06, 1.04, 1.02, 1.01, 1.0 };		-- То же, что и PLANNING_CAP_COMMS_SCALING, но для модификаторов лидера
--NDefines.NMilitary.LEADER_MOD_NO_HQ_SCALING = 1.0;									-- То же, что и PLANNING_CAP_NO_HQ_SCALING, но для модификаторов лидера
--NDefines.NMilitary.ABILITY_COMMS_SCALING = { 1.06, 1.04, 1.02, 1.01, 1.0 };			-- То же, что и PLANNING_CAP_COMMS_SCALING, но для активных способностей
--NDefines.NMilitary.ABILITY_NO_HQ_SCALING = 1.0;									-- То же, что и PLANNING_CAP_NO_HQ_SCALING, но для активных способностей
--NDefines.NMilitary.PREFERRED_PRISON_VP = 5;	-- При захвате генерала пытаться найти провинцию как минимум с таким количеством победных очков (VP), чтобы посадить его в тюрьму. Фактическое VP тюрьмы может быть ниже, если у захватившей страны нет провинций с таким количеством VP
NDefines.NCountry.SPECIAL_FORCES_CAP_MIN = 168 --24 лимит спец войск
NDefines.NCountry.REINFORCEMENT_MANPOWER_DELIVERY_SPEED = 100000.0 --Модификатор скорости доставки подкрепления для армии (время в пути)

--Флот
NDefines.NNavy.MAX_ORG_ON_MANUAL_MOVE = 1.0; -- Орга когда двигаешь флот
NDefines.NNavy.PRIDE_OF_THE_FLEET_UNASSIGN_COST = 0;      --100	-- Стоимость снятие гордости флота
NDefines.NNavy.TRAINING_ACCIDENT_CHANCES = 0.00 -- Случайная поломка во время тренировки
NDefines.NNavy.NAVAL_MINES_IN_REGION_MAX = 0.0-- Кол-во мин в рег
NDefines.NNavy.NAVAL_MINES_PLANTING_SPEED_MULT = 0	-- Скорость минирования
NDefines.NNavy.INITIAL_ALLOWED_DOCKYARD_RATIO_FOR_REPAIRS = 1.0
NDefines.NNavy.NAVAL_MINES_ACCIDENT_CRITICAL_HIT_CHANCES = 0;    -- Шанс крита мин
NDefines.NNavy.NAVAL_MINES_ACCIDENT_CRITICAL_HIT_DAMAGE_SCALE = 0;   -- Урон крита мин
NDefines.NNavy.NAVAL_MINES_ACCIDENT_STRENGTH_LOSS = 0;      -- Урон мин по прочности
NDefines.NNavy.NAVAL_MINES_ACCIDENT_ORG_LOSS_FACTOR = 0;	--Урон мин по орге
NDefines.NNavy.TRAINING_ORG = 0.9; --0.2;   -- Максимальная организация при обучении

--Производство
NDefines.NProduction.CAPITAL_SHIP_MAX_NAV_FACTORIES_PER_LINE = 10;
NDefines.NProduction.MIN_POSSIBLE_TRAINING_MANPOWER = 10000000;
NDefines.NProduction.RAILWAY_GUN_MAX_MIL_FACTORIES_PER_LINE = 10;
NDefines.NProduction.MAX_MIL_FACTORIES_PER_LINE = 300;
NDefines.NProduction.SHIP_REFIT_MAX_PROGRESS_TO_CANCEL = 0.99;
NDefines.NProduction.CONVOY_MAX_NAV_FACTORIES_PER_LINE = 300
--NDefines.NProduction.EQUIPMENT_MODULE_ADD_XP_COST = 0.0            -- Стоимость опыта для добавления нового модуля оборудования в пустой слот при создании варианта оборудования.
--NDefines.NProduction.EQUIPMENT_MODULE_REPLACE_XP_COST = 0.0        -- Стоимость опыта для замены одного модуля оборудования на несвязанный модуль при создании варианта оборудования.
--NDefines.NProduction.EQUIPMENT_MODULE_CONVERT_XP_COST = 0.0        -- Стоимость опыта для преобразования одного модуля оборудования в связанный модуль при создании варианта оборудования.
--NDefines.NProduction.EQUIPMENT_MODULE_REMOVE_XP_COST = 0.0         -- Стоимость опыта для удаления модуля оборудования и оставления слота пустым при создании варианта оборудования.
NDefines.NProduction.BASE_LICENSE_IC_COST = 0;
NDefines.NProduction.LICENSE_IC_COST_YEAR_INCREASE = 0;
NDefines.NProduction.MIN_LICENSE_ACTIVE_DAYS = 1 

---AI 
NDefines.NAI.DIPLOMACY_ACCEPT_ATTACHE_BASE = 100
NDefines.NAI.DIPLOMACY_ACCEPT_ATTACHE_OPINION_TRASHHOLD = 0
NDefines.NAI.DIPLOMACY_ACCEPT_ATTACHE_OPINION_PENALTY = 0
NDefines.NAI.GIVE_STATE_CONTROL_MIN_CONTROLLED = 0
NDefines.NAI.GIVE_STATE_CONTROL_MIN_CONTROL_DIFF = 0

NDefines.NAI.START_TRAINING_EQUIPMENT_LEVEL = 0.9               -- ИИ не начнет тренировку, если уровень оснащения упадет ниже этого значения
NDefines.NAI.STOP_TRAINING_EQUIPMENT_LEVEL = 0.85               -- ИИ прекратит тренировку, если уровень оснащения упадет ниже этого значения
NDefines.NAI.START_TRAINING_SUPPLY_LEVEL = 0.75                -- ИИ не начнет тренировку, если уровень снабжения упадет ниже этого значения
NDefines.NAI.STOP_TRAINING_SUPPLY_LEVEL = 0.65                   -- ИИ прекратит тренировку, если уровень снабжения упадет ниже этого значения
NDefines.NAI.STOP_TRAINING_FULLY_TRAINED_FACTOR = 1           -- ИИ прекратит тренировку, если как минимум такая доля дивизий в армии полностью обучена
NDefines.NAI.STOP_TRAINING_ACTIVE_COMBAT_RATIO = 0.05            -- ИИ останавливает все тренировки, когда более чем такая доля его дивизий находится в активном бою (вместо этого идет пополнение)
NDefines.NAI.HOURS_BETWEEN_ENCIRCLEMENT_DISCOVERY = 16 -- Для каждой армии: интервал в часах между обновлением списка провинций, которые могут стать точками окружения
NDefines.NAI.MAX_FULLY_TRAINED_SHIP_RATIO_FOR_TRAINING = 1 	-- ИИ не будет тренировать оперативное соединение, если доля полностью обученных кораблей выше этого значения
NDefines.NAI.AI_MAX_TASKFORCES_PER_TRAINING_OBJECTIVE = 999 --Максимальное кол-во заданий обучений для ИИ
NDefines.NAI.AI_TASKFORCE_REQUIRED_RESERVE_RATIO = 0.0
NDefines.NAI.MAX_THREAT_FOR_FIRST_YEAR_CIVILIAN_MODE = 0 -- К скольким цивилкам ботики будут стремиться в 36 году, кратно увеличивает вес цивилок
NDefines.NAI.EQUIPMENT_MARKET_BASE_MARKET_RATIO = 0.0
NDefines.NAI.EQUIPMENT_MARKET_SHORTAGE_DAYS_TO_CANCEL = 7
NDefines.NAI.EQUIPMENT_MARKET_MAX_CIVS_FOR_PURCHASES_RATIO = 0.0

-- Расчет желаемого количества дивизий
	NDefines.NAI.WANTED_UNITS_INDUSTRY_FACTOR = 5.00                        -- То, сколько подразделений хочет страна, частично зависит от объема доступной военной промышленности
	--NDefines.NAI.WANTED_UNITS_THREAT_BASE = 10                             -- Если угрозы нет, умножить минимальное желаемое количество подразделений на это значение
	--NDefines.NAI.WANTED_UNITS_THREAT_MAX = 10                            -- Нормированная угроза ограничивается этим значением
	--NDefines.NAI.WANTED_UNITS_WAR_THREAT_FACTOR = 10                       -- Множитель угрозы на это значение, если страна находится в состоянии войны. Это значение перекрывается значением в базе данных идеологий, если то значение превышает данное.
	--NDefines.NAI.WANTED_UNITS_DANGEROUS_NEIGHBOR_FACTOR = 10              -- Множитель, если есть опасный сосед
	--NDefines.NAI.WANTED_UNITS_MANPOWER_DIVISOR = 21000                     -- Нормирующий делитель для людских ресурсов ИИ. (на каждые x единиц максимальных доступных людских ресурсов они хотят одну дивизию)
	--NDefines.NAI.WANTED_UNITS_WEIGHT_FRONTS_WANT = 1                     -- Вес потребностей фронта при расчете конечного желаемого количества подразделений
	--NDefines.NAI.WANTED_UNITS_WEIGHT_FACTORIES = 1                        -- Вес военных заводов при расчете конечного желаемого количества подразделений
	--NDefines.NAI.WANTED_UNITS_WEIGHT_MANPOWER = 1                         -- Вес доступности людских ресурсов при расчете конечного желаемого количества подразделений
	--NDefines.NAI.WANTED_UNITS_MIN_DEFENCE_FACTOR = 1						-- Множитель для подразделений, необходимых для минимальной обороны
	-- Конец расчета желаемого количества дивизий


NDefines.NAI.WANTED_UNITS_MAX_WANTED_CAP = 9999							-- Максимальное желаемое количество дивизий для страны. Может превышаться определенными хардкодными множителями, но не базовой логикой расчета.
NDefines.NAI.LOW_PRIO_TEMPLATE_BONUS_FOR_GARRISONS = 300000  -- в ванилле 1000 | Бонус, делающий ИИ более склонным назначать подразделения с низким приоритетом в гарнизоны
NDefines.NAI.LOW_PRIO_TEMPLATE_PENALTY_FOR_FRONTS = -2000  -- в ванилле 500 | Штраф, делающий ИИ менее склонным назначать подразделения с низким приоритетом на фронты


NDefines.NAI.WANTED_LAND_PLANES_PER_BASE_CAPACITY_FACTOR = 10	-- Масштабирует количество самолетов наземного базирования, которое хочет ИИ, на единицу вместимости авиабазы (исключая авианосцы).
NDefines.NAI.WANTED_LAND_PLANES_PER_DIVISION = 40				-- Сколько самолетов наземного базирования хочет ИИ на каждую желаемую дивизию.
NDefines.NAI.WANTED_LAND_PLANES_TOTAL_MAX_PER_DIVISION = 180	-- Максимальное общее количество самолетов наземного базирования, которое хочет ИИ.

NDefines.NAI.RAILWAY_GUN_PRODUCTION_BASE_DIVISIONS_RATIO_PERCENT = 5  -- в ванилле 0 | Базовое соотношение желаемых железнодорожных орудий к дивизиям для ИИ (5 означает 5%). Может быть изменено значением ИИ-стратегии railway_guns_divisions_ratio
NDefines.NAI.RAILWAY_GUN_PRODUCTION_MIN_DIVISONS = 50  -- в ванилле 20 | Минимальное необходимое количество дивизий, чтобы ИИ задумался о производстве железнодорожных орудий
NDefines.NAI.RAILWAY_GUN_PRODUCTION_MIN_FACTORIES = 40  -- в ванилле 10 | Минимальное необходимое количество военных заводов, чтобы ИИ задумался о производстве железнодорожных орудий

NDefines.NAI.PRODUCTION_EQUIPMENT_SURPLUS_FACTOR = 0.25  -- в ванилле 0.8 | Базовое значение того, какую долю от используемого в данный момент снаряжения ИИ будет как минимум стремиться иметь на складе | [BIC]
NDefines.NAI.PRODUCTION_EQUIPMENT_SURPLUS_FACTOR_GARRISON = 0.1  -- в ванилле 0.3 | Базовое значение того, какую долю от используемого в данный момент снаряжения ИИ будет как минимум стремиться иметь на складе для гарнизонных сил | [BIC]
NDefines.NAI.PRODUCTION_LINE_SWITCH_SURPLUS_NEEDED_MODIFIER = 0.15  -- в ванилле 0.2 | Модифицируется модификаторами эффективности. | [BIC]

NDefines.NAI.DEFAULT_SUPPLY_TRAIN_NEED_FACTOR = 1.25  -- в ванилле 1.2 | ИИ умножает текущее использование поездов на это значение для определения желаемого количества необходимых поездов. Может быть изменено стратегиями ИИ wanted_supply_train и min_wanted_supply_trains. | [BIC]

NDefines.NAI.CHIEF_ADDED_WEIGHT_FACTOR = 6.5  -- в ванилле 2.4 | Множитель веса для ролей начальников штабов по сравнению с другими типами советников или идей | [FAI]
NDefines.NAI.ARMY_CHIEF_SCORE_MULTIPLIER = 2.5  -- в ванилле 1.0 | Множитель очков для найма начальника армии | [FAI]
NDefines.NAI.AIR_CHIEF_SCORE_MULTIPLIER = 25.0  -- в ванилле 1.0 | Множитель очков для найма начальника авиации | [FAI]
NDefines.NAI.NAVY_CHIEF_SCORE_MULTIPLIER = 40.5  -- в ванилле 1.0 | Множитель очков для найма начальника флота | [FAI]

NDefines.NAI.ASSIGN_MOUNTAINEERS_TO_MOUNTAINS = 50.0  -- в ванилле 10.0 | Фактор для назначения горнострелковых дивизий на фронты с горами (пропорционально количеству этого типа местности)

NDefines.NAI.UPDATE_SUPPLY_MOTORIZATION_FREQUENCY_HOURS = 92  -- в ванилле 52; | Проверять, улучшит ли активация моторизации ситуацию со снабжением, с такой периодичностью. | [FAI]

NDefines.NAI.REDEPLOY_DISTANCE_VS_ORDER_SIZE = 0.6  -- в ванилле 1.0 | Фактор, применяемый к длине пути подразделения по сравнению с длиной приказа для определения, следует ли использовать стратегическую переброску
NDefines.NAI.UNIT_ASSIGNMENT_TERRAIN_IMPORTANCE = 20.0  -- в ванилле 10.0 | Очки местности для подразделений умножаются на это значение, когда ИИ решает, на какой фронт они должны быть назначены

NDefines.NAI.FORTIFIED_MIN_ORG_FACTOR_TO_CONSIDER_A_FRONT_FORTIFIED = 0.55  -- в ванилле 0.2 | ИИ будет относиться к укрепленным провинциям как к неукрепленным, если ни одно подразделение в этой провинции не имеет фактора организации хотя бы на таком уровне | [FAI]

NDefines.NAI.FRONT_EVAL_UNIT_ACCURACY = 3.0  -- в ванилле 1.0 | Насколько глупо ИИ будет действовать на фронтах. 0 — уровень картошки | [FAI] [SUPERCHARGER]

NDefines.NAI.PLAN_STEP_COST_LIMIT = 200  -- в ванилле 9 | При пошаговом рисовании плана эта стоимость заставляет его прерываться, если он упирается в сложную местность (умножается на количество желаемых шагов) | [FAI] [SUPERCHARGER]
NDefines.NAI.PLAN_ATTACK_DEPTH_FACTOR = 0.25  -- в ванилле 0.5 | Фактор, применяемый к размеру или атакуемому противнику. | [FAI]
NDefines.NAI.MIN_AI_UNITS_PER_TILE_FOR_STANDARD_COHESION = 2.5  -- в ванилле 1.5 | Сколько подразделений ии должны иметь на каждую клетку вдоль фронта, чтобы переключиться на стандартную сплоченность (меньше перемещений туда-сюда)

NDefines.NAI.ASSIGN_FRONT_TERRAIN_ATTACK_FACTOR = 0.1  -- в ванилле 3.0 | Важность скорректированного под местность показателя атаки подразделения при назначении на фронт
NDefines.NAI.ASSIGN_FRONT_TERRAIN_DEFENSE_FACTOR = 0.1  -- в ванилле 1.0 | Важность скорректированного под местность показателя обороны подразделения при назначении на фронт
NDefines.NAI.ASSIGN_FRONT_TERRAIN_MOVEMENT_FACTOR = 0.1  -- в ванилле 2.0 | Важность скорректированного под местность показателя скорости перемещения подразделения при назначении на фронт

NDefines.NAI.DIVISION_SUPPLY_RATIO_TO_MOTORIZE = 0.90  -- в ванилле 0.80 | Если уровень снабжения меньше этого значения, рассмотреть возможность моторизации любого подходящего близлежащего узла снабжения

NDefines.NAI.MAX_MICRO_ATTACKS_PER_ORDER = 32  -- в ванилле 3 | ИИ просматривает свои приказы и проверяет, есть ли ситуации, которыми можно воспользоваться
NDefines.NAI.MICRO_POCKET_SIZE = 8  -- в ванилле 4 | Котлы с размером, равным или меньшим этого значения, будут зачищаться ИИ микроконтролем для эффективности.
NDefines.NAI.POCKET_DISTANCE_MAX = 6000  -- в ванилле 40000 | Кратчайшее квадратное расстояние, на котором ии вообще утруждаем себя преследованием котлов

NDefines.NAI.ORG_UNIT_WEAK = 0.4  -- в ванилле 0.25 | % организации для того, чтобы подразделение считалось слабым | [FAI]
NDefines.NAI.ORG_UNIT_NORMAL = 0.6  -- в ванилле 0.35 | % организации для того, чтобы подразделение считалось нормальным | [FAI]
NDefines.NAI.ORG_UNIT_STRONG = 0.85  -- в ванилле 0.75 | % организации для того, чтобы подразделение считалось сильным

 -- Пороги прочности (Str): в ванилле WEAK 0.30 / NORMAL 0.40 / STRONG 0.70
NDefines.NAI.STR_UNIT_WEAK = 0.5  -- в ванилле 0.30 | % прочности (снаряжения) для того, чтобы подразделение считалось слабым | [FAI]
NDefines.NAI.STR_UNIT_NORMAL = 0.7  -- в ванилле 0.4 | % прочности (снаряжения) для того, чтобы подразделение считалось нормальным | [FAI]
NDefines.NAI.STR_UNIT_STRONG = 0.95  -- в ванилле 0.70 | % прочности (снаряжения) для того, чтобы подразделение считалось сильным | [FAI]

 -- =====================================================================================
 -- НАСТРОЙКИ ДЛЯ ОСТОРОЖНОГО РЕЖИМА ИИ (CAREFUL AI MODE OVERRIDES)
 -- =====================================================================================
NDefines.NAI.PLAN_EXECUTE_CAREFUL_LIMIT = 5  -- в ванилле 25 | При поиске цели для атаки этот лимит очков требуется в плане боя, чтобы рассматривать провинцию для атаки | [FAI]
NDefines.NAI.PLAN_EXECUTE_CAREFUL_MAX_FORT = 3  -- в ванилле 5 | Если режим выполнения установлен на "осторожный", подразделения не будут атаковать провинции с уровнем укреплений (бункеров) равным или выше этого значения | [FAI]

 -- Минимальные пороги организации для атаки по плану в зависимости от режима агрессии (HIGH=агрессивный, MED=сбалансированный, LOW=осторожный)
 -- Примечание: это влияет как на ИИ, так и на планировщик боя игрока
NDefines.NAI.PLAN_ATTACK_MIN_ORG_FACTOR_HIGH = 0.35  -- в ванилле 0.45 | [FAI v2] Пол против самоубийственных атак: откладывает атаки до восстановления организации, никогда не создает пассивности
NDefines.NAI.PLAN_ATTACK_MIN_ORG_FACTOR_MED = 0.45  -- в ванилле 0.7 | (LOW,MED,HIGH) соответствует уровню агрессивности выполнения плана. | [FAI v2]
NDefines.NAI.PLAN_ATTACK_MIN_ORG_FACTOR_LOW = 0.8  -- в ванилле 0.85 | Минимальный % организации для подразделения, чтобы активно атаковать вражеское подразделение при выполнении плана
NDefines.NAI.PLAN_ATTACK_MIN_STRENGTH_FACTOR_HIGH = 0.5  -- в ванилле 0.30
NDefines.NAI.PLAN_ATTACK_MIN_STRENGTH_FACTOR_MED = 0.6  -- в ванилле 0.50
NDefines.NAI.PLAN_ATTACK_MIN_STRENGTH_FACTOR_LOW = 0.9  -- в ванилле 0.60 | Минимальная прочность для подразделения, чтобы активно атаковать вражеское подразделение при выполнении плана


NDefines.NMilitary.MIN_BALANCE_SCORE_TO_PROCEED_ATTACK = 0.25  -- в ванилле 0.2 | --Оценка баланса сил в бою меньше этой величины предотвратит автоматическую атаку | [FAI]

NDefines.NMilitary.PLAN_SPREAD_ATTACK_WEIGHT = 300.0  -- в ванилле 12.0 | Чем выше значение, тем меньше оно должно перегружать провинции множественными атаками. | [FAI]
NDefines.NMilitary.PLAN_MIN_AUTOMATED_EMPTY_POCKET_SIZE = 20  -- в ванилле 2 | Система боевых планов будет автоматически атаковать только те провинции в котлах, которые не оказывают сопротивления и имеют размер не более чем столько провинций | [FAI]
NDefines.NMilitary.FRONTLINE_EXPANSION_FACTOR = 0.0  -- в ванилле 0.6 | При атаке вдоль линии фронта, насколько сильно подразделения должны рассредотачиваться по мере продвижения. 0.0 означает движение (более-менее) напрямую к нарисованной линии фронта, без отвлечений | [FAI]
NDefines.NMilitary.FRONT_MIN_PATH_TO_REDEPLOY = 4  -- в ванилле 8 | Если путь подразделения до его позиции на фронте равен или длиннее этого значения, оно будет использовать стратегическую переброску. | [FAI]

NDefines.NAI.PLAN_MIN_SIZE_FOR_FALLBACK = 5000  -- в ванилле 50 | Страна с меньшим количеством провинций, чем это значение, не будет рисовать планы отхода (линии отступления), а скорее разместит свои войска вдоль фронта | [FAI]
 -- Важность провинций фронта — инфраструктура
NDefines.NMilitary.PLAN_PROVINCE_PORT_BASE_IMPORTANCE = 25.0       -- в ванилле 9.0 | [FAI] значительно повышена важность портов
NDefines.NMilitary.PLAN_PROVINCE_AIRFIELD_LEVEL_FACTOR = 3      -- в ванилле 0.25



NDefines.NAI.DEPLOY_MIN_TRAINING_SURRENDER_FACTOR = 1     -- Требуемый процент обучения (1.0 = 100%) для развертывания подразделения ИИ в военное время, когда прогресс капитуляции выше 0
NDefines.NAI.DEPLOY_MIN_EQUIPMENT_SURRENDER_FACTOR = 0.9   -- Требуемый процент снаряжения (1.0 = 100%) для развертывания подразделения ИИ в военное время, когда прогресс капитуляции выше 0
NDefines.NAI.DEPLOY_MIN_TRAINING_PEACE_FACTOR = 1       -- Требуемый процент обучения (1.0 = 100%) для развертывания подразделения ИИ в мирное время
NDefines.NAI.DEPLOY_MIN_EQUIPMENT_PEACE_FACTOR = 0.98       -- Требуемый процент снаряжения (1.0 = 100%) для развертывания подразделения ИИ в мирное время
NDefines.NAI.DEPLOY_MIN_TRAINING_WAR_FACTOR = 1       -- Требуемый процент обучения (1.0 = 100%) для развертывания подразделения ИИ в военное время
NDefines.NAI.DEPLOY_MIN_EQUIPMENT_WAR_FACTOR = 0.9         -- Требуемый процент снаряжения (1.0 = 100%) для развертывания подразделения ИИ в военное время

NDefines.NMilitary.AI_BATTALION_BUILD_ORDER = { 	1,   4,   7,   10,   13,
													2,   5,   8,  11,   14,
													3,  6,  9,  12,  15,
													16,  17,  18,  19,  20,
													21,  22,  23,  24,  25} 
		
NDefines.NProduction.MILITARY_FACTORY_COHERENCY_BONUS = 15

-- <start> приоритеты строительства
NDefines.NAI.CONSTRUCTION_PRIO_INFRASTRUCTURE = 0 --в ванилле 0.2                         -- Базовый приоритет для инфраструктуры в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_CIV_FACTORY = 0.80                                      -- Базовый приоритет для гражданских фабрик в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_MIL_FACTORY = 0.70                                       -- Базовый приоритет для военных заводов в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_SUPPLY_BUILDING = 0.40 --в ванилле 1.1                       -- Базовый приоритет для зданий снабжения (узлы снабжения, порты) в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_RAILWAY = 4.00                                           -- Базовый приоритет для железных дорог в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_RAILWAY_GUN_REPAIR = 15.00                               -- Базовый приоритет для ремонта железнодорожных орудий в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_UNSPECIFIED = 0.50                                       -- Базовый приоритет для неуказанных зданий (ни одна из категорий выше) в очереди строительства
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OCCUPIED_TERRITORY = 1.00                         -- Множитель приоритета на это значение, если территория оккупирована
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OWNED_NONCORE = 1.50                             -- Множитель приоритета на это значение, если это собственная некоренная (национальная) территория
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OWNED_CORE = 2.00                                 -- Множитель приоритета на это значение, если это собственная коренная (национальная) территория
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_REPAIRING = 0.30                                 -- Множитель приоритета на это значение, если здание ремонтируется
-- <end> приоритеты строительства


--Улучшение Агентства (КБ)
NDefines.NOperatives.AGENCY_CREATION_DAYS = 30						-- Количество дней, необходимое для создания разведывательного агентства
NDefines.NOperatives.AGENCY_UPGRADE_DAYS = 30						-- Количество дней, необходимое для улучшения разведывательного агентства
NDefines.NOperatives.AGENCY_CREATION_FACTORIES = 0					-- Количество заводов, используемых для создания разведывательного агентства

--Воздух
--NDefines.NMilitary.AIR_SUPPORT_BASE = 0.45
NDefines.NAir.COMBAT_DAMAGE_SCALE = 0.6 ---Размены в воздухе(ванила = 1)
NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_MULT = 0 -- Скорость минирования
NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_LOWER_BOUND = 0 -- Минимальная скорость минирования
NDefines.NAir.AIR_WING_FLIGHT_SPEED_MULT = 1 -- Глобальная скорость самолётов
NDefines.NAir.AIR_DEPLOYMENT_DAYS = 0 -- Скорость развёртки самолётов

NDefines.NProject.RECRUIT_SCIENTIST_COST = {						-- Количество политических очков (pp) для найма ученого в зависимости от доступных ученых
		25,			-- Стоимость в pp, если нет доступных ученых
		25,			-- Стоимость в pp, если есть 1 доступный ученый
		50,			-- Стоимость в pp, если есть 2 доступных ученых
		50			-- Стоимость в pp, если доступно более 2 ученых
	}

NDefines.NFocus.MAX_SAVED_FOCUS_PROGRESS = 20

NDefines.NDoctrines.MASTERY_BANK_CONVERSION_RATE = 0.5

NDefines.NIndustrialOrganisation.DEFAULT_INITIAL_ATTACH_POLICY_COOLDOWN = 0    --Через сколько дней можно будет изменить политику в кб
