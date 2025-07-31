import json

def match_agent(task: dict, agents: list):
    required_capabilities = set(task.get("keywords", []))

    for agent in agents:
        available_capabilities = set(agent["capabilities"])
        if required_capabilities.issubset(available_capabilities):
            return agent["id"]

    return None

def load_agent_capabilities(file: str):
    try:
        with open(file, "r") as f:
            capabilities = json.load(f)
            return capabilities
    except FileNotFoundError as e:
        raise RuntimeError(f"Agent capabilities file not found: {str(e)}")
    except json.JSONDecodeError as e:
        raise RuntimeError(f"Failed to parse agent capabilities: {str(e)}")
