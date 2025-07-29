# 🖥️ AI Framework UI Setup Guide
*Step-by-step instructions to see and interact with AI framework interfaces*

## 🚀 Quick Start - Get UIs Running in 5 Minutes

### 1. **Flowise AI** - Drag & Drop LLM Builder
```bash
# Option 1: Using npx (fastest)
npx flowise start

# Option 2: Using npm
npm install -g flowise
flowise start

# Option 3: Using Docker
docker run -d --name flowise -p 3000:3000 flowiseai/flowise
```

**Access UI**: Open `http://localhost:3000`

**What you'll see**: 
- Visual canvas for building AI workflows
- Drag-and-drop components (LLMs, tools, memory)
- Pre-built templates and examples

---

### 2. **n8n** - Visual Workflow Automation
```bash
# Option 1: Using npx (fastest)
npx n8n

# Option 2: Using Docker
docker run -it --rm --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n n8nio/n8n

# Option 3: Using npm
npm install n8n -g
n8n start
```

**Access UI**: Open `http://localhost:5678`

**What you'll see**:
- Visual workflow builder
- 400+ integration nodes
- AI nodes (OpenAI, Anthropic, etc.)
- Trigger and automation options

---

### 3. **LangGraph Studio** (Desktop App)
```bash
# Download from official site
# Windows: Download .exe installer
# Mac: Download .dmg installer
# Linux: Download .AppImage

# Or using package managers:
# Mac with Homebrew:
brew install --cask langgraph-studio

# Windows with Chocolatey:
choco install langgraph-studio
```

**Access UI**: Desktop application (no browser needed)

**What you'll see**:
- Graph visualization of agent workflows
- Node-based workflow editor
- State management interface
- Debugging and monitoring tools

---

### 4. **NodeTool** - Visual AI Canvas
```bash
# Download desktop app
# Windows: Download from https://nodetool.ai
# Mac: Download .dmg from official site
# Linux: Download AppImage

# Or run locally:
git clone https://github.com/nodetool-ai/nodetool
cd nodetool
pip install -r requirements.txt
python main.py
```

**Access UI**: Desktop app or `http://localhost:8000`

**What you'll see**:
- Node-based AI workflow canvas
- Local AI model integration
- Real-time processing pipeline
- Privacy-first interface

---

### 5. **AutoGen Studio** - Multi-Agent UI
```bash
# Install AutoGen Studio
pip install autogen-studio

# Start the web UI
autogen-studio ui --port 8081
```

**Access UI**: Open `http://localhost:8081`

**What you'll see**:
- Multi-agent conversation interface
- Agent configuration panels
- Chat history and logs
- Skill and tool management

---

## 📱 Complete Setup with Screenshots Guide

### **Flowise AI Setup**

**Step 1: Installation**
```bash
npx flowise start
```

**Step 2: First Access**
- Go to `http://localhost:3000`
- You'll see the Flowise dashboard
- Click "Add New Chatflow"

**Step 3: What You Can Do**
- Build chatbots visually
- Connect to OpenAI, Anthropic, local models
- Add memory, tools, and integrations
- Test conversations in real-time

**Example First Flow:**
1. Drag "Chat Model" node (e.g., OpenAI)
2. Drag "Conversational Retrieval QA Chain"
3. Connect them
4. Add API key in settings
5. Click "Save" and test in chat

---

### **n8n Setup**

**Step 1: Quick Start**
```bash
npx n8n
```

**Step 2: Account Setup**
- Go to `http://localhost:5678`
- Create account (local only)
- You'll see the workflow canvas

**Step 3: Create Your First AI Workflow**
1. Click "Add first step"
2. Search "OpenAI" and select it
3. Configure with your API key
4. Add trigger (webhook, schedule, etc.)
5. Connect nodes and activate

**Example AI Workflow:**
```
Webhook Trigger → OpenAI Chat → Email Send
```

---

### **LangGraph Studio Setup**

**Step 1: Download & Install**
- Visit [LangGraph Studio](https://studio.langchain.com)
- Download for your OS
- Install and launch

**Step 2: Create Project**
- Click "New Project"
- Choose template or start blank
- You'll see the graph editor

**Step 3: Build Agent Flow**
- Add nodes for agents, tools, decisions
- Connect with edges
- Configure state management
- Test and debug

---

## 🐳 Docker Compose for All UIs

Save this as `docker-compose.yml`:

```yaml
version: '3.8'

services:
  # Flowise AI
  flowise:
    image: flowiseai/flowise
    restart: unless-stopped
    environment:
      - DEBUG=true
      - PORT=3000
      - DATABASE_PATH=/root/.flowise
      - APIKEY_PATH=/root/.flowise
      - SECRETKEY_PATH=/root/.flowise
      - LOG_PATH=/root/.flowise/logs
    ports:
      - "3000:3000"
    volumes:
      - flowise_data:/root/.flowise
    command: /bin/sh -c "sleep 3; flowise start"

  # n8n
  n8n:
    image: n8nio/n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - DB_TYPE=sqlite
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=password
    volumes:
      - n8n_data:/home/node/.n8n

  # AutoGen Studio (custom build)
  autogen-studio:
    build:
      context: .
      dockerfile: Dockerfile.autogen
    ports:
      - "8081:8081"
    environment:
      - PORT=8081
    volumes:
      - autogen_data:/app/data

  # Redis for message queues
  redis:
    image: redis:alpine
    restart: unless-stopped
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # PostgreSQL for shared data
  postgres:
    image: postgres:13
    restart: unless-stopped
    environment:
      - POSTGRES_DB=ai_agents
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  flowise_data:
  n8n_data:
  autogen_data:
  redis_data:
  postgres_data:
```

**Start all UIs:**
```bash
docker-compose up -d
```

**Access URLs:**
- Flowise: `http://localhost:3000`
- n8n: `http://localhost:5678` (admin/password)
- AutoGen Studio: `http://localhost:8081`

---

## 🛠️ Custom UI Setup for Code-Based Frameworks

### **CrewAI Web Interface**

Create a simple web UI for CrewAI:

```python
# app.py
import streamlit as st
from crewai import Agent, Task, Crew
import os

st.set_page_config(page_title="CrewAI Interface", page_icon="🤖")

st.title("🤖 CrewAI Web Interface")

# Sidebar for configuration
st.sidebar.header("Configuration")
openai_api_key = st.sidebar.text_input("OpenAI API Key", type="password")

if openai_api_key:
    os.environ["OPENAI_API_KEY"] = openai_api_key
    
    # Main interface
    st.header("Create Your AI Crew")
    
    # Agent configuration
    st.subheader("Configure Agents")
    
    col1, col2 = st.columns(2)
    
    with col1:
        researcher_role = st.text_input("Researcher Role", "Senior Research Analyst")
        researcher_goal = st.text_area("Researcher Goal", "Find and analyze information")
    
    with col2:
        writer_role = st.text_input("Writer Role", "Tech Content Writer")
        writer_goal = st.text_area("Writer Goal", "Create engaging content")
    
    # Task input
    st.subheader("Define Task")
    task_description = st.text_area("Task Description", "Research AI trends and write a summary")
    
    if st.button("🚀 Execute Crew"):
        with st.spinner("Crew working..."):
            # Create agents
            researcher = Agent(
                role=researcher_role,
                goal=researcher_goal,
                backstory="Expert in research and analysis",
                verbose=True
            )
            
            writer = Agent(
                role=writer_role,
                goal=writer_goal,
                backstory="Skilled content creator",
                verbose=True
            )
            
            # Create task
            task = Task(
                description=task_description,
                agent=researcher
            )
            
            # Create crew
            crew = Crew(
                agents=[researcher, writer],
                tasks=[task],
                verbose=True
            )
            
            # Execute
            result = crew.kickoff()
            
            # Display results
            st.success("Crew completed the task!")
            st.subheader("Results")
            st.write(result)

else:
    st.warning("Please enter your OpenAI API key in the sidebar to continue.")
```

**Run the interface:**
```bash
pip install streamlit crewai
streamlit run app.py
```

**Access**: Open `http://localhost:8501`

---

### **LangChain Chat Interface**

```python
# langchain_ui.py
import streamlit as st
from langchain.agents import create_react_agent, AgentExecutor
from langchain_community.tools.tavily_search import TavilySearchResults
from langchain_openai import ChatOpenAI
from langchain.prompts import PromptTemplate

st.title("🦜 LangChain Agent Interface")

# Configuration
st.sidebar.header("Settings")
openai_key = st.sidebar.text_input("OpenAI API Key", type="password")
tavily_key = st.sidebar.text_input("Tavily API Key", type="password")

if openai_key and tavily_key:
    # Initialize components
    llm = ChatOpenAI(api_key=openai_key, model="gpt-4")
    search_tool = TavilySearchResults(api_key=tavily_key, max_results=3)
    
    # Create agent
    prompt = PromptTemplate.from_template("""
    You are a helpful assistant. Use the search tool when you need current information.
    
    Tools available:
    {tools}
    
    Question: {input}
    {agent_scratchpad}
    """)
    
    agent = create_react_agent(llm, [search_tool], prompt)
    agent_executor = AgentExecutor(agent=agent, tools=[search_tool], verbose=True)
    
    # Chat interface
    st.subheader("Chat with AI Agent")
    
    if "messages" not in st.session_state:
        st.session_state.messages = []
    
    # Display chat history
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.write(message["content"])
    
    # Chat input
    if prompt_input := st.chat_input("Ask me anything..."):
        # Add user message
        st.session_state.messages.append({"role": "user", "content": prompt_input})
        with st.chat_message("user"):
            st.write(prompt_input)
        
        # Generate response
        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                response = agent_executor.invoke({"input": prompt_input})
                st.write(response["output"])
                st.session_state.messages.append({"role": "assistant", "content": response["output"]})

else:
    st.warning("Please enter your API keys in the sidebar.")
```

**Run:**
```bash
pip install streamlit langchain langchain-openai langchain-community tavily-python
streamlit run langchain_ui.py
```

---

## 📱 Mobile-Friendly Interfaces

### **Responsive Web UI for Any Framework**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Agent Interface</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .chat-container {
            height: 400px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            overflow-y: auto;
            margin-bottom: 20px;
            background: #f8f9fa;
        }
        
        .input-group {
            display: flex;
            gap: 10px;
        }
        
        input[type="text"] {
            flex: 1;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 25px;
            font-size: 16px;
        }
        
        button {
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .message {
            margin: 10px 0;
            padding: 15px;
            border-radius: 15px;
            max-width: 80%;
        }
        
        .user-message {
            background: #007bff;
            color: white;
            margin-left: auto;
        }
        
        .ai-message {
            background: #e9ecef;
            color: #333;
        }
        
        @media (max-width: 600px) {
            .container {
                margin: 10px;
                padding: 20px;
            }
            
            .input-group {
                flex-direction: column;
            }
            
            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🤖 AI Agent Interface</h1>
        <div class="chat-container" id="chatContainer">
            <div class="message ai-message">
                Hello! I'm your AI assistant. How can I help you today?
            </div>
        </div>
        
        <div class="input-group">
            <input type="text" id="messageInput" placeholder="Type your message here..." />
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>

    <script>
        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (!message) return;
            
            // Add user message
            addMessage(message, 'user');
            input.value = '';
            
            // Simulate AI response (replace with actual API call)
            setTimeout(() => {
                addMessage('I received your message: "' + message + '". This is where the AI response would go!', 'ai');
            }, 1000);
        }
        
        function addMessage(text, sender) {
            const chatContainer = document.getElementById('chatContainer');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}-message`;
            messageDiv.textContent = text;
            chatContainer.appendChild(messageDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
        
        // Allow Enter key to send message
        document.getElementById('messageInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    </script>
</body>
</html>
```

---

## 🔧 Troubleshooting Common UI Issues

### **Port Already in Use**
```bash
# Check what's using the port
lsof -i :3000  # or :5678, :8081, etc.

# Kill the process
kill -9 <PID>

# Or use different port
flowise start --port 3001
n8n start --port 5679
```

### **API Key Issues**
```bash
# Set environment variables
export OPENAI_API_KEY="your-key-here"
export ANTHROPIC_API_KEY="your-key-here"

# Or create .env file
echo "OPENAI_API_KEY=your-key-here" > .env
```

### **Docker Issues**
```bash
# Reset Docker
docker-compose down
docker-compose up --build

# Check logs
docker-compose logs flowise
docker-compose logs n8n
```

### **Permission Issues (Linux/Mac)**
```bash
# Fix permissions
sudo chown -R $USER:$USER ~/.n8n
sudo chown -R $USER:$USER ~/.flowise
```

---

## 🎯 Next Steps After Setup

### **1. Test Each Interface**
- Create a simple chatbot in Flowise
- Build a basic workflow in n8n
- Set up agent communication in AutoGen Studio

### **2. Connect Frameworks**
- Use webhooks to connect n8n → Flowise
- Set up API endpoints between systems
- Create shared databases for state management

### **3. Build Real Projects**
- Research automation pipeline
- Customer service bot
- Content creation workflow

---

## 📚 UI Documentation Links

- **Flowise**: [docs.flowiseai.com](https://docs.flowiseai.com)
- **n8n**: [docs.n8n.io](https://docs.n8n.io)
- **LangGraph Studio**: [studio.langchain.com](https://studio.langchain.com)
- **AutoGen Studio**: [microsoft.github.io/autogen](https://microsoft.github.io/autogen)
- **NodeTool**: [nodetool.ai/docs](https://nodetool.ai/docs)

---

*Start with one UI, get comfortable, then gradually add more frameworks to build your AI agent network!*

**Quick Start Recommendation**: Begin with **Flowise** (easiest) or **n8n** (most integrations), then add others as needed.