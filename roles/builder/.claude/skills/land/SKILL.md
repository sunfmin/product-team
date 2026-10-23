---
name: land
description: Put a built issue's PR on the landing train. Use when the brief you were started with names `land` as the skill to perform.
---

# land

Your brief gives the steps and the commands, in order. Follow them as written; this says only how.

- **A conflict** is resolved so that both sides' intent survives: the change this PR makes, and the change it conflicts with. Read both before touching either. Then commit the merge and run the gate again, as the brief says.
- **A red gate after a merge** means the two changes do not work together. Fix what joins them. When that would change what either one does, stop: say on the issue, in a comment, which two changes conflict and why neither can give way.
- **Every gate and landing command runs to its end inside your turn**, as the brief writes it, never wrapped in `exclusive` again: in the foreground with a time limit that covers it, or in the background with its output to a file, then waited on with bounded foreground checks until it has finished. Your run ends with your turn, and nothing wakes you when a background command finishes. A full suite or build you run yourself to find what joins two changes runs as `afkconvoy exclusive -- <command>`.
- **Joined is where you stop.** The train lands the PR; you do not wait for it.
