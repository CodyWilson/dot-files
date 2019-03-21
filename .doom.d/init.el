;;; init.el -*- lexical-binding: t; -*-
;; Copy me to ~/.doom.d/init.el or ~/.config/doom/init.el, then edit me!

(doom! :feature
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       eval              ; run code, run (also, repls)
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       (lookup           ; helps you navigate your code and documentation
        +docsets)        ; ...or in Dash docsets locally
       snippets          ; my elves. They type so I don't have to
       ;;spellcheck        ; tasing you for misspelling mispelling
       ;;syntax-checker    ; tasing you for every semicolon you forget
       workspaces        ; tab emulation, persistence & separate workspaces

       :completion
       (company
        ;+auto
        +childframe
        )           ; the ultimate code completion backend
       ;;helm              ; the *other* search engine for love and life
       ;;ido              ; the other *other* search engine...
       (ivy +fuzzy)              ; a search engine for love and life

       :ui
       ;;deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ;;doom-modeline     ; a snazzy Atom-inspired mode-line
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       evil-goggles      ; display visual hints when editing in evil
       ;;fci               ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ;;neotree           ; a project drawer, like NERDTree for vim
       treemacs          ; a project drawer, like neotree but cooler
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       ;;(pretty-code +fira)       ; replace bits of code with pretty symbols
       ;;tabbar            ; FIXME an (incomplete) tab bar for Emacs
       ;;unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       ;;indent-guides

       :editor
       ;;(format +onsave)  ; automated prettiness
       ;;lispy             ; vim for lisp, for people who dont like vim
       multiple-cursors  ; editing in many places at once
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       fold

       :emacs
       (dired            ; making dired pretty [functional]
       +ranger         ; bringing the goodness of ranger to dired
       ;;+icons          ; colorful icons for dired-mode
        )
       ;;ediff             ; comparing files in Emacs
       electric          ; smarter, keyword-based electric-indent
       ;;eshell            ; a consistent, cross-platform shell (WIP)
       ;;hideshow          ; basic code-folding support
       imenu             ; an imenu sidebar and searchable code index
       ;;term              ; terminals in Emacs
       vc                ; version-control and Emacs, sitting in a tree

       :tools
       ;;ansible
       ;;docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       gist              ; interacting with github gists
       macos             ; MacOS-specific commands
       make              ; run make tasks from Emacs
       (magit +forge)             ; a git porcelain for Emacs
       ;;password-store    ; password manager for nerds
       ;;pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       ;;rgb               ; creating color strings
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp
       ;;wakatime
       flyspell
       flycheck

       :lang
       assembly          ; assembly for fun or debugging
       (cc +irony +rtags); C/C++/Obj-C madness
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;csharp            ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       ;;(haskell +intero) ; a language that's lazier than I am
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;ocaml             ; an objective camel
       (org              ; organize your plain life in plain text
        +attach          ; custom attachment system
        +babel           ; running code in org
        +capture         ; org-capture in and outside of Emacs
        +export          ; Exporting org to whatever you want
        +present)        ; Emacs for presentations
       php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       python            ; beautiful is better than ugly
       ;;rest              ; Emacs as a REST client
       ;;ruby              ; 1.step do {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish)        ; she sells (ba|z|fi)sh shells on the C xor
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       web               ; the tubes

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;(email +gmail)    ; emacs as an email client
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought
       ;;(write            ; emacs as a word processor (latex + org + markdown)
       ;; +wordnut         ; wordnet (wn) search
       ;; +langtool)       ; a proofreader (grammar/style check) for Emacs

       :collab
       ;;floobits          ; peer programming for a price
       ;;impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; config. Use it as a reference for your own modules.
       (default +bindings +smartparens))
