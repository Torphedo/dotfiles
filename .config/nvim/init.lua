local vim = vim; -- Silences a bunch of LSP warnings
-- Import vim config
vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after');
vim.o.packpath = vim.o.runtimepath;
vim.cmd('source ~/.vimrc');

-- Packages
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/navarasu/onedark.nvim" },
});

vim.lsp.enable({ "lua_ls", "clangd", "pylsp" });

require "oil".setup();
require "mini.pick".setup();
require "mason".setup();

vim.cmd("colorscheme onedark");
-- Reset status color to override color scheme.
-- This function is defined in the vimrc
vim.cmd("call SetStatusColor()");

-- Make other windows distinct from the background
vim.o.winborder = "rounded";

vim.keymap.set("n", "<leader>e", ":Oil<CR>");
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format);
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>");
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>");
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>");
vim.keymap.set("n", "<leader>h", ":Pick help<CR>");

-- Sane autocomplete suggestion keybinds
vim.keymap.set("i", "<Tab>", "<C-n>");
vim.keymap.set("i", "<S-Tab>", "<C-p>");

vim.keymap.set("n", "gd", vim.lsp.buf.definition);
vim.keymap.set("n", "<F12>", vim.lsp.buf.definition);

vim.keymap.set("n", "gD", vim.lsp.buf.declaration);

vim.keymap.set("n", "gr", vim.lsp.buf.references);
vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references);

vim.keymap.set("n", "gR", vim.lsp.buf.rename);

-- Add LSP suggestions to C-x C-o menu
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
            -- Make suggestions appear on every keystroke
            local chars = {};
            for i = 32, 126 do
                table.insert(chars, string.char(i))
            end
            client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
