-- Same deno-vs-node rule as after/lsp/tsgo.lua, for the ts_ls server.
-- package.json present -> ts_ls attaches; deno.json without package.json -> denols.
return {
	root_dir = function(bufnr, on_dir)
		local pkg_root = vim.fs.root(bufnr, { "package.json" })
		if pkg_root then
			on_dir(pkg_root)
			return
		end

		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			return
		end

		on_dir(vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", ".git" }) or vim.fn.getcwd())
	end,
}
