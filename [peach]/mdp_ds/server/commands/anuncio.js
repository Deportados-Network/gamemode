const { MessageEmbed } = require('discord.js');

module.exports = {
    name: "anuncio",
    description: "Envía un anuncio al servidor",
    role: "mod",

    options: [
        {
            name: "mensaje",
            description: "Mensaje para el anuncio",
            required: true,
            type: "STRING",
        },
    ],

    run: async (client, interaction, args) => {
        const usuarioQueEjecuto = interaction.member.displayName;
        const anuncioEnviado = args.mensaje;
        const canalIdPermitido = "1181741090542465025";

        if (interaction.channelId !== canalIdPermitido) {
            return interaction.reply({ content: "No tienes permisos para usar el comando o no puedes usarlo en este canal!", ephemeral: true });
        }

        const embed = new MessageEmbed()
            .setTitle("SISTEMA DE DISCORD")
            .setThumbnail("https://cdn.discordapp.com/attachments/1186833024709574736/1186835066601615360/nuevo_logo_depo_blanco.png?ex=6594b14a&is=65823c4a&hm=713eb89b1a4b8283b59d29b62f1323b436e8aebf2b37083786138052adb0e6d3&")
            .setColor([255, 255, 255])
            .setDescription(`_Un **STAFF** ha enviado un anuncio_\n\n- STAFF: **${usuarioQueEjecuto}**\n- ANUNCIO: **${anuncioEnviado}**`)
            .setFooter("depo | System");

        client.utils.chatMessage(-1, client.z.locale.announcement, args.mensaje, { color: [255, 0, 0] });
        client.utils.log.info(`[${usuarioQueEjecuto}] Anuncio: ${anuncioEnviado}`);
        interaction.reply({ embeds: [embed], ephemeral: false });
    },
};