;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p4-dangeon)
    (:domain DangeonQ4)
    (:objects
        cell1 cell2 cell5 cell6 cell3 cell4 cell7 cell8 cell9 cell10 cell13 cell17 cell18 cell16 cell12 cell11 cell14 cell19 cell15 - cells
        sword1 sword2 sword3 - swords
        hero1 hero2 - heroes
    )
    (:init

        ;Initial Hero Location
        (at-hero hero1 cell1)
        (at-hero hero2 cell18)

        ;He starts with a free arm
        (arm-free hero1)
        (arm-free hero2)

        ;action bar
        (action_bar hero1 hero2)
        (action_bar hero2 hero1)

        ;current turn
        (Whos_turn hero1)

        ;Initial location of the swords
        (at-sword sword1 cell5)
        (at-sword sword2 cell13)
        (at-sword sword3 cell10)

        ;Initial location of Monsters
        (has-monster cell2)
        (has-monster cell8)
        (has-monster cell14)
        (has-monster cell7)

        ;Initial lcocation of Traps
        (has-trap cell3)
        (has-trap cell9)
        (has-trap cell11)
        (has-trap cell16)
        (has-trap cell17)

        ;Graph Connectivity
        
        
        (connected cell1 cell2)
        (connected cell2 cell1)
        (connected cell1 cell5)
        (connected cell5 cell1)
        (connected cell2 cell5)
        (connected cell5 cell2)
        (connected cell2 cell6)
        (connected cell6 cell2)
        (connected cell2 cell3)
        (connected cell3 cell2)
        (connected cell3 cell4)
        (connected cell4 cell3)
        (connected cell3 cell6)
        (connected cell6 cell3)
        (connected cell3 cell7)
        (connected cell7 cell3)
        (connected cell4 cell7)
        (connected cell7 cell4)
        (connected cell5 cell8)
        (connected cell8 cell5)
        (connected cell6 cell8)
        (connected cell8 cell6)
        (connected cell6 cell9)
        (connected cell9 cell6)
        (connected cell7 cell9)
        (connected cell9 cell7)
        (connected cell7 cell10)
        (connected cell10 cell7)
        (connected cell10 cell13)
        (connected cell13 cell10)
        (connected cell9 cell13)
        (connected cell13 cell9)
        (connected cell13 cell17)
        (connected cell17 cell13)
        (connected cell17 cell18)
        (connected cell18 cell17)
        (connected cell16 cell17)
        (connected cell17 cell16)
        (connected cell12 cell13)
        (connected cell13 cell12)
        (connected cell8 cell12)
        (connected cell12 cell8)
        (connected cell8 cell11)
        (connected cell11 cell8)
        (connected cell12 cell11)
        (connected cell11 cell12)
        (connected cell12 cell14)
        (connected cell14 cell12)
        (connected cell11 cell19)
        (connected cell19 cell11)
        (connected cell14 cell19)
        (connected cell19 cell14)
        (connected cell9 cell10)
        (connected cell10 cell9)
        (connected cell15 cell19)
        (connected cell19 cell15)
        
        (set_goal hero1 cell15)
        (set_goal hero2 cell4)
    )
        (:goal
            (and
                ;Hero's Goal Location
                (at-hero hero1 cell15)
                (at-hero hero2 cell4)
            )
        )
    )