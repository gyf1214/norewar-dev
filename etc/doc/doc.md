Documentation for NoreWar
=========================

Introduction
------------
NoreWar is the abbreviation for "Network Core War". 

Two teams of robots compete on a 16x16 field. Each team controlled by a *.aic script. It is initialized with a "meta-robot" shipped with all codes. It starts with random position and random face. Generally, robots may move, change directions, reproduce, inject code, etc. Each operation takes some time. A robot can only read or write the robot in its front when the command is executed. This robot will be referred to as ***target robot*** in the documentation.

The goal of a team is to exterminate its enemy. They cannot, however, directly kill any robot. Instead, they can inject code into enemies and tell them to "commit suicide".

The match can be very tight sometimes. When a certain time limit (currently 65536) is reached, the match will be terminated whether their is a winner or not.

Welcome to join the game at [http://norewar.shsts.org/](http://norewar.shsts.org/)!

Structure of Program
--------------------

    :const1 val1
    :const2 val2

    @tag1
        command1
        command2

    @tag2
        command3
        command4

    @tag3

Constants, Variables and Tags
-----------------------------

Constants are referred to by `:const`. In the code above, `:const val` defines constants to improve readability of code. In practical use, it is often used to define status of robots like `on` and `off` or type of robots like `empty`, `enemy` and `friend`.

Variables are referred to by `$var`. They can be generated and modified using commands `scan` or `set` (See section "Commands").

Tags are referred to by `@tag`. `@tag`s indicate relative positions in the code, and are used to jump within code or trasfer lines of code to other robots. They are replaced during preprocessing, and don't actually exist when the code is being executed.

Commands
--------

**List of commands:**

*Notice: the following `<>`s are used to wrap parameters. They don't appear in codes. See demo ([https://github.com/gyf1214/norewar-dev/blob/master/etc/demo/](https://github.com/gyf1214/norewar-dev/blob/master/etc/demo/)) for coding references.*

* `move` -- Move one step forward.
* `jump <label>` -- Jump to a label in the code.
* `turn <direction>` -- Turn `<direction>`. `<direction>` is either 0 or 1, 0 for turning left, and 1 for turning right.
* `die` -- Die.
* `nop` -- Do nothing. Used to occupy lines but takes time.
* `ecomp <val1> <val2>` -- Compare the two values. Execute the next line if they are equal, the second next line otherwise.
* `say <message1> <message2> ...` -- Output debug information. Not ready for use currently.
* `set <var> <val>` -- Assign the value to the variable.
* `inc <var>` -- Increment the variable by 1.
* `dec <var>` -- Decrement the variable by 1.
* `power <status>` -- Power the target robot on or off. `<status>` is 1 for off and 2 for on.
* `trans <start-tag> <end-tag> ~<dest-tag>` -- Inject the code between `<start-tag>` and `<end-tag>` into the target robot. The code will be inserted after the location of <dest-tag> in the target robot. Don't miss the `~` before `<dest-tag>`.
* `scan <var>` -- Read the identity of the target robot into `<var>`. `<var>` will be assigned with `0` for empty, `1` for enemy, and `2` for friend.
* `create <type>` -- Create a robot of the given type. The son's initial position is one step ahead of its parent's current position (and so it is the parent's target robot right after its creation), and its initial face is the same as its parent's current face. For the use of `<type>`, refer to section "Robot types". Note that the robot has no code when created. Use `trans` command to give it part or all of the parent's code.

**Execution time:**

| Command      | Time |
| ------------ | :--: |
| `move`       | 10   |
| `jump`       | 1    |
| `turn`       | 5    |
| `die`        | 100  |
| `nop`        | 100  |
| `ecomp`      | 2    |
| `say`        | 1    |
| `set`        | 1    |
| `inc`        | 1    |
| `dec`        | 1    |
| `power`      | 10   |
| `scan`       | 20   |

The execution time of `trans` and `create` is dependant on specific parameters.

The time consumption of `trans` is determined by the expression `10 * (Math.log(y - x, 2).ceil + 1)`, in which `x` and `y` are the locations of `<start-tag>` and `<end-tag>` in the code. To make it clear, the time approximately correlates with the logarithm to 2 of the number of lines to be tranferred.

For `create`, refer to section "Robot Types".


Robot Types
-----------

| Type | Nickname | Creating Time |
| ---- | -------- | ------------- |
| `0`  | Wood     | 20            |
| `1`  | Fighter  | 30            |
| `2`  | Senior   | 60            |
| `3`  | Creature | 110           |

Different types of robots require different time to create, and have different permissions. Generally, the longer it takes to create, the more permission it has.

**Permissions:**

| Command      | Wood | Fighter | Senior | Creature |
| ------------ | :--: | :-----: | :----: | :------: |
| `move`       | +    | +       | +      | +        |
| `jump`       | +    | +       | +      | +        |
| `turn`       | +    | +       | +      | +        |
| `die`        | +    | +       | +      | +        |
| `nop`        | +    | +       | +      | +        |
| `ecomp`      | +    | +       | +      | +        |
| `say`        | +    | +       | +      | +        |
| `set`        | +    | +       | +      | +        |
| `inc`        | +    | +       | +      | +        |
| `dec`        | +    | +       | +      | +        |
| `power`      | -    | +       | +      | +        |
| `trans`      | -    | +       | +      | +        |
| `scan`       | -    | -       | +      | +        |
| `create`     | -    | -       | -      | +        |

*"+" indicates the command is available, "-" otherwise.*

For the usage of the commands, refer to section "Commands".