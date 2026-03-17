{...}: {
  imports = [
    ../shared/opencode.nix
  ];

  # Home-specific OpenCode config (no work MCP servers)
  # https://opencode.ai/docs/config
  # TODO: customize providers and MCP servers for personal use
  xdg.configFile."opencode/opencode.jsonc".text = ''
    {
      "$schema": "https://opencode.ai/config.json",
      "autoupdate": true,
      "theme": "orng",
      "default_agent": "brainstorm",
      "share": "manual",
      "provider": {
        "amazon-bedrock": {
          "models": {
            "anthropic.claude-haiku-4-5-20251001-v1:0": {
              "cost": { "input": 0.8, "output": 4.0 },
              "limit": { "context": 200000, "output": 8192 },
              "name": "Claude Haiku 4 (Base)"
            },
            "anthropic.claude-sonnet-4-5-20250929-v1:0": {
              "cost": { "input": 3.0, "output": 15.0 },
              "limit": { "context": 200000, "output": 16000 },
              "name": "Claude Sonnet 4.5 (Base)"
            },
            "anthropic.claude-opus-4-5-20251101-v1:0": {
              "cost": { "input": 15.0, "output": 75.0 },
              "limit": { "context": 200000, "output": 16000 },
              "name": "Claude Opus 4.5 (Base)"
            }
          },
          "options": {
            "region": "us-east-2",
            "profile": "bedrock"
          }
        }
      },
      "mcp": {
        "github": {
          "type": "remote",
          "url": "https://api.githubcopilot.com/mcp",
          "headers": {
            "Authorization": "Bearer {file:~/.github-token}"
          }
        }
      },
      "agent": {
        "build": {
          "mode": "primary",
          "model": "amazon-bedrock/global.anthropic.claude-sonnet-4-6",
          "prompt": "{file:./prompts/build.txt}",
          "tools": {
            "write": true,
            "edit": true,
            "bash": true
          }
        },
        "plan": {
          "mode": "primary",
          "model": "amazon-bedrock/global.anthropic.claude-sonnet-4-6",
          "prompt": "{file:./prompts/plan.txt}",
          "temperature": 0.1,
          "tools": {
            "write": false,
            "edit": false,
            "bash": true
          }
        },
        "brainstorm": {
          "mode": "primary",
          "model": "amazon-bedrock/global.anthropic.claude-opus-4-6-v1",
          "prompt": "{file:./prompts/brainstorm.txt}",
          "temperature": 0.8,
          "tools": {
            "webfetch": true,
            "list": true,
            "grep": true,
            "glob": true,
            "read": true,
            "write": false,
            "edit": false,
            "bash": true
          },
          "permission": {
            "edit": "deny",
            "bash": {
              "*": "deny",
              "cat *": "allow",
              "file *": "allow",
              "git branch*": "allow",
              "git diff*": "allow",
              "git log*": "allow",
              "git rev-parse*": "allow",
              "git show*": "allow",
              "git status*": "allow",
              "head *": "allow",
              "ls *": "allow",
              "man *": "allow",
              "nix build * --dry-run*": "allow",
              "nix eval*": "allow",
              "nix develop*": "allow",
              "nix flake*": "allow",
              "rg *": "allow",
              "stat *": "allow",
              "tail *": "allow",
              "tree *": "allow",
              "wc *": "allow",
              "which *": "allow"
            }
          }
        }
      }
    }
  '';
}
