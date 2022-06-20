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


call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'glepnir/lspsaga.nvim'
call plug#end()

lua << EOF
local lsi = require("nvim-lsp-installer")
lsi.setup()
local _, angularls = lsi.get_server("angularls")
local _, tsserver = lsi.get_server("tsserver")
local lspconfig = require("lspconfig")
if angularls:is_installed() then
	lspconfig["angularls"].setup(angularls:get_default_options())
else
	angularls:install()
end

if tsserver:is_installed() then
	lspconfig["tsserver"].setup(tsserver:get_default_options())
else
	tsserver:install()
end

local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
