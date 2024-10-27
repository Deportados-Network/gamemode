const { MessageEmbed } = require('discord.js');

module.exports = {
    name: "licencias",
    description: "Obten las licencias del jugador",
    role: "admin",

    options: [
        {
            name: "id",
            description: "ID del jugador",
            required: true,
            type: "INTEGER",
        },
    ],

    run: async (client, interaction, args) => {
        const canalIdPermitido = "1181741090542465025";

        if (interaction.channelId !== canalIdPermitido) {
            return interaction.reply({ content: "No tienes permisos para usar el comando o no puedes usarlo en este canal!", ephemeral: true });
        }

        if (!GetPlayerName(args.id)) {
            return interaction.reply({ content: "Esta ID parece ser inválida.", ephemeral: true });
        }

        const embed = new MessageEmbed()
            .setColor([255, 255, 255])
            .setTitle(`Licencias de ${GetPlayerName(args.id)}`)
            .setThumbnail("https://cdn.discordapp.com/attachments/1186833024709574736/1186835066601615360/nuevo_logo_depo_blanco.png?ex=6594b14a&is=65823c4a&hm=713eb89b1a4b8283b59d29b62f1323b436e8aebf2b37083786138052adb0e6d3&")
            .setFooter("depo | System");

        let desc = "";
        for (const [key, value] of Object.entries(client.utils.getPlayerIdentifiers(args.id))) {
            if (key === "discord") {
                desc += `- **${key}:** | <@${value}> (${value})\n`;
            } else {
                desc += `- **${key}:** | ${value}\n`;
            }
        }

        embed.setDescription(desc);
        client.utils.log.info(`[${interaction.member.displayName}] pulled identifiers on ${GetPlayerName(args.id)} (${args.id})`);

        return interaction.reply({ embeds: [embed], ephemeral: false }).catch();
    },
};
