<p align="center">
  <img src="gemma-extruded-app.png" alt="Gemma Chat Logo" width="180" />
</p>

<h1 align="center">Gemma Chat</h1>

<p align="center">
  <strong>Vibe code without the internet.</strong><br/>
  A local coding agent powered by Google's Gemma 4 — runs entirely on your machine via local AI runtime.<br/>
  No API keys. No cloud. No Wi-Fi required.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Model-Gemma--4-blue?style=for-the-badge&logo=google" alt="Gemma 4" />
  <img src="https://img.shields.io/badge/Platform-macOS%20|%20Windows-lightgrey?style=for-the-badge&logo=apple" alt="Platforms" />
  <img src="https://img.shields.io/badge/Built%20with-Electron-9feaf9?style=for-the-badge&logo=electron" alt="Built with Electron" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License MIT" />
</p>

---

<p align="center">
  <img width="960" alt="Gemma Chat Demo" src="https://github.com/user-attachments/assets/b4149e63-48df-456e-8007-c607b7d46f37" />
</p>

## ✨ The Vision

Imagine building apps at 30,000 feet, in a remote cabin, or simply in a high-security environment where your code should never leave your machine. 

**Gemma Chat** is an open-source Electron application that brings Google's **Gemma 4** frontier models natively to your laptop. It’s not just a chat interface; it’s a **local-first coding agent** that writes code, manages files, and provides a live preview — all without an internet connection.

## 🚀 Core Features

- 🛠 **Build Mode (Vibe Coding)** — Describe your idea, and watch Gemma write HTML, CSS, and JavaScript. It handles multi-file projects in a sandboxed workspace with a real-time preview canvas.
- 💬 **Chat Mode** — A versatile conversational AI with integrated tool support (web search, URL fetching, calculator, bash).
- 🔄 **Model Hot-Swapping** — Switch between 4 Gemma variants (from 1.5GB to 31B) on the fly without restarting the app.
- 🎤 **Whisper Voice Input** — Talk to your agent using local speech-to-text via in-browser Whisper (transformers.js).
- ✈️ **100% Offline** — After the initial model download, the app requires zero connectivity.
- 💾 **Zero-Config Runtime** — Automatically provisions local environments (Python venv, MLX, Ollama) on first launch.

## 🧠 Available Models

| Model | Size | Best For | Requirement |
|---|---|---|---|
| **Gemma 4 E2B** | ~1.5 GB | Ultra-fast tasks, mobile-level hardware | 8GB+ RAM |
| **Gemma 4 E4B** | **~3 GB** | **Recommended.** Balanced speed & logic | 8GB+ RAM |
| **Gemma 4 27B MoE**| ~16 GB | Deep reasoning, complex coding | 16GB+ RAM |
| **Gemma 4 31B** | ~18 GB | Frontier quality, maximum accuracy | 32GB+ RAM |

## 🛠 Getting Started

### Prerequisites
- **macOS:** Apple Silicon (M1/M2/M3), Python 3.10+, Node 20+.
- **Windows:** Node 20+ and [Ollama](https://ollama.com/).

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ammaarreshi/gemma-chat.git
   cd gemma-chat
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Launch the app:**
   - **macOS:** `npm run dev`
   - **Windows:** Run the automated setup script:
     ```bat
     setup_and_run.bat
     ```

*On the first launch, the app will detect your hardware and download the recommended Gemma 4 model (~3GB).*

## 🏗 Technology Stack

| Layer | Technology |
|---|---|
| **Shell** | Electron + Vite + TypeScript |
| **UI** | React 19 + Tailwind CSS + Lucide Icons |
| **Inference (Mac)** | [MLX-LM](https://github.com/ml-explore/mlx) by Apple Research |
| **Inference (Win)** | [Ollama](https://ollama.com/) |
| **Voice** | Transformers.js (Whisper WASM) |
| **Storage** | Sandboxed Filesystem + Local HTTP Server |

## 📐 Architecture

```text
src/
├── main/              Electron Main Process (IPC, Tool Engine, Runtime Control)
├── renderer/          React Frontend (Build Canvas, Chat UI, Voice Pipeline)
├── shared/            Type definitions and Model Registry
└── workspace/         Sandboxed user projects with live-reload server
```

### The Agent Loop
In **Build Mode**, the app uses an XML-based tool protocol. As the model streams tokens, the main process parses `<action>` tags in real-time. If a `write_file` action is detected, the file is updated on disk every 450ms, triggering the preview iframe to refresh instantly.

## 🤝 Credits

- **[Gemma](https://ai.google.dev/gemma)** by Google DeepMind
- **[MLX](https://github.com/ml-explore/mlx)** by Apple Machine Learning Research
- **[Ollama](https://ollama.com/)** for the Windows runtime
- Created by **[@ammaar](https://x.com/ammaar)** and AI.

---

<p align="center">
  Licensed under the <a href="LICENSE">MIT License</a>.
</p>
