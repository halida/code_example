# target   prerequisite             commands
# ----------------------------------------------------
house:     roof plumbing electrics; @echo $@; touch $@
plumbing:  pipes basement;          @echo $@; touch $@
roof:      walls;                   @echo $@; touch $@
electrics: walls wires;             @echo $@; touch $@
walls:     basement bricks;         @echo $@; touch $@
pipes:     ;                        @echo $@; touch $@
basement:  ;                        @echo $@; touch $@
bricks:    ;                        @echo $@; touch $@
wires:     ;                        @echo $@; touch $@
