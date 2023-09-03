(define (domain DangeonQ4)

    (:requirements :typing :negative-preconditions
    )

    (:types
        swords cells heroes
    )

    (:predicates
        ;Hero's cell location
        (at-hero ?h - heroes ?loc - cells)

        ;Sword cell location
        (at-sword ?s - swords ?loc - cells)

        ;Indicates if a cell location has a monster
        (has-monster ?loc - cells)

        ;Indicates if a cell location has a trap
        (has-trap ?loc - cells)

        ;Indicates if a chell or sword has been destroyed
        (is-destroyed ?obj)

        ;connects cells
        (connected ?from ?to - cells)

        ;Hero's hand is free
        (arm-free ?h - heroes)

        ;Hero's holding a sword
        (holding ?h - heroes ?s - swords)

        ;It becomes true when a trap is disarmed
        (trap-disarmed ?loc - cells)

        ;Determine which hero's turn it is
        (Whos_turn ?h - heroes)

        ;Round action bar, which indicates the order of the hero's actions in the current state
        (action_bar ?h1 ?h2 - heroes)

        ;Transition to next turn
        (next_turn)

        ;Determine if the hero has arrived at the destination
        (reached-goal ?h - heroes)

        ;Setting the hero's destination
        (set_goal ?h - heroes ?c - cells)

    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no trap in current loc, and 
    ;    - destination does not have a trap/monster/has-been-destroyed
    ;Effects move the hero, and destroy the original cell. No need to destroy the sword.
    (:action move
        :parameters (?h - heroes ?from ?to - cells)
        :precondition (and
            (at-hero ?h ?from)
            (Whos_turn ?h)
            (not (reached-goal ?h))
            (connected ?from ?to)
            (not(has-trap ?from))
            (forall
                (?otherh - heroes)
                (not(at-hero ?otherh ?to)))
            (not(has-monster ?to))
            (not (has-trap ?to))
            (not (is-destroyed ?to))
            (not(next_turn))
        )

        :effect (and
            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)
            (next_turn)
        )
    )

    ;When this action is executed, the hero gets into a location with a trap
    (:action move-to-trap
        :parameters (?h - heroes ?from ?to - cells)
        :precondition (and
            (at-hero ?h ?from)
            (Whos_turn ?h)
            (not (reached-goal ?h))
            (connected ?from ?to)
            (forall
                (?otherh - heroes)
                (not(at-hero ?otherh ?to)))
            (not (has-trap ?from))
            (has-trap ?to)
            (arm-free ?h)
            (not(next_turn))
        )
        :effect (and
            (at-hero ?h ?to)
            (trap-disarmed ?to)
            (is-destroyed ?from)
            (not (at-hero ?h ?from))
            (next_turn)
        )
    )

    ;When this action is executed, the hero gets into a location with a monster
    (:action move-to-monster
        :parameters (?h - heroes ?from ?to - cells ?s - swords)
        :precondition (and
            (at-hero ?h ?from)
            (Whos_turn ?h)
            (not (reached-goal ?h))
            (forall
                (?otherh - heroes)
                (not(at-hero ?otherh ?to)))
            (connected ?from ?to)
            (not (has-trap ?from))
            (has-monster ?to)
            (holding ?h ?s)
            (not(next_turn))
        )
        :effect (and
            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)
            (next_turn)
        )
    )

    ;Hero picks a sword if he's in the same location
    (:action pick-sword
        :parameters (?h - heroes ?loc - cells ?s - swords)
        :precondition (and
            (at-hero ?h ?loc)
            (Whos_turn ?h)
            (not (reached-goal ?h))
            (at-sword ?s ?loc)
            (arm-free ?h)
            (not(next_turn))
        )
        :effect (and
            (holding ?h ?s)
            (not (at-sword ?s ?loc))
            (not (arm-free ?h))
            (next_turn)
        )
    )

    ;Hero destroys his sword. 
    (:action destroy-sword
        :parameters (?h - heroes ?loc - cells ?s - swords)
        :precondition (and
            (Whos_turn ?h)
            (holding ?h ?s)
            (at-hero ?h ?loc)
            (not (reached-goal ?h))
            (not(has-monster ?loc))
            (not(has-trap ?loc))
            (not(next_turn))
        )
        :effect (and
            (not (holding ?h ?s))
            (is-destroyed ?s)
            (arm-free ?h)
            (next_turn)
        )
    )

    ;Hero disarms the trap with his free arm
    (:action disarm-trap
        :parameters (?h - heroes ?loc - cells)
        :precondition (and
            (at-hero ?h ?loc)
            (not (reached-goal ?h))
            (Whos_turn ?h)
            (has-trap ?loc)
            (arm-free ?h)
            (not(next_turn))
        )
        :effect (and
            (trap-disarmed ?loc)
            (not (has-trap ?loc))
            (next_turn)
        )
    )

    ;Perform conversion round operations
    (:action turn_next
        :parameters (?h1 ?h2 - heroes)
        :precondition (and
            (Whos_turn ?h1)
            (action_bar ?h1 ?h2)
            (next_turn)

        )
        :effect (and
            (not (Whos_turn ?h1))
            (Whos_turn ?h2)
            (not (next_turn))
        )
    )

    ;Confirmation of arrival at goal point
    (:action mark-goal-reached
        :parameters (?h - heroes ?loc - cells)
        :precondition (and
            (at-hero ?h ?loc)
            (set_goal ?h ?loc)
            (Whos_turn ?h)
            (not (reached-goal ?h))
        )
        :effect (reached-goal ?h)
    )

)