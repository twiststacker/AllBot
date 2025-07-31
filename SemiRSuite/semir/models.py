import os
from huggingface_hub import snapshot_download
import logging

MODEL_CACHE = "models/"
MODELS = {
    "text-gen": "semir/text-gen@v1.2.0",
    "summarizer": "semir/summarizer@v1.0.1",
}

logger = logging.getLogger(__name__)

def load_model(name: str):
    model_id = MODELS.get(name)
    if not model_id:
        raise ValueError(f"Unknown model: {name}")

    model_path = os.path.join(MODEL_CACHE, name)
    try:
        if not os.path.exists(model_path):
            logger.info(f"Downloading model {model_id}...")
            snapshot_download(repo_id=model_id, cache_dir=model_path, local_dir=model_path)
            logger.info(f"Successfully downloaded {model_id} to {model_path}")
        else:
            logger.debug(f"Model {model_id} already exists at {model_path}")
    except Exception as e:
        logger.error(f"Failed to download model {model_id}: {str(e)}")
        raise

    return model_path
