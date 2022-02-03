{ config, lib, pkgs, ... }: 
let nixpkgs = import <nixpkgs> {
        config = {
            allowUnfree = true;
        };
    };
in {
  programs.home-manager.enable = true;
  home.username = "dwd";
  home.homeDirectory = "/home/dwd";
  home.packages = with nixpkgs; [
    cachix
    cmatrix
    direnv
    doctl
    enhanced-ctorrent
    file
    get_iplayer
    glances
    htop
    ipfs
    ncdu
    nix-direnv
    nixpkgs-fmt
    p7zip
    rclone
    socat
    units
    unzip
    wget
    youtube-dl
    yt-dlp
    zssh
  ];
  home.file.ghci = {
    target = ".ghci";
    text = ''
      :set +m
      :set prompt "\ESC[38;5;208m\STXλ>\ESC[m\STX "
      :set prompt-cont " | "
      :def hoogle \x -> return $ ":!hoogle \"" ++ x ++ "\""
      :def doc \x -> return $ ":!hoogle --info \"" ++ x ++ "\""
    '';
  };

  home.file.vimBackup = {
    target = ".vim/backup/.keep";
    text = "";
  };

  home.file.vimTmp = {
    target = ".vim/tmp/.keep";
    text = "";
  };

  home.file.xcompose = {
    target = ".XCompose";
    text = ''
      include "%L"

      <Multi_key> <l> <l> : "λ"
    '';
  };

  # overlays go here
  nixpkgs.config = import ./nixpkgs-config.nix;

  # todo more xdg?
  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  # is this necessary?
  xdg.configFile."nix/nix.conf".text = ''
    substituters = https://cache.nixos.org https://websites.cachix.org https://nixcache.reflex-frp.org https://nixcache.webghc.org
    trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= websites.cachix.org-1:YMPYgEeWohlGq/0wDvWLVSRoNcBS1jIOmku6Djv7zcM= ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI= hydra.webghc.org-1:knW30Yb8EXYxmUZKEl0Vc6t2BDjAUQ5kfC1BKJ9qEG8=
  '';

  # Disable search indexing
  xdg.configFile."baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false

    [General]
    dbVersion=2
    exclude filters=*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,core-dumps,lost+found
    exclude filters version=8
  '';

  # Set wallet to already be set up
  xdg.configFile."kwalletrc".text = ''
    [Wallet]
    First Use=false
  '';

  programs.ssh = {
    enable = true;
    matchBlocks = {
      dev = {
        hostname = "localhost";
        user = "root";
        port = 2222;
        localForwards = [
          {
            bind.port = 4455;
            host.address = "localhost";
            host.port = 445;
          }
        ];
      };
      imac = {
        hostname = "192.168.1.100";
      };
      windows = {
        hostname = "192.168.1.113";
        user = "micro";
      };
      sn = {
        hostname = "synchro.net";
      };
      we = {
        hostname = "warensemble.com";
        user = "dandart";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "cd"
      "ls"
      "exit"
      "logout"
    ];
    shellAliases = {
      ukbbs = "ztelnet ukbbs.zapto.org";
      fenric = "ztelnet fenric.muppetwhore.net";
      tardis = "ztelnet bbs.cortex-media.info";
      nostromo = "ztelnet nostromo.synchro.net";
      scn = "ztelnet scn.org";
      ll = "ls -l";
      ".." = "cd ..";
    };
    initExtra = ''
      source <(doctl completion bash)
    '';
    # ddate
    # fortune -s goedel
    # echo Greetings, Professor Falken.
    # screenfetch
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.irssi = {
    enable = true;
    networks = {
      freenode = {
        nick = "dwd";
        server = {
          address = "chat.freenode.net";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          nixos.autoJoin = true;
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Dan Dart";
    userEmail = "git@dandart.co.uk";
    extraConfig = ''
      [pull]
        rebase = false
    '';
    # signingkey = 39A8DF97
    # gpgsign = true
    # crypt stuff
  };

  programs.vim = {
    enable = true;
    # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
    plugins = with pkgs.vimPlugins; [
      onedark-vim
      fugitive
      gundo
      nerdtree
      haskell-vim
      # node
      polyglot
      taglist
      vim-unimpaired
    ];
    settings = {
      background = "dark";
      backupdir = [
        "~/.vim/backup"
      ];
      directory = [
        "~/.vim/tmp"
      ];
      expandtab = true; # no real tabs please!
      hidden = true; # you can change buffers without saving
      ignorecase = true; # case insensitive by default
      # mouse = "a" # use mouse everywhere
      number = true; # turn on line numbers
      shiftwidth = 4; # auto-indent amount when using cindent, >>, << and stuff like that
      smartcase = true; # if there are caps, go case-sensitive
      tabstop = 4; # real tabs should be 8, and they will show with
    };
    extraConfig = ''
      au BufNewFile,BufRead *.phtml set filetype=php
      autocmd bufwritepost .vimrc source $MYVIMRC
      " autocmd FileType php DoMatchParen " set auto-highlighting of matching brackets for php only
      " autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue " set auto-highlighting of matching brackets for php only
      colorscheme onedark
      filetype indent on
      filetype plugin indent on " load filetype plugins/indent settings
      ":imap ;WEM dev@jolharg.com
      :imap ;EM git@dandart.co.uk
      :imap ;D die(__FILE__ . ' : ' . __LINE__);
      :imap ;L console.log()
      " inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
      let b:match_ignorecase = 1 " case is stupid
      let perl_extended_vars=1 " highlight advanced perl vars inside strings
      " let php_sql_query=1
      " let php_htmlInStrngs=1
      " let php_noShortTags=1
      " let php_folding=1
      let tlist_aspjscript_settings = 'asp;f:function;c:class' " just functions and classes please
      let tlist_aspvbs_settings = 'asp;f:function;s:sub' " just functions and subs please
      let Tlist_Auto_Open=0 " let the tag list open automagically
      let Tlist_Auto_Highlight_Tag = 1
      let Tlist_Auto_Update = 1
      let Tlist_Compact_Format = 1 " show small menu
      let Tlist_Ctags_Cmd = 'ctags' " location of ctags
      "let Tlist_Display_Prototype = 1
      let Tlist_Display_Tag_Scope = 1        
      let Tlist_Enable_Fold_Column = 0 " do show folding tree
      let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
      let Tlist_Exit_OnlyWindow = 1
      " let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
      let Tlist_File_Fold_Auto_Close = 1
      let tlist_php_settings = 'php;c:class;d:constant;f:function' " don't show variables in freaking php
      let Tlist_Show_One_File = 1    
      let Tlist_Sort_Type = "name" " order by
      let Tlist_Use_Right_Window = 1 " split to the right side of the screen
      let tlist_vb_settings = 'asp;f:function;c:class' " just functions and classes please
      let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always) read my functions        
      map <C-h> <C-w>h
      map <C-j> <C-w>j
      map <C-k> <C-w>k
      map <C-l> <C-w>l
      map <F2> :wa<CR>
      map <F2><F2> :wqa!<CR> 
      " map <Esc><Esc> :qa!<CR>
      " map <F5> :term stack runhaskell %:p<CR>
      " map <F6> :term stack ghci %:p<CR>
      map $1 :s/^/# /<CR>
      map $2 :s/^# //<CR>
      "map <down> <ESC>:bn<RETURN>
      map <tab> <ESC>:NERDTreeToggle<RETURN>
      " map <right> <ESC>:Tlist<RETURN>
      "map <up> <ESC>:bp<RETURN>
      map <C-t> <ESC>:term<RETURN>
      nmap ,w :x<CR>
      nmap ,q :q!<CR>
      nmap <C-N><C-N> :set invnumber<CR>
      nmap <C-P><C-P> :set invpaste<CR>
      nmap <C-T><C-T> :TlistToggle<CR>
      nmap <C-right> :vert term<CR> 
      nmap <leader>l :set list!<CR> " Shortcut to rapidly toggle `set list`
      nmap <leader>v :tabedit $MYVIMRC<CR>
      nnoremap <Esc>P P'[v' ]=
      " nnoremap <C-D> :call PhpDocSingle()<CR>
      " nnoremap <F5> :GundoToggle<CR>
      noremap <S-space> <C-b> " space / shift-space scroll in normal mode
      noremap <space> <C-f>
      set autochdir " always switch to the current file directory
      set backspace=indent,eol,start " make backspace a more flexible
      set backup " make backup files
      set clipboard+=unnamed " share windows clipboard
      set completeopt= " don't use a pop up menu for completions
      set cpoptions=aABceFsmq
      "             |||||||||
      "             ||||||||+-- When joining lines, leave the cursor
      "             |||||||      between joined lines
      "             |||||||+-- When a new match is created (showmatch)
      "             ||||||      pause for .5
      "             ||||||+-- Set buffer options when entering the
      "             |||||      buffer
      "             |||||+-- :write command updates current file name
      "             ||||+-- Automatically add <CR> to the last line
      "             |||      when using :@r
      "             |||+-- Searching continues at the end of the match
      "             ||      at the cursor position
      "             ||+-- A backslash has no special meaning in mappings
      "             |+-- :write updates alternative file name
      "             +-- :read updates alternative file name
      "set cursorcolumn " highlight the current column
      "set cursorline " highlight current line
      set errorformat=%m\ in\ %f\ on\ line\ %l
      set fileformats=unix,dos,mac " support all three, in this order
      set formatoptions=rq " Automatically insert comment leader on return, and let gq format comments
      set guifont=Terminal\ 8
      set incsearch " BUT do highlight as you type your search phrase
      set infercase " case inferred by default
      set iskeyword+=_,$,@,%,# " none of these are word dividers " (XXX: #VIM/tpope warns this line could break things)
      set laststatus=2 " always show the status line
      set lazyredraw " do not redraw while running macros
      set linespace=0 " don't insert any extra pixel lines betweens rows
      " set list " (on) we do want to show tabs, to ensure we get them out of my files
      " set listchars=tab:>-,trail:- " show tabs and trailing
      set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs
      " set makeprg=php\ -l\ %
      set matchtime=5 " how many tenths of a second to blink matching brackets for
      set nocompatible " explicitly get out of vi-compatible mode
      set noerrorbells " don't make noise
      set noexrc " don't use local version of .(g)vimrc, .exrc
      set nohlsearch " do not highlight searched for phrases
      set nostartofline " leave my cursor where it was
      set novisualbell " don't blink
      " set nowrap " do not wrap line
      set numberwidth=5 " We are good up to 99999 lines
      set report=0 " tell us when anything is changed via :...
      set ruler " Always show current positions along the bottom
      " set runtimepath^=~/.vim/bundle/node
      set scrolloff=10 " Keep 10 lines (top/bottom) for scope
      set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
      set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
      set showcmd " show the command being typed
      set showmatch " show matching brackets
      set showtabline=2
      set sidescrolloff=10 " Keep 5 lines at the size
      set smartindent
      set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
      set splitbelow
      set splitright
      set statusline=%F%m%r%h%w[%L]=[%{&ff}]%y[%p%%][%04l,%04v]
      "              | | | | |  |   |      |  |     |    |
      "              | | | | |  |   |      |  |     |    + current
      "              | | | | |  |   |      |  |     |       column
      "              | | | | |  |   |      |  |     +-- current line
      "              | | | | |  |   |      |  +-- current % into file
      "              | | | | |  |   |      +-- current syntax in
      "              | | | | |  |   |          square brackets
      "              | | | | |  |   +-- current fileformat
      "              | | | | |  +-- number of lines
      "              | | | | +-- preview flag in square brackets
      "              | | | +-- help flag in square brackets
      "              | | +-- readonly flag in square brackets
      "              | +-- rodified flag in square brackets
      "              +-- full path to file in the buffer
      set undolevels=1000
      set updatecount=50
      set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
      "             | | | | | | | | |
      "             | | | | | | | | +-- "]" Insert and Replace
      "             | | | | | | | +-- "[" Insert and Replace
      "             | | | | | | +-- "~" Normal
      "             | | | | | +-- <Right> Normal and Visual
      "             | | | | +-- <Left> Normal and Visual
      "             | | | +-- "l" Normal and Visual (not recommended)
      "             | | +-- "h" Normal and Visual (not recommended)
      "             | +-- <Space> Normal and Visual
      "             +-- <BS> Normal and Visual
      set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
      set wildmenu " turn on command line completion wild style
      set wildmode=list:longest " turn on wild mode huge list
      set wrapscan
      syntax on " syntax highlighting on
      " vnoremap <C-D> :call PhpDocRange()<CR>
      if has("gui_running")
          colorscheme onedark
          "colorscheme metacosm " my color scheme (only works in GUI)
          set columns=180 " perfect size for me
          set guifont=Consolas:h8 " My favorite font
          set guioptions=ce 
          "              ||
          "              |+-- use simple dialogs rather than pop-ups
          "              +  use GUI tabs, not console style tabs
          set lines=65 " perfect size for me
          " set mousehide " hide the mouse cursor when typing
          map <F8> <ESC>:set guifont=Consolas:h8<CR>
          map <F9> <ESC>:set guifont=Consolas:h10<CR>
          map <F10> <ESC>:set guifont=Consolas:h12<CR>
          map <F11> <ESC>:set guifont=Consolas:h16<CR>
          map <F12> <ESC>:set guifont=Consolas:h20<CR>
      endif
    '';
  };

  services.gpg-agent = {
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.home-manager = {
    path = "";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
