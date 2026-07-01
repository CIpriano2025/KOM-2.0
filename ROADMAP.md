# KOM 2.0 — Roadmap

> Este documento separa o que **existe hoje** do que está **planejado para o futuro**.
> O KOM 2.0 atual é um protocolo em markdown. A plataforma descrita na RFC-001 ainda não existe.

---

## ✅ O que existe hoje — Protocolo (v1.x)

O KOM 2.0 atual é um **protocolo de navegação em markdown**. Funciona copiando os arquivos para a raiz do seu projeto.

| Componente | Status | Descrição |
|---|---|---|
| `AGENTS.md` | ✅ Pronto | Instruções para qualquer agente de IA |
| Ciclo de 6 fases | ✅ Pronto | `kom/01` a `kom/06` com gates e anti-padrões |
| Governança | ✅ Pronto | `kom/07-governanca.md` |
| Loop Engineering | ✅ Pronto | `kom/08-loop-engineering.md` |
| 6 Skills OpenCode | ✅ Pronto | Auto-ativação por contexto |
| Plugin Graphify | ✅ Pronto | Lembrete de grafo antes de comandos bash |
| `kom-check.ps1` | ✅ Pronto | Verificação de 14 componentes |
| Template ADR (MADR) | ✅ Pronto | `knowledge/registry/_template-adr.md` |
| Compatibilidade 17 agentes | ✅ Documentada | Via AGENTS.md + arquivos por ferramenta |

---

## 🔄 Próximas versões — Protocolo aprimorado (v1.x)

Melhorias no protocolo atual, sem mudar a arquitetura:

| Item | Prioridade | Descrição |
|---|---|---|
| `CLAUDE.md` | Alta | Instruções nativas para Claude Code |
| `GEMINI.md` | Alta | Instruções para Gemini CLI |
| `ANTIGRAVITY.md` | Média | Instruções para Antigravity CLI |
| Exemplos de uso | Alta | Repositório de demonstração com knowledge base populado |
| Templates de `goal.md` | Média | Por tipo de projeto (API, refactor, bugfix) |
| `knowledge/patterns/` populado | Alta | Padrões que emergirem de uso real |

---

## 🚀 Visão futura — Plataforma (v2.x)

Descrita em detalhe na [RFC-001](knowledge/registry/rfc-001-arquitetura-plataforma.md).

A plataforma transforma o protocolo em ferramentas que aplicam as regras automaticamente — sem depender de autodisciplina do agente.

| Componente | Status | Descrição |
|---|---|---|
| KOM MCP Server | 📋 Planejado | Interface MCP: `kom.run`, `kom.context`, `kom.search`, `kom.validate`, `kom.review` |
| KOM Core | 📋 Planejado | Orquestração do ciclo, controle de estado |
| KOM Context | 📋 Planejado | Seleção de contexto mínimo |
| KOM Memory | 📋 Planejado | Busca e indexação no knowledge base |
| Memory Provider | 📋 Planejado | Abstração de banco (OpenSearch, Qdrant, PostgreSQL) |
| KOM Knowledge | 📋 Planejado | Documentação viva auto-atualizada |
| KOM Validator | 📋 Planejado | Validação automática de contratos |

> ⚠️ **Nada da v2.x existe ainda.** Se você está buscando uma plataforma com servidor e banco de dados, acompanhe o repositório para atualizações.

---

## Como contribuir

- **Bugs no protocolo:** abra uma [issue](https://github.com/CIpriano2025/KOM-2.0/issues)
- **Melhorias na documentação:** PR direto
- **Discussão sobre a RFC-001:** abra uma issue com a tag `rfc`
- **Exemplo de uso real:** PR adicionando um caso de uso em `examples/` (pasta a criar)

---

## Legenda

| Ícone | Significado |
|---|---|
| ✅ | Existe e funciona |
| 🔄 | Em desenvolvimento ou planejado próximo |
| 📋 | Planejado, sem data |
| ❌ | Descartado |
