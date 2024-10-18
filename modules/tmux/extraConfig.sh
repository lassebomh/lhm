# Change the prefix key to C-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

bind -n M-h previous-window
bind -n M-l next-window
bind -n M-w kill-pane
bind -n M-n new-window

# Use | and - to split windows
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %
