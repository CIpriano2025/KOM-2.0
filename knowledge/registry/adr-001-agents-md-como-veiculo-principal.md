# ADR-001 — AGENTS.md como veículo principal de instruções

## Contexto

O KOM 2.0 precisa de um mecanismo para entregar suas instruções a qualquer agente de IA, em qualquer ferramenta, sem instalação, sem dependências e sem adaptadores por ferramenta.

As opções consideradas foram:
- Um SDK ou biblioteca que o agente importa
- Um servidor MCP que expõe as regras como ferramentas
- Um arquivo de instruções em markdown lido nativamente pelos agentes
- Prompts de sistema injetados manualmente pelo usuário

O formato AGENTS.md é mantido pela Linux Foundation Agentic AI Foundation e suportado por 28+ ferramentas e 60.000+ repositórios em 2026. A maioria dos agentes de IA modernos lê este arquivo automaticamente ao iniciar uma sessão em um diretório que o contenha.

## Decisão

Usar `AGENTS.md` como veículo principal de instruções do KOM 2.0.

**Opção escolhida:** Arquivo `AGENTS.md` na raiz do projeto

O KOM 2.0 é copiado (via `git clone`) para a raiz do projeto do usuário. O agente lê `AGENTS.md` automaticamente e segue o protocolo sem nenhuma configuração adicional.

## Consequências

### Positivas
- Zero dependências: funciona em qualquer projeto, qualquer linguagem
- Compatibilidade imediata com 15+ ferramentas (OpenCode, Cursor, Windsurf, Codex CLI, Claude Code, GitHub Copilot, Devin, Aider, Zed, Amp, Continue, Genie, Jules, JetBrains Junie, VS Code)
- Instalação = copiar arquivos (não há nada para instalar)
- O protocolo é legível por humanos e por agentes — sem camada opaca
- Atualizações do protocolo chegam via `git pull` sem breaking changes

### Negativas
- Depende de autodisciplina do agente para seguir as regras (sem enforcement automático)
- Agentes com contexto longo tendem a "esquecer" instruções enterradas no AGENTS.md
- Gemini CLI e Antigravity CLI não leem AGENTS.md — requerem arquivos separados (GEMINI.md, ANTIGRAVITY.md)
- Sem estado compartilhado entre sessões além dos arquivos `knowledge/`

### Neutras
- O protocolo convive com outros arquivos do projeto sem interferir

## Alternativas Consideradas

### Alternativa A: SDK / biblioteca
- **Prós:** Enforcement real, comportamento previsível
- **Contras:** Dependência de linguagem, instalação obrigatória, manutenção de versões
- **Motivo da rejeição:** Viola o princípio de independência de ferramenta e linguagem

### Alternativa B: Servidor MCP
- **Prós:** Ferramentas tipadas, enforcement via schema, integração nativa com qualquer agente MCP
- **Contras:** Requer infraestrutura (servidor rodando), configuração por projeto, barreira de entrada alta
- **Motivo da rejeição:** Complexidade incompatível com adoção imediata; reservado para versões futuras (ver RFC-001)

### Alternativa C: Prompts manuais pelo usuário
- **Prós:** Controle total, sem arquivos extras
- **Contras:** Frágil, não persistente, depende de memória do usuário a cada sessão
- **Motivo da rejeição:** Contradiz o objetivo de eliminar "prompt + esperança"

## Status

- [x] Proposto
- [x] Aceito
- [x] Implementado — `AGENTS.md` na raiz, `.opencode/skills/` para auto-ativação no OpenCode

## Referências

- `AGENTS.md` — implementação desta decisão
- `knowledge/registry/rfc-001-arquitetura-plataforma.md` — visão futura de plataforma MCP
- Linux Foundation Agentic AI Foundation — padrão AGENTS.md
