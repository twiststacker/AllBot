import pytest
from semir.models import load_model, MODEL_CACHE
from unittest.mock import patch

@patch('semir.models.snapshot_download')
def test_model_loading(mock_snapshot_download):
    mock_snapshot_download.return_value = "dummy_path"
    model_path = load_model("text-gen")
    assert model_path.endswith("text-gen"), "Model path should end with 'text-gen'"

    with pytest.raises(ValueError):
        load_model("non-existent-model")

@patch('semir.models.snapshot_download')
def test_model_loading_failure(mock_snapshot_download):
    mock_snapshot_download.side_effect = Exception("Download Failed")
    with pytest.raises(Exception, match="Download Failed"):
        load_model("text-gen")
