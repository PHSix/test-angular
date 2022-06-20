if has('vim_starting')
  set encoding=utf-8
endif
scriptencoding utf-8

if &compatible
  set nocompatible
endif

if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.fastgit.org/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


execute 'set runtimepath+=' . s:plug_dir
call plug#begin(s:plug_dir)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'glepnir/lspsaga.nvim'
call plug#end()
PlugInstall | quit

lua << EOF
local lsi = require("nvim-lsp-installer")
lsi.setup()
local _, angularls = lsi.get_server("angularls")
local _, tsserver = lsi.get_server("tsserver")

if angularls:is_installed() then
	angularls:setup_lsp()
else
	angularls:install()
end

if tsserver:is_installed() then
	tsserver:setup_lsp()
else
	tsserver:install()
end

local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
