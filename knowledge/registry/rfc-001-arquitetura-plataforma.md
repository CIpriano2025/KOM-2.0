# RFC-001 — Arquitetura do KOM 2.0 como Plataforma

> **Status:** Proposta — não implementada. O que existe hoje é o protocolo (metodologia em markdown).
> Esta RFC descreve a evolução futura para uma plataforma de engenharia de software.

---

## Objetivo

Transformar o KOM 2.0 em uma plataforma de engenharia de software para IA, mantendo sua essência:

> **"Qualquer IA deve conseguir desenvolver projetos complexos sem se perder, recebendo apenas o contexto necessário no momento certo."**

O KOM não substitui a IA.

Ele organiza, prepara, valida e preserva o conhecimento do projeto.

---

## Princípios

### 1. Simplicidade

Cada módulo possui apenas uma responsabilidade.

Nenhum módulo deve conhecer detalhes internos dos outros.

---

### 2. Independência de IA

O KOM deve funcionar com qualquer IA compatível com MCP.

| Agente | Lê AGENTS.md? | Arquivo principal | Formato de regras |
|---|---|---|---|
| **OpenCode** | ✅ Nativo | `AGENTS.md` | `.opencode/skills/SKILL.md` |
| **Codex CLI** | ✅ Nativo (criador) | `AGENTS.md` | `.codex/skills/SKILL.md` |
| **Claude Code** | ✅ Nativo (fallback) | `CLAUDE.md` (nativo) | `.claude/rules/*.md` |
| **Cursor** | ✅ Nativo | `AGENTS.md` | `.cursor/rules/*.mdc` |
| **Windsurf** | ✅ Nativo | `AGENTS.md` | `.windsurf/rules/` |
| **GitHub Copilot** | ✅ Nativo | `AGENTS.md` | `.github/copilot-instructions.md` |
| **Gemini CLI** | ❌ | `GEMINI.md` | — |
| **Antigravity CLI** | ❌ | `ANTIGRAVITY.md` | — |

---

### 3. Independência de Banco

O KOM nunca deve depender diretamente do OpenSearch.

Toda comunicação deve ocorrer através de uma interface de memória (Memory Provider).

Implementações previstas:
- OpenSearch (primeira)
- Elasticsearch
- PostgreSQL
- Neo4j
- Qdrant
- Weaviate

---

### 4. Contexto Mínimo

A IA nunca deve receber o projeto inteiro — apenas o contexto relevante no momento certo:
- contexto relevante
- documentação relevante
- decisões relevantes
- arquivos relevantes
- testes relevantes

---

### 5. Conhecimento Persistente

Todo conhecimento produzido deve ser reutilizado futuramente.

---

## Arquitetura Proposta

```
IA / IDE
    │
    ▼
KOM MCP Server
    │
    ▼
KOM Core
    │
    ├── Spec
    ├── Planner
    ├── Context
    └── Executor
            │
            ▼
        Validator
            │
            ▼
          Review
            │
            ▼
        Knowledge
            │
            ▼
          Memory
            │
            ▼
    Memory Provider
      │           │
 OpenSearch   Elasticsearch
```

---

## Módulos

### KOM Core
Orquestra a metodologia. Controla ordem e estado. Não conhece banco de dados.

### KOM MCP
Única interface entre IA e KOM. Expõe ferramentas MCP, valida parâmetros, nunca implementa regras de metodologia.

### KOM Spec
Gerencia especificações, contratos, requisitos e critérios de aceite.

### KOM Planner
Transforma objetivos em tarefas pequenas com dependências e sequência.

### KOM Context
Seleciona o menor contexto possível. Nunca envia arquivos desnecessários.

### KOM Executor
Executa código, comandos, scripts e integrações.

### KOM Validator
Valida Spec, arquitetura, qualidade e testes.

### KOM Review
Registra aprendizados após conclusão e alimenta o Knowledge.

### KOM Knowledge
Mantém documentação viva: README, Architecture.md, API.md, ADRs, Changelog, diagramas, guias. Atualiza automaticamente após cada ciclo.

### KOM Memory
Gerencia conhecimento persistente (busca, indexa, atualiza). Não conhece OpenSearch — usa apenas o Memory Provider.

### Memory Provider
Interface de armazenamento substituível. Primeira implementação: OpenSearch.

---

## Ferramentas MCP (Versão Inicial)

Apenas 5 ferramentas expostas — o KOM esconde sua complexidade interna:

```
kom.run()       → inicia o ciclo completo
kom.context()   → retorna contexto mínimo para a tarefa
kom.search()    → busca no knowledge base
kom.validate()  → valida entrega contra contrato
kom.review()    → registra aprendizados pós-entrega
```

---

## Fluxo de Execução

```
Usuário → IA → KOM MCP → KOM Core → Planner → Context → Memory
→ Executor → Validator → Review → Knowledge → Memory Update → Resposta
```

---

## Fluxo de Conhecimento

```
Código → Review → Knowledge → Documentação → Memory → OpenSearch
```

---

## Fora do escopo desta versão

Não implementar na primeira versão da plataforma:
- GraphRAG
- Multiagentes
- Knowledge Graph
- Aprendizado automático
- Memória distribuída
- Busca híbrida
- Embeddings obrigatórios

---

## Estrutura sugerida do repositório (futura)

```
KOM-2.0/
├── methodology/       ← filosofia, princípios, fluxo (existe hoje)
├── implementation/    ← código do Core, MCP, Memory, Knowledge
├── docs/
├── templates/
└── examples/
```

---

## Definição Oficial

> **KOM 2.0 é uma plataforma de engenharia de software orientada por metodologia, construída para permitir que qualquer IA desenvolva projetos complexos de forma consistente, utilizando apenas o contexto necessário, preservando conhecimento e mantendo documentação viva.**

---

## Referências

- `AGENTS.md` — protocolo atual (metodologia em markdown)
- `knowledge/registry/adr-001-agents-md-como-veiculo-principal.md` — decisão de usar AGENTS.md
- `kom/00-manifesto.md` — filosofia e princípios
