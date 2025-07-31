# SemirSuite 🧠📦

SemirSuite is a modular AI orchestration framework designed for task routing, model execution, authentication, and telemetry collection.

## 📂 Structure

- `agents/`: Task routing logic
- `model_management/`: Model definitions and dynamic loading
- `security/`: Token-based authentication
- `utils/`: Logging and configuration utilities
- `dashboard/`: Metrics collection and reporting
- `main.py`: Application entrypoint

## ⚙️ How It Works

1. Incoming task request is authenticated.
2. Task is routed to the proper agent.
3. Associated model is loaded and executed.
4. Metrics and logs are updated.

## 🧪 Running Locally

```bash
pip install flask
python semirsuite/main.py