# 🚀 AI-Powered HR Recruitment Crew  

An **AI-driven recruitment system** built with **CrewAI, FastAPI, and LlamaIndex** to automate:

✅ **Candidate Sourcing** (Finds potential candidates online).
✅ **Resume Screening** (Filters top applicants using AI).
✅ **Interview Scheduling** (Confirms slots with candidates).

---

## 📌 **How It Works**  
This workflow follows **3 key steps**:

1️⃣ **HR Recruiter** finds **10 potential candidates**.  
2️⃣ **AI Screener** analyzes resumes and **shortlists 5 best fits**.  
3️⃣ **Interview Coordinator** schedules **interviews** using a mock API.  

---

## 🛠 **Tech Stack**  

- **[FastAPI](https://fastapi.tiangolo.com/)** - A fast web framework for building APIs with Python.  
- **[CrewAI](https://github.com/joaomdmoura/crewai)** - Manages multi-agent AI workflows.  
- **[LangChain](https://python.langchain.com/)** - Integrates AI-powered tools and agents.  
- **[LlamaIndex](https://llamaindex.ai/)** - Connects LLMs to structured resume data.  
- **[Railway.app](https://railway.app/)** - Deploys the API directly from GitHub.  

---

# 🛠 **Setting Up the Development Environment**  

## **2.1 Prerequisites**  
Ensure you have the following installed:  
✅ **Python 3.7+** installed.  
✅ **Git** installed.  
✅ **A GitHub account** (For version control).  
✅ **OpenAI API Key** (For LLM processing) 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 
✅ **SerpAPI Key** _(or Google Cloud API Key)_ (For web search). 4b66f1f31e657fdb7d42f1f7814eb057fe905e27 
✅ **Docker (Optional)** - To containerize and deploy the application easily.

---

## 🚀 **Installation & Setup**  

### 1️⃣ **Clone the Repository**  
```bash
git clone https://github.com/your-username/hr-recruitment-crew.git
cd hr-recruitment-crew
```

### 2️⃣ Install Dependencies  
```bash
pip install crewai crewai_tools llama_index fastapi uvicorn langchain argparse
```

### 3️⃣ Set Up API Keys  
```bash
export SERPER_API_KEY="your_serper_api_key"
export OPENAI_API_KEY="your_openai_api_key"
```

### 4️⃣ Run the Recruitment Process  
```bash
python recruitment_script.py "Software Engineer"
```
(Replace "Software Engineer" with any job role.)  

---

## 🏗 Project Structure  
```
├── README.md
├── recruitment_script.py   # Main AI recruitment script
├── api.py                  # FastAPI server
├── candidates_index.json   # (Optional) LlamaIndex for resume storage
├── Dockerfile              # Docker container setup
├── requirements.txt        # Python dependencies
├── .github/workflows/deploy.yml  # GitHub Actions workflow for deployment
```

---

## 📡 GitHub Actions Workflow for Automated Deployment  

To automate deployment using **GitHub Actions**, add the following workflow file to your repository:

### 1️⃣ Create Workflow Directory & File  
```bash
mkdir -p .github/workflows
nano .github/workflows/deploy.yml
```

### 2️⃣ Add the Workflow Configuration  
```yaml
name: Deploy to Railway

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v3
        with:
          python-version: '3.9'

      - name: Install Dependencies
        run: |
          pip install crewai crewai_tools llama_index fastapi uvicorn langchain argparse

      - name: Deploy to Railway
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
        run: |
          curl -X POST https://api.railway.app/deploy --header "Authorization: Bearer $RAILWAY_TOKEN"
```

### 3️⃣ Configure GitHub Secrets  
Go to **GitHub Repository Settings → Secrets and Variables → Actions**, and add:
- `RAILWAY_TOKEN`: Your Railway API token.

### 4️⃣ Commit & Push Changes  
```bash
git add .github/workflows/deploy.yml
git commit -m "Added GitHub Actions for automated deployment"
git push origin main
```

Once pushed, GitHub Actions will automatically deploy your application to Railway.app. 🚀

---

## 📡 FastAPI Integration  
You can expose the recruitment pipeline as an API using FastAPI.

### 1️⃣ Run FastAPI Server  
```bash
uvicorn api:app --host 0.0.0.0 --port 8000 --reload
```

### 2️⃣ FastAPI Endpoints  
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/recruit/{job_role}` | GET | Run the recruitment pipeline for a job role. |
| `/candidates/` | GET | Retrieve stored candidates from LlamaIndex. |

---

## 📂 Expected Output  

### ✅ Terminal Output  
```plaintext
🔍 Searching for candidates...
✅ Found 10 candidate profiles.
📄 Screening resumes...
✅ Shortlisted 5 candidates.
📅 Scheduling interviews...
✅ Interviews confirmed: 
- John Doe - 3 PM
- Jane Smith - 4 PM
```

### 📂 File Output  
To save shortlisted candidates, modify the script:
```python
with open("shortlisted_candidates.txt", "w") as f:
    f.write(result)
```

---

## 🚀 Deployment on Railway.app  

### 1️⃣ Deploy on Railway  
Click the button below to deploy directly on Railway.app 🚀

### 2️⃣ Set Environment Variables  
In Railway.app, add the following environment variables:
```ini
SERPER_API_KEY = your_serper_api_key
OPENAI_API_KEY = your_openai_api_key
```

### 3️⃣ Access Your API  
Once deployed, your API will be live at:
```bash
https://your-railway-app-url/recruit/Software%20Engineer
```

---

## 🛠 Key Features  

| Feature | Status |
|---------|--------|
| Agents | ✅ Tested with role-specific logic. |
| Tasks | ✅ Candidate sourcing, screening, and scheduling. |
| Crews | ✅ Collaboration between HR and AI. |
| Flows | ✅ Ensures sourcing → screening → scheduling execution. |
| Knowledge (LlamaIndex) | ✅ Used for resume storage/retrieval. |
| LLMs | ✅ Used for text-based resume screening. |
| Processes | ✅ Validates the hiring process. |
| Collaboration | ✅ Ensures agent information sharing. |
| Training | ❌ Not included (LLM fine-tuning out of scope). |
| Memory | ✅ Retains candidate insights. |
| Planning | ✅ Logical recruitment workflow. |
| CLI | ✅ Supports terminal execution. |
| Tools | ✅ Uses LangChain search & mock APIs. |
| Docker | ✅ Containerized for easy deployment. |

---

## 🚀 Future Enhancements  
Want to take it further? Here’s what’s next:

🔹 Google Calendar API → Real interview scheduling.  
🔹 Custom Resume Parser → NLP for deeper candidate analysis.  
🔹 Candidate Assessments → AI-powered screening tests.  

---

## 📜 License  
This project is open-source. Feel free to contribute!  

```nginx
MIT License
```

