NDefines.NGame.GAME_SPEED_SECONDS = { 1000.0, 0.2, 0.1, 0.05, 0.0 }; -- SPEED 4 IS 0.1 IN VANILLA  game speeds for each level. Must be 5 entries with last one 0 for unbound]
NDefines.NGame.LAG_DAYS_FOR_LOWER_SPEED = 60;
NDefines.NGame.LAG_DAYS_FOR_PAUSE = 100;

--Армия
--NDefines.NMilitary.FIELD_MARSHAL_DIVISIONS_CAP = 72;
--NDefines.NMilitary.CORPS_COMMANDER_DIVISIONS_CAP = 72;
--NDefines.NMilitary.BASE_DIVISION_BRIGADE_GROUP_COST = 1;
--NDefines.NMilitary.BASE_DIVISION_BRIGADE_CHANGE_COST = 1;
--NDefines.NMilitary.BASE_DIVISION_SUPPORT_SLOT_COST = 1;
--NDefines.NMilitary.ANTI_AIR_TARGETTING_TO_CHANCE = 0.02;              --  шанс попадания ПВО по штурму
NDefines.NMilitary.MIN_DIVISION_BRIGADE_HEIGHT = 5;	-- анлок 5 ячейки в столбце шаблона дивизии 
NDefines.NMilitary.UNIT_LEADER_MODIFIER_COOLDOWN_ON_GROUP_CHANGE = 0 -- Скорость перевода генерала в другую армию
NDefines.NMilitary.UNIT_LEADER_ASSIGN_TRAIT_COST = 0 -- Cтоимость трейтов генералов
NDefines.NMilitary.MAX_ARMY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_NAVY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_AIR_EXPERIENCE  = 999;
NDefines.NMilitary.COHESION_IMMOBILE_PLANNING_SPEED_MULTIPLIER = 1.0;	-- If using the 'immobile' cohesion setting, factor ALL planning speed growth by this
NDefines.NMilitary.ENCIRCLED_DISBAND_MANPOWER_FACTOR = 0;
NDefines.NMilitary.PLANNING_CAP_COMMS_SCALING = { 1.0, 1.0, 1.0, 1.0, 1.0 };		-- Value at index J is the scaling applied to planning cap when HQ is J provinces behind the frontline
NDefines.NMilitary.PLANNING_CAP_NO_HQ_SCALING = 1.0;								-- Scaling applied to planning cap when there's no HQ (no leader or leader not deployed or not the same root order)
NDefines.NMilitary.PLANNING_SPEED_COMMS_SCALING = { 1.0, 1.0, 1.0, 1.0, 1.0 };		-- Same as PLANNING_CAP_COMMS_SCALING but for planning speed
NDefines.NMilitary.PLANNING_SPEED_NO_HQ_SCALING = 1.0;								-- Same as PLANNING_CAP_NO_HQ_SCALING but for planning speed
NDefines.NMilitary.DEPLOY_TRAINING_MAX_LEVEL = 2;
--NDefines.NMilitary.LEADER_MOD_COMMS_SCALING = { 1.06, 1.04, 1.02, 1.01, 1.0 };		-- Same as PLANNING_CAP_COMMS_SCALING but for leader modifiers
--NDefines.NMilitary.LEADER_MOD_NO_HQ_SCALING = 1.0;									-- Same as PLANNING_CAP_NO_HQ_SCALING but for leader modifiers
--NDefines.NMilitary.ABILITY_COMMS_SCALING = { 1.06, 1.04, 1.02, 1.01, 1.0 };			-- Same as PLANNING_CAP_COMMS_SCALING but for active abilities
--NDefines.NMilitary.ABILITY_NO_HQ_SCALING = 1.0;									-- Same as PLANNING_CAP_NO_HQ_SCALING but for active abilities
--NDefines.NMilitary.PREFERRED_PRISON_VP = 5;	-- When capturing a general, try to find a province with at least that much VP to imprison them. The effective prison VP can be lower than that, if the capturing country doesn't have any province with at least this amount of VP
NDefines.NCountry.SPECIAL_FORCES_CAP_MIN = 168 --24 лимит спец войск
NDefines.NCountry.REINFORCEMENT_MANPOWER_DELIVERY_SPEED = 100000.0 --Модификатор скорости доставки подкрепления для армии (время в пути)

--Флот
NDefines.NNavy.MAX_ORG_ON_MANUAL_MOVE = 1.0;
NDefines.NNavy.PRIDE_OF_THE_FLEET_UNASSIGN_COST = 0;--100							-- стоимость снятие гордости флота
NDefines.NNavy.TRAINING_ACCIDENT_CHANCES = 0.00
NDefines.NNavy.NAVAL_MINES_IN_REGION_MAX = 0.0-- Кол-во мин в рег
NDefines.NNavy.NAVAL_MINES_PLANTING_SPEED_MULT = 0	-- скорость минирования
NDefines.NNavy.INITIAL_ALLOWED_DOCKYARD_RATIO_FOR_REPAIRS = 1.0
NDefines.NNavy.NAVAL_MINES_ACCIDENT_CRITICAL_HIT_CHANCES = 0;    -- шанс крита мин
NDefines.NNavy.NAVAL_MINES_ACCIDENT_CRITICAL_HIT_DAMAGE_SCALE = 0;   -- урон крита мин
NDefines.NNavy.NAVAL_MINES_ACCIDENT_STRENGTH_LOSS = 0;      -- урон мин по прочности
NDefines.NNavy.NAVAL_MINES_ACCIDENT_ORG_LOSS_FACTOR = 0;	--урон мин по орге

--Производство
NDefines.NProduction.CAPITAL_SHIP_MAX_NAV_FACTORIES_PER_LINE = 10;
NDefines.NProduction.MIN_POSSIBLE_TRAINING_MANPOWER = 10000000;
NDefines.NProduction.RAILWAY_GUN_MAX_MIL_FACTORIES_PER_LINE = 10;
NDefines.NProduction.MAX_MIL_FACTORIES_PER_LINE = 300;
NDefines.NProduction.SHIP_REFIT_MAX_PROGRESS_TO_CANCEL = 0.99;
NDefines.NProduction.CONVOY_MAX_NAV_FACTORIES_PER_LINE = 300
--NDefines.NProduction.EQUIPMENT_MODULE_ADD_XP_COST = 0.0            -- XP cost for adding a new equipment module in an empty slot when creating an equipment variant.
--NDefines.NProduction.EQUIPMENT_MODULE_REPLACE_XP_COST = 0.0        -- XP cost for replacing one equipment module with an unrelated module when creating an equipment variant.
--NDefines.NProduction.EQUIPMENT_MODULE_CONVERT_XP_COST = 0.0        -- XP cost for converting one equipment module to a related module when creating an equipment variant.
--NDefines.NProduction.EQUIPMENT_MODULE_REMOVE_XP_COST = 0.0         -- XP cost for removing an equipment module and leaving the slot empty when creating an equipment variant.
--NDefines.NProduction.BASE_LICENSE_IC_COST = 0;
--NDefines.NProduction.LICENSE_IC_COST_YEAR_INCREASE = 0;
--NDefines.NProduction.MIN_LICENSE_ACTIVE_DAYS = 1 

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
NDefines.NAI.STOP_TRAINING_FULLY_TRAINED_FACTOR = 0.95           -- ИИ прекратит тренировку, если как минимум такая доля дивизий в армии полностью обучена
NDefines.NAI.STOP_TRAINING_ACTIVE_COMBAT_RATIO = 0.05            -- ИИ останавливает все тренировки, когда более чем такая доля его дивизий находится в активном бою (вместо этого идет пополнение)
NDefines.NAI.HOURS_BETWEEN_ENCIRCLEMENT_DISCOVERY = 16 -- Для каждой армии: интервал в часах между обновлением списка провинций, которые могут стать точками окружения
NDefines.NAI.MAX_FULLY_TRAINED_SHIP_RATIO_FOR_TRAINING = 0.9 	-- ИИ не будет тренировать оперативное соединение, если доля полностью обученных кораблей выше этого значения
NDefines.NAI.AI_MAX_TASKFORCES_PER_TRAINING_OBJECTIVE = 999 --Максимальное кол-во заданий обучений для ИИ
NDefines.NAI.AI_TASKFORCE_REQUIRED_RESERVE_RATIO = 0.0
NDefines.NAI.MAX_THREAT_FOR_FIRST_YEAR_CIVILIAN_MODE = 0 -- к скольким цивилкам ботики будут стремиться в 36 году, кратно увеличивает вес цивилок


-- <start> construction prioritization
NDefines.NAI.CONSTRUCTION_PRIO_INFRASTRUCTURE = 0.20                                    -- base prio for infrastructure in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_CIV_FACTORY = 0.80                                      -- base prio for civilian factories in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_MIL_FACTORY = 0.70                                       -- base prio for military factories in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_SUPPLY_BUILDING = 0.40 --vanila 1.1                                  -- base prio for supply buildings (supply hubs, ports) in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_RAILWAY = 4.00                                           -- base prio for railways in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_RAILWAY_GUN_REPAIR = 15.00                               -- base prio for railway gun repairs in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_UNSPECIFIED = 0.50                                       -- base prio for unspecified buildings (none of the categories above) in the construction queue
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OCCUPIED_TERRITORY = 1.00                         -- factor prio with this if occupied territory
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OWNED_NONCORE = 1.50                             -- factor prio with this if owned non-core territory
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_OWNED_CORE = 2.00                                 -- factor prio with this if owned core territory
NDefines.NAI.CONSTRUCTION_PRIO_FACTOR_REPAIRING = 0.30                                 -- factor prio with this if building is being repaired
-- <end> construction prioritization


--Agency Upgrade
NDefines.NOperatives.AGENCY_CREATION_DAYS = 30						-- Number of days needed to create an intelligence agency
NDefines.NOperatives.AGENCY_UPGRADE_DAYS = 30						-- Number of days needed to upgrade an intelligence agency
NDefines.NOperatives.AGENCY_CREATION_FACTORIES = 0					-- Number of factories used to create an intelligence agency

--Воздух
--NDefines.NMilitary.AIR_SUPPORT_BASE = 0.45
NDefines.NAir.COMBAT_DAMAGE_SCALE = 0.8 ---размены в воздухе(ванила = 1)
NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_MULT = 0 -- скорость минирования
NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_LOWER_BOUND = 0 -- минимальная скорость минирования
NDefines.NAir.AIR_WING_FLIGHT_SPEED_MULT = 1; -- глобальная скорость самолётов

NDefines.NProject.RECRUIT_SCIENTIST_COST = {						-- Amount of pp to hire a scientist based on available scientist
		25,			-- pp cost if no available scientist
		25,			-- pp cost if 1 available scientist
		50,			-- pp cost if 2 available scientist
		50			-- pp cost if more than 2 available scientist
	}

NDefines.NFocus.MAX_SAVED_FOCUS_PROGRESS = 20

NDefines.NDoctrines.MASTERY_BANK_CONVERSION_RATE = 0.5

