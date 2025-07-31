import json

def match_agent(task: dict, agents: list):
    """
    Matches a task to an agent based on capabilities.
    
    Args:
        task (dict): Task details containing keywords.
        agents (list): List of agents with their capabilities.
        
    Returns:
        str or None: Agent ID if matched, otherwise None.
    """
    for agent in agents:
        if set(task["keywords"]).issubset(set(agent["capabilities"])):
            return agent["id"]
    return None

def load_agent_capabilities(file: str):
    """
    Loads agent capabilities from a JSON file.
    
    Args:
        file (str): Path to the JSON file containing agent capabilities.
        
    Returns:
        list: List of agents with their capabilities.
    """
    with open(file, "r") as f:
        return json.load(f)
