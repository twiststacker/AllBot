import logging
import structlog

def setup_logger(name="semir"):
    logging.basicConfig(
        format="%(asctime)s - %(levelname)s - %(message)s",
        level=logging.DEBUG,
    )

    logger = structlog.get_logger(name)
    logger = logger.bind(service="SemirSuite", version="1.0.0")

    return logger
