module.exports = {
    name: "onlinecheck",
    type: "USER",
    role: "mod",

    run: async (client, interaction, args) => {
        // Obtener la ID de Discord del usuario mencionado
        const targetUserId = args.usuario ? args.usuario.id : interaction.targetId;

        // Obtener la ID del jugador en el servidor de FiveM
        const player = await client.utils.getPlayerFromDiscordId(targetUserId);

        if (!player) {
            return interaction.reply({ content: `<@${targetUserId}> is offline right now.`, ephemeral: true });
        }

        const qbplayer = client.QBCore.Functions.GetPlayer(parseInt(player));

        if (!qbplayer) {
            return interaction.reply({ content: `<@${targetUserId}> is online but not loaded in.`, ephemeral: true });
        }

        return interaction.reply({
            content: `<@${targetUserId}> is online! Playing as ${qbplayer.PlayerData.charinfo.firstname} ${qbplayer.PlayerData.charinfo.lastname} (${qbplayer.PlayerData.citizenid})`,
            ephemeral: true,
        });
    },
};
