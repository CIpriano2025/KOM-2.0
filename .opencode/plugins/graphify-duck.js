import { existsSync } from "fs";
import { join } from "path";
import { execSync } from "child_process";

export const GraphifyDuckPlugin = async ({ directory }) => {
  return {
    "tool.execute.after": async (input, output) => {
      if (input.tool !== "bash") return;
      const cmd = (input.args?.command || "").trim();
      if (!cmd.includes("graphify")) return;
      const afterGraphify = cmd.slice(cmd.indexOf("graphify") + 9).trim();
      if (afterGraphify !== "update ." && afterGraphify !== "." && !afterGraphify.startsWith("update")) return;
      const duckScript = join(directory, "scripts", "graphify-duck.py");
      if (!existsSync(duckScript)) return;
      try {
        execSync(`python "${duckScript}" build`, {
          cwd: directory,
          stdio: "pipe",
          timeout: 30000,
        });
      } catch {
        // silent fail — build is optional
      }
    },
  };
};
