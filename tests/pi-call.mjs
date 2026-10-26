// Supply pi's tool-call event to the real role extension without a model call.
import assert from "node:assert/strict"
import { readFileSync } from "node:fs"
import { pathToFileURL } from "node:url"

const extension = await import(pathToFileURL(process.argv[2]))
let judge
extension.default({
  on(event, callback) {
    assert.equal(event, "tool_call")
    judge = callback
  },
})
const call = JSON.parse(readFileSync(0, "utf8"))
const refusal = judge({ toolName: "bash", input: call.tool_input })
if (refusal?.block) {
  console.error(refusal.reason)
  process.exit(2)
}
