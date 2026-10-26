// The reviewer's limits under pi. pi runs no hook of `.claude/settings.json`,
// so each bash call is handed to the same `refuse.sh` Claude Code and Codex
// run, described as Claude Code describes it: the refusals are written once.
import { execFileSync } from "node:child_process"
import { fileURLToPath } from "node:url"

const REFUSE = fileURLToPath(new URL("../../.claude/hooks/refuse.sh", import.meta.url))

export default function (pi) {
  pi.on("tool_call", (event) => {
    if (event.toolName !== "bash") return undefined
    const call = JSON.stringify({ tool_name: "Bash", tool_input: { command: String(event.input?.command ?? "") } })
    try {
      execFileSync("sh", [REFUSE], { input: call, stdio: ["pipe", "ignore", "pipe"] })
      return undefined
    } catch (error) {
      const reason = String(error.stderr ?? "").trim()
      return { block: true, reason: reason || `reviewer: ${REFUSE} could not judge this call` }
    }
  })
}
