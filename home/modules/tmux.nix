{...}: {
  # Tmux terminal multiplexer configuration
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = false;
    terminal = "screen-256color";

    extraConfig = ''
# Tmux General Config
    set -g default-terminal "screen-256color"
    set -g base-index 1 # Start indexing windows at 1 instead of 0
    set -g renumber-windows on # renumber all windows when any window is closed
    set -g status-position top # Set the position of tmux status bar to top of screen
    set -g pane-active-border-style 'fg=magenta,bg=default'
    set -g pane-border-style 'fg=brightblack,bg=default'


# Tmux Rebinds

    set -g prefix C-a
    is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"'
    bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
    bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
    bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
    bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
    bind * setw synchronize-panes

# Resize the current pane using Alt + direction
    bind -n M-k resize-pane -U 5
    bind -n M-j resize-pane -D 5
    bind -n M-h resize-pane -L 5
    bind -n M-l resize-pane -R 5

    set -g @fingers-key Space # Set fast fingers to prefix-Space

    set-option -g mouse on

###Setup Tmux Copy Mode
#Use vim keybindings in copy mode
    setw -g mode-keys vi

# List of Plugins
# prefix-I will install plugins and reload tmux env
    set -g @plugin 'tmux-plugins/tpm' # Tmux Plugin Manager
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-yank' # Copy to the system clipboard in tmux.
    set -g @plugin 'tmux-plugins/tmux-resurrect' # Enables the ability to save/restore tmux sessions
#set -g @plugin 'Morantron/tmux-fingers' # prefix-F will start plugin. shfit-{a-z} to copy/paste value
    set -g @plugin 'sainnhe/tmux-fzf' # Tmux fuzzy finder + Extra goodies
    set -g @plugin 'wfxr/tmux-fzf-url' # Plugin for opening urls quickly without mouse
    set -g @plugin 'catppuccin/tmux'
    set -g @plugin 'omerxx/tmux-sessionx' # Fuzzy Tmux session manager with preview
    set -g @plugin 'tmux-plugins/tmux-continuum' # Continous saving of the tmux environment/automatic restore
#set -g @plugin 'tmux-plugins/tmux-battery' # Battery module for catppuccin
#set -g @plugin 'tmux-plugins/tmux-cpu' # CPU module for catppuccin

# Plugin settings
    set -g @catppuccin_flavour 'frappe' # or frappe, macchiato, mocha
    set -g @catppuccin_window_left_separator ""
    set -g @catppuccin_window_right_separator " "
    set -g @catppuccin_window_middle_separator " █"
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_default_fill "number"
    set -g @catppuccin_window_default_text "#W"
    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
    set -g @catppuccin_status_modules_left "session"
    set -g @catppuccin_status_left_separator  " "
    set -g @catppuccin_status_right_separator " "
    set -g @catppuccin_status_right_separator_inverse "no"
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_connect_separator "no"
    set -g @catppuccin_directory_text "#{b:pane_current_path}"
    set -g @catppuccin_date_time_text "%H:%M"
    set -g @continuum-restore 'on'
#set -g @catppuccin_status_modules_right "... battery ..."
#set -g @catppuccin_status_modules_right "... cpu ..."


# Initalize TMUX plugin manager (Keep this at the very bottom of tmux.conf)

    run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  # Enable catppuccin theming for tmux.
  catppuccin = {
    tmux = {
      enable = true;
      extraConfig = ''
        set -g @catppuccin_flavor "macchiato"
        set -g @catppuccin_status_background "none"

        set -g @catppuccin_window_current_number_color "#{@thm_peach}"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_current_text_color "#{@thm_bg}"
        set -g @catppuccin_window_number_color "#{@thm_blue}"
        set -g @catppuccin_window_text " #W"
        set -g @catppuccin_window_text_color "#{@thm_surface_0}"
        set -g @catppuccin_status_left_separator "█"

        set -g status-right "#{E:@catppuccin_status_host}#{E:@catppuccin_status_date_time}"
        set -g status-left ""
      '';
    };
  };
}
