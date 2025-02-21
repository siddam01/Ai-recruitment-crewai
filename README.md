# Travel Crew Backend API Documentation (Railway Deployment) - Final

This document provides a comprehensive guide for setting up, deploying, and using the Travel Crew backend API. This API is built using Python, FastAPI, LangChain, and LlamaIndex, and is designed to power intelligent trip planning functionalities. The API is deployed on Railway.app for ease of use and scalability.

## 1. Project Overview

The Travel Crew backend API provides endpoints for analyzing travel destinations based on user input. It leverages:

- **FastAPI**: A modern, fast web framework for building APIs with Python.
- **LangChain**: A framework for developing applications powered by language models. It's used here for agent management and tool integration.
- **LlamaIndex**: A tool for connecting LLMs to external data. It's used to create a knowledge base of travel information.
- **Railway.app**: A platform for deploying web applications directly from GitHub repositories.

## 2. Setting Up the Development Environment

### 2.1 Prerequisites

- Python 3.7+ installed.
- Git installed.
- A GitHub account.
- An OpenAI API Key.
- A SerpAPI Key (or Google Cloud API Key if preferred).

### 2.2 Repository Setup

1. Create a new repository on GitHub named `travel-crew-backend`.
2. Clone the repository locally:

```bash
git clone https://github.com/your-username/travel-crew-backend.git
cd travel-crew-backend
```

### 2.3 Dependencies

Create a `requirements.txt` file in the root of your repository with the following dependencies:

```
crewai>=0.1.2
langchain>=0.1.0
llama-index>=0.9.0
fastapi>=0.100.0
uvicorn>=0.23.0
python-dotenv>=1.0.0
requests>=2.31.0
pandas>=2.1.0  # Optional
matplotlib>=3.7.0 # Optional
seaborn>=0.12.0 # Optional
plotly>=5.18.0 # Optional
```

Install the dependencies:

```bash
pip install -r requirements.txt
```

### 2.4 Application Code (`main.py`)

```python
from fastapi import FastAPI, HTTPException, Header
from pydantic import BaseModel
from typing import List
from crewai import Agent, Task, Crew, Process
from agents.destination_researcher import DestinationResearcher
from agents.budget_analyst import BudgetAnalyst
from agents.cultural_expert import CulturalExpert
from agents.safety_advisor import SafetyAdvisor
from agents.data_visualizer import DataVisualizer
from tools.search_tools import initialize_search_tools
from tools.data_tools import initialize_data_tools
from tools.visualization_tools import initialize_visualization_tools

app = FastAPI()

class TripRequest(BaseModel):
    destinations: List[str]
    preferences: str
    required_analyses: List[str]

def create_specialized_crew(request: TripRequest):
    search_tools = initialize_search_tools()
    data_tools = initialize_data_tools()
    viz_tools = initialize_visualization_tools()
    
    researcher = DestinationResearcher(search_tools).create_agent()
    analyst = BudgetAnalyst(data_tools).create_agent()
    cultural_expert = CulturalExpert(search_tools).create_agent()
    safety_advisor = SafetyAdvisor(search_tools + data_tools).create_agent()
    visualizer = DataVisualizer(viz_tools).create_agent()
    
    tasks = [
        Task(description=f"Research comprehensive details about destinations: {', '.join(request.destinations)}", agent=researcher),
        Task(description=f"Analyze costs and create budget breakdown based on preferences: {request.preferences}", agent=analyst),
        Task(description="Provide detailed cultural insights and local experiences", agent=cultural_expert),
        Task(description="Assess safety considerations and current travel conditions", agent=safety_advisor),
        Task(description="Create visual comparisons and data representations", agent=visualizer)
    ]
    
    return Crew(
        agents=[researcher, analyst, cultural_expert, safety_advisor, visualizer],
        tasks=tasks,
        process=Process.hierarchical
    )

@app.post("/analyze-trip")
async def analyze_trip(request: TripRequest, authorization: str = Header(None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Authorization required")
    
    try:
        crew = create_specialized_crew(request)
        result = crew.kickoff()
        return {"analysis": result, "status": "success"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

## 8. Testing Specific Components

- **Agents**: Test individual agent logic and their interactions with tools. Mock external API calls if necessary to isolate the agent's behavior.
- **Tasks**: If you have a task management system, test each task's execution and its inputs/outputs.
- **Crews**: Test the overall workflow of a crew, ensuring that agents collaborate as expected.
- **Flows**: Verify the execution order of tasks and data transfer between agents.
- **Knowledge (LlamaIndex)**: Test the knowledge base with various queries.
- **LLMs**: Test the integration by providing specific inputs and checking outputs.
- **Processes**: Validate the entire trip-planning process.
- **Collaboration**: Ensure agents communicate and share information effectively.
- **Training**: LLM training testing is beyond this document's scope.
- **Memory**: Test the agent's ability to retain and use relevant information.
- **Planning**: Validate the agent's planning logic.
- **CLI**: Test CLI functionality, if available.
- **Tools (LangChain/LlamaIndex)**: Test each tool individually and mock external API calls where needed.

---

This documentation provides a detailed guide to setting up, deploying, and testing the Travel Crew backend API on Railway. Follow these steps for a smooth deployment and ensure a scalable, intelligent trip-planning experience.
