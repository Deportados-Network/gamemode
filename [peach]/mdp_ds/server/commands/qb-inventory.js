module.exports = {
    name: "inventario",
    description: "Manage player's in-city items",
    role: "admin",

    options: [
        {
            type: "SUB_COMMAND",
            name: "give",
            description: "give a player an item",
            options: [
                {
                    name: "id",
                    description: "Player's current id",
                    required: true,
                    type: "INTEGER",
                },
                {
                    name: "item",
                    description: "item to give",
                    required: true,
                    type: "STRING",
                },
                {
                    name: "count",
                    description: "how many to give [Default: 1]",
                    required: false,
                    type: "INTEGER",
                },
            ],
        },
        {
            type: "SUB_COMMAND",
            name: "take",
            description: "take an item away from a player",
            options: [
                {
                    name: "id",
                    description: "Player's current id",
                    required: true,
                    type: "INTEGER",
                },
                {
                    name: "item",
                    description: "item to take",
                    required: true,
                    type: "STRING",
                },
                {
                    name: "count",
                    description: "how many to take [Default: 1]",
                    required: false,
                    type: "INTEGER",
                },
            ],
        },
        {
            type: "SUB_COMMAND",
            name: "inspect",
            description: "Peek inside player's inventory",
            options: [
                {
                    name: "id",
                    description: "Player's current id",
                    required: true,
                    type: "INTEGER",
                },
            ],
        },
    ],

    run: async (client, interaction, args) => {
    const amount = args.count || 1;
    const targetPlayer = args.id;

    // Check if the player exists
    const targetPlayerName = await client.essentialMode.getPlayerName(targetPlayer);
    if (!targetPlayerName) return interaction.reply({ content: "This ID seems invalid.", ephemeral: true });

    // Get the player's inventory
    const [playerInventory] = await Promise.all([
        client.essentialMode.getInventory(targetPlayer),
    ]);

    if (args.give) {
        const badItems = ["id_card", "harness", "markedbills", "labkey", "printerdocument"];
        const itemData = client.essentialMode.getItemData(args.item.toLowerCase());

        if (!itemData) return interaction.reply({ content: "Item could not be found", ephemeral: false });
        if (badItems.includes(itemData.name)) return interaction.reply({ content: "This is a unique item and can't be interacted with like this", ephemeral: false });

        // Check if the item stacks
        if (amount > 1 && itemData.unique) return interaction.reply({ content: "These items don't stack, give 1 at a time.", ephemeral: false });

        // Add item to player's inventory
        const success = await client.essentialMode.addItem(targetPlayer, itemData.name, amount);

        if (success) {
            client.utils.log.info(`[${interaction.member.displayName}] gave ${targetPlayerName} (${targetPlayer}) ${amount} ${args.item}`);
            return interaction.reply({ content: `${targetPlayerName} (${targetPlayer}) was given ${amount} ${itemData.label}`, ephemeral: false });
        } else {
            return interaction.reply({ content: "Something went wrong trying to give this item", ephemeral: false });
        }
    } else if (args.take) {
        const itemData = client.essentialMode.getItemData(args.item.toLowerCase());

        if (!itemData) return interaction.reply({ content: "Item could not be found", ephemeral: false });

        // Remove item from player's inventory
        const success = await client.essentialMode.removeItem(targetPlayer, itemData.name, amount);

        if (success) {
            client.utils.log.info(`[${interaction.member.displayName}] removed item from ${targetPlayerName}'s (${targetPlayer}) inventory (${amount} ${args.item})`);
            return interaction.reply({ content: `${amount} ${itemData.label} has been taken from ${targetPlayerName} (${targetPlayer})`, ephemeral: false });
        } else {
            return interaction.reply({ content: `Failed to remove item from ${targetPlayerName}'s (${targetPlayer}) inventory`, ephemeral: false });
        }
    } else if (args.inspect) {
        // Get the player's inventory for inspection
        const [playerInventoryForInspect] = await Promise.all([
            client.essentialMode.getInventory(targetPlayer),
        ]);

        const embed = new client.Embed().setTitle(`${targetPlayerName}'s (${targetPlayer}) Inventory`);
        const items = playerInventoryForInspect;

        let desc = "";
        items.forEach((i) => {
            desc += `[${i.slot}] ${i.amount}x - **${i.label}** (${i.name})\n`;
        });

        embed.setDescription(desc);
        return interaction.reply({ embeds: [embed], ephemeral: false });
    }
},
};
