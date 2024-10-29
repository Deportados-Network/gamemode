/*
    zdiscord - by Tony/zfbx - https://github.com/zfbx/zdiscord - License: CC BY-NC-SA 4.0
    Docs for this file available at https://zfbx.github.io/zdiscord/config or in docs/config.md
*/


/** ******************************
 * GENERAL CONFIGURATION SETTINGS
 ********************************/

const LanguageLocaleCode = "es";

// PUBLIC VALUES
const FiveMServerName = "Deportados | System";
const DiscordInviteLink = "https://discord.gg/deportados";
const FiveMServerIP = "45.235.98.119";

// This spams the console, only enable for testing if needed
const DebugLogs = false;


/** ********************
 * DISCORD BOT SETTINGS
 ***********************/

const EnableDiscordBot = true;

// DISCORD BOT
const DiscordBotToken = "MTMwMDkwNjMyOTg3NDg5MDg2NA.GKH9bg.akgicwi3KAg-QeOZKP3nnbAKq8Z_dIABZVYei0";
const DiscordGuildId = "1288648291676065802";

// STAFF CHAT
const EnableStaffChatForwarding = true;
const DiscordStaffChannelId = "1300903858700288111";
const AdditionalStaffChatRoleIds = [
    // "000000000000000",
];

// WHITELISTING / ALLOWLISTING
const EnableWhitelistChecking = true;
const DiscordWhitelistRoleIds = "12970073333130090385870028811151882844";

// SLASH COMMANDS / DISCORD PERMISSIONS
const EnableDiscordSlashCommands = true;
const DiscordModRoleId = "1300884767688101928";
const DiscordAdminRoleId = "1300884700545417216";
const DiscordGodRoleId = "1297336889598283776";

// DISCORD BOT STATUS
const EnableBotStatusMessages = true;
const BotStatusMessages = [
    "{servername}",
    "[{playercount}/64]",
];

// ACE PERMISSIONS
const EnableAutoAcePermissions = false;
const AutoAcePermissions = {
    // "example": "000000000000000000",
    // "example2": [ "000000000000000000", "000000000000000000"],
};

// Other
const SaveScreenshotsToServer = false;


/** ************************
 * WEBHOOK LOGGING SETTINGS
**************************/

const EnableLoggingWebhooks = true;
const LoggingWebhookName = "Deportados | Logs";
const LoggingAlertPingId = "1177846968119214143";
const LoggingWebhooks = {
    // "example": "https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-",
};


/** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * !! DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING !!
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

module.exports = {
    EnableDiscordBot: getConBool("discord_enable_bot", EnableDiscordBot),
    EnableStaffChatForwarding: getConBool("discord_enable_staff_chat", EnableStaffChatForwarding),
    EnableLoggingWebhooks: getConBool("discord_enable_logging_webhooks", EnableLoggingWebhooks),
    DebugLogs: getConBool("discord_debug", DebugLogs),
    DiscordBotToken: GetConvar("discord_token", DiscordBotToken),
    DiscordGuildId: GetConvar("discord_guild_id", DiscordGuildId),
    LanguageLocaleCode: GetConvar("discord_lang", LanguageLocaleCode),
    FiveMServerName: GetConvar("discord_server_name", FiveMServerName),
    DiscordInviteLink: GetConvar("discord_invite", DiscordInviteLink),
    FiveMServerIP: GetConvar("discord_server_ip", FiveMServerIP),
    EnableWhitelistChecking: getConBool("discord_enable_whitelist", EnableWhitelistChecking),
    DiscordWhitelistRoleIds: getConList("discord_whitelist_roles", DiscordWhitelistRoleIds),
    EnableDiscordSlashCommands: getConBool("discord_enable_commands", EnableDiscordSlashCommands),
    DiscordModRoleId: GetConvar("discord_mod_role", DiscordModRoleId),
    DiscordAdminRoleId: GetConvar("discord_admin_role", DiscordAdminRoleId),
    DiscordGodRoleId: GetConvar("discord_god_role", DiscordGodRoleId),
    EnableBotStatusMessages: getConBool("discord_enable_status", EnableBotStatusMessages),
    BotStatusMessages: BotStatusMessages,
    EnableAutoAcePermissions: getConBool("discord_enable_ace_perms", EnableAutoAcePermissions),
    AutoAcePermissions: AutoAcePermissions,
    SaveScreenshotsToServer: getConBool("discord_save_screenshots", SaveScreenshotsToServer),
    DiscordStaffChannelId: GetConvar("discord_staff_channel_id", DiscordStaffChannelId),
    LoggingWebhooks: LoggingWebhooks,
    LoggingAlertPingId: GetConvar("discord_logging_ping_id", LoggingAlertPingId),
    LoggingWebhookName: GetConvar("discord_logging_name", LoggingWebhookName),
    StaffChatRoleIds: [
        GetConvar("discord_mod_role", DiscordModRoleId),
        GetConvar("discord_admin_role", DiscordAdminRoleId),
        GetConvar("discord_god_role", DiscordGodRoleId),
        ...AdditionalStaffChatRoleIds,
    ],
};

/** Returns convar or default value fixed to a true/false boolean
 * @param {boolean|string|number} con - Convar name
 * @param {boolean|string|number} def - Default fallback value
 * @returns {boolean} - parsed bool */
function getConBool(con, def) {
    if (typeof def == "boolean") def = def.toString();
    const ret = GetConvar(con, def);
    if (typeof ret == "boolean") return ret;
    if (typeof ret == "string") return ["true", "on", "yes", "y", "1"].includes(ret.toLocaleLowerCase().trim());
    if (typeof ret == "number") return ret > 0;
    return false;
}

/** returns array of items or default array provided
 * @param {string} con - string of comma separated values
 * @param {string|Array} def - string of comma separated values
 * @returns {object} - array of discord ids */
function getConList(con, def) {
    const ret = GetConvar(con, def);
    if (typeof ret == "string") return ret.replace(/[^0-9,]/g, "").replace(/(,$)/g, "").split(",");
    if (Array.isArray(ret)) return ret;
    if (!ret) return [];
}
