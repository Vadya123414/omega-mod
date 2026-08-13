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
NDefines.NMilitary.UNIT_LEADER_MODIFIER_COOLDOWN_ON_GROUP_CHANGE = 0 -- Скорость перевода генерала в другую армию
NDefines.NMilitary.UNIT_LEADER_ASSIGN_TRAIT_COST = 0 -- Cтоимость трейтов генералов
NDefines.NMilitary.MAX_ARMY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_NAVY_EXPERIENCE = 999;
NDefines.NMilitary.MAX_AIR_EXPERIENCE  = 999;
NDefines.NMilitary.ENCIRCLED_DISBAND_MANPOWER_FACTOR = 0;
NDefines.NCountry.SPECIAL_FORCES_CAP_MIN = 168 --24 лимит спец войск
NDefines.NCountry.REINFORCEMENT_MANPOWER_DELIVERY_SPEED = 100000.0 --Модификатор скорости доставки подкрепления для армии (время в пути)

--Флот
NDefines.NNavy.INITIAL_ALLOWED_DOCKYARD_RATIO_FOR_REPAIRS = 1.0
NDefines.NNavy.MAX_ORG_ON_MANUAL_MOVE = 1.0
NDefines.NNavy.TRAINING_ACCIDENT_CHANCES = 0.00
NDefines.NNavy.NAVAL_MINES_IN_REGION_MAX = 0.0-- Кол-во мин в рег
NDefines.NNavy.NAVAL_MINES_PLANTING_SPEED_MULT = 0	-- скорость минирования

--Производство
NDefines.NProduction.CAPITAL_SHIP_MAX_NAV_FACTORIES_PER_LINE = 10;
NDefines.NProduction.MIN_POSSIBLE_TRAINING_MANPOWER = 10000000;
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

--Agency Upgrade
NDefines.NOperatives.AGENCY_CREATION_DAYS = 30						-- Number of days needed to create an intelligence agency
NDefines.NOperatives.AGENCY_UPGRADE_DAYS = 30						-- Number of days needed to upgrade an intelligence agency
NDefines.NOperatives.AGENCY_CREATION_FACTORIES = 0					-- Number of factories used to create an intelligence agency

--Воздух
--NDefines.NMilitary.AIR_SUPPORT_BASE = 0.45
NDefines.NAir.COMBAT_DAMAGE_SCALE = 0.8 ---размены в воздухе(ванила = 1)

NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_MULT = 0 -- скорость минирования
NDefines.NAir.NAVAL_MINES_PLANTING_SPEED_LOWER_BOUND = 0 -- минимальная скорость минирования

