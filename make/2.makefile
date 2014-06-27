# An explicit rule assigns the commands for several targets
house plumbing roof electrics walls pipes basement bricks wires: ; @echo $@

# Implicit rules state the prerequisites
house:     roof plumbing electrics
plumbing:  pipes basement
roof:      walls
electrics: walls wires
walls:     basement bricks
