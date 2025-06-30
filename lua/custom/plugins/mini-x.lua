return {
	{
		'echasnovski/mini.comment',
		version = false, -- or use `*` to get latest stable
		opts = {
			mappings = {
				comment = 'gc',
				comment_line = 'gcc',
				comment_visual = 'gc',
				textobject = 'gc',
			},
		},
	},

	{ 'echasnovski/mini.surround', version = '*' },
}
