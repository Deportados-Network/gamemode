const { MessageEmbed } = require('discord.js');

module.exports = {
  data: {
    name: 'id',
    description: 'Obtiene la ID del jugador de FiveM mencionado en Discord.',
    options: [
      {
        name: 'usuario',
        description: 'El usuario de Discord al que deseas obtener la ID del juego.',
        type: 'USER',
        required: true,
      },
    ],
  },
  async execute(interaction) {
    const user = interaction.options.getUser('usuario');

    // Verifica si el usuario está conectado al servidor de FiveM
    const playerId = await getPlayerIdFromDiscordId(user.id);

    if (playerId) {
      interaction.reply(`La ID de ${user.username} en el juego es: ${playerId}`);
    } else {
      interaction.reply(`${user.username} no está conectado al servidor de FiveM.`);
    }
  },
};

// Función para obtener la ID del jugador de FiveM a partir de la ID de Discord
async function getPlayerIdFromDiscordId(discordId) {
  const players = getPlayers(); // Reemplaza esto con tu propia lógica para obtener la lista de jugadores en el servidor.

  for (const player of players) {
    const playerDiscordId = getPlayerDiscordId(player);
    if (playerDiscordId === discordId) {
      return player;
    }
  }

  return null;
}
