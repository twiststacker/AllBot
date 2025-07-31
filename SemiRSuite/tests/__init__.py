"""
SemirSuite: A suite for AI model management, task routing, and monitoring.
"""

__version__ = "1.0.0"
__author__ = "Your Name"

from .models import load_model
from .logging import setup_logger
from .auth import verify_token
from .security import get_ssl_context
from .routing import match_agent
from .dashboard import display_system_health

# Make the package modules visible
__all__ = [
    "load_model",
    "setup_logger",
    "verify_token",
    "get_ssl_context",
    "match_agent",
    "display_system_health",
]
