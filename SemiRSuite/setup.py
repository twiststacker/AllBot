from setuptools import setup, find_packages

setup(
    name="SemirSuite",
    version="1.0.0",
    author="Semir Music",
    author_email="DigitalFlow89@outlook.com",
    description="A comprehensive suite for AI model management and task routing.",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/twiststacker/SemirSuite",
    packages=find_packages(),
    install_requires=[
        "huggingface-hub",
        "fastapi",
        "jose",
        "python-dotenv",
        "psutil",
        "streamlit",
        "structlog",
        "jsonschema",
        "numpy",
        # Add other dependencies as needed
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.8",
)
