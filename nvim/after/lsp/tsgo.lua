-- Override nvim-lspconfig's deno-vs-node heuristic.
-- Our rule: if a package.json exists anywhere up the tree, this is a Node/TS
-- project and tsgo should attach -- even if a deno.json is also present.
-- A deno.json *without* a package.json is left to denols (see after/lsp/denols.lua).
return {
	root_dir = function(bufnr, on_dir)
		local pkg_root = vim.fs.root(bufnr, { "package.json" })
		if pkg_root then
			on_dir(pkg_root)
			return
		end

		-- No package.json: a deno project belongs to denols, so abort here.
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			return
		end

		-- Loose TS/JS file, not deno: fall back to a sensible root.
		on_dir(vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", ".git" }) or vim.fn.getcwd())
	end,
}
