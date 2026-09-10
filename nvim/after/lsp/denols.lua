-- Mirror of the tsgo/ts_ls rule, from denols' side.
-- denols attaches only when a deno.json/deno.jsonc exists AND there is no
-- package.json. If a package.json is present, tsgo/ts_ls handle the project.
return {
	root_dir = function(bufnr, on_dir)
		local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
		if not deno_root then
			return -- not a deno project
		end

		if vim.fs.root(bufnr, { "package.json" }) then
			return -- package.json present -> let tsgo/ts_ls take it
		end

		on_dir(deno_root)
	end,
}
