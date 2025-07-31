from fastapi import FastAPI
from security.authentication import validate_token
from semirsuite.dashboard.metrics import update_metrics

app = FastAPI()

@app.post("/dispatch")
async def dispatch_task(request: dict):
    auth_token = request.get("auth_token")
    task_data = request.get("task")

    try:
        user = validate_token(auth_token)
        # Process the task data and route it (example logic)
        return {"status": "success", "message": "Task processed"}
    except Exception as e:
        update_metrics(user_id=user["user_id"],
task_description=task_data.get("task_description"), success=False)
        return {"status": "error", "message": str(e)}