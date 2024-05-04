/*
This is a nix expression to build Emacs and some Emacs packages I like
from source on any distribution where Nix is installed. This will install
all the dependencies from the nixpkgs repository and build the binary files
without interfering with the host distribution.

https://nixos.org/manual/nixos/stable/index.html#module-services-emacs

To build the project, type the following from the current directory:

$ nix-build emacs.nix

To run the newly compiled executable:

$ ./result/bin/emacs
*/

# The first non-comment line in this file indicates that
# the whole file represents a function.
{ pkgs ? import <nixpkgs> {} }:

let
  # The let expression below defines a myEmacs binding pointing to the
  # current stable version of Emacs. This binding is here to separate
  # the choice of the Emacs binary from the specification of the
  # required packages.
  myEmacs = pkgs.emacs29-pgtk;
  # This generates an emacsWithPackages function. It takes a single
  # argument: a function from a package set to a list of packages
  # (the packages that will be available in Emacs).
  emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
# The rest of the file specifies the list of packages to install. In the
# example, two packages (magit and zerodark-theme) are taken from
# MELPA stable.
emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
  magit          # ; Integrate git <C-x g>
  zerodark-theme # ; Nicolas' theme
  vertico
  marginalia
  counsel
  projectile
  counsel-projectile
  avy
  company
  edit-server
  flycheck
  helm
  iedit
  yasnippet
  solarized-theme
  tron-legacy-theme
  vscode-dark-plus-theme
  meow
  sly
  # sly-asdf
  # sly-quicklisp
  orderless
  corfu
  markdown-mode
  deadgrep
  nix-mode
  paredit
  popper
  treemacs-all-the-icons
  compile-multi-all-the-icons
])
# Two packages (undo-tree and zoom-frm) are taken from MELPA.
++ (with epkgs.melpaPackages; [
  # undo-tree      # ; <C-x u> to show the undo tree
  zoom-window
  all-the-icons
  all-the-icons-completion
  all-the-icons-dired
  all-the-icons-nerd-fonts
  all-the-icons-ibuffer
  avy
  avy-menu
  avy-zap
  org-superstar
  org-super-agenda
  multiple-cursors
  pdf-tools
  w3m
  dired-sidebar
  # begin racket programming
  racket-mode
  geiser
  geiser-racket
  quack
  scribble-mode
  # end racket programming
])
# Three packages are taken from GNU ELPA.
++ (with epkgs.elpaPackages; [
  auctex         # ; LaTeX mode
  ef-themes
  denote
  eglot
  # vertico
  # beacon         # ; highlight my cursor when scrolling
  nameless       # ; hide current package name everywhere in elisp code
])
# notmuch is taken from a nixpkgs derivation which contains an Emacs mode.
++ [
  pkgs.notmuch   # From main packages set
  pkgs.lispPackages.quicklisp

])
