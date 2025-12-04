return {
	"ahmedkhalf/project.nvim",
	cmd = { "Telescope projects", "Projects" },
	config = function()
		require("project_nvim").setup {
			detection_methods = { "pattern" },
			patterns = { ".git", "Makefile", "package.json", "pyproject.toml", "Cargo.toml" },
		}
		require('telescope').load_extension('projects')

		-- create autocmd for "Projects"
		vim.api.nvim_create_user_command("Projects", function()
			require("telescope").extensions.projects.projects()
		end, {})
	end,
}
