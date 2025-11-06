# left: 
# right: 

# Status
set -g status-bg default
set-option -g status-style bg=default

# Bars
set -g status-bg "#1E1A24"
set -g status-fg "#EEEAF1"
set -g status-left "#[fg=#14111B,bg=#EEEAF1]  #S #[fg=default,bg=default,nobold,noitalics,nounderscore]"
set -g status-right '#[fg=#E598B8,bg=default,nobold,noitalics,nounderscore]#[fg=#EEEAF1,bg=#E598B8,nobold,noitalics] #(TZ="America/Los_Angeles" date +%H:%M)  #[fg=#EEEAF1,bg=#E598B8,nobold,noitalics,nounderscore]#[fg=#14111B,bg=#EEEAF1,nobold] #H  '

set -g pane-active-border-style "bg=default fg=#E598B8"
set -g pane-border-style "bg=default fg=#2E2B3D"

# Windows
set -g window-status-format "#[fg=#1E1A24,bg=#23202B]#[fg=#EEEAF1,bg=#23202B,nobold,noitalics,nounderscore] #I#[fg=#EEEAF1,bg=#23202B,nobold,noitalics,nounderscore]: #W #[fg=#23202B,bg=#1E1A24,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=#1E1A24,bg=#E598B8]#[fg=#EEEAF1,bg=#E598B8,nobold,noitalics,nounderscore] #I#[fg=#EEEAF1,bg=#E598B8,nobold,noitalics,nounderscore]: #W #[fg=#E598B8,bg=#1E1A24,nobold,noitalics,nounderscore]"
set -g window-status-separator ""

set -g status-justify left
