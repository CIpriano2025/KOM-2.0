---
name: kom-graphify
description: Integrates Graphify knowledge graph into the KOM 2.0 cycle. Use for codebase understanding, impact analysis, and context minimization during any KOM phase.
---

# KOM 2.0 — Graphify Integration

Graphify constrói um grafo de conhecimento do codebase. Esta skill integra o grafo nas 6 fases do KOM.

---

## Gatilho

Ativado automaticamente em:
- **Início de sessão:** Buildar/atualizar o grafo via `graphify update .`
- **Fase 1 (Orientação):** Carregar `graphify-out/GRAPH_REPORT.md` para entender o codebase
- **Fase 2 (Arquitetura):** Identificar god nodes (módulos centrais) e comunidades
- **Fase 4 (Execução):** Usar `graphify query` para contexto mínimo
- **Fase 5 (Verificação):** Usar `graphify affected` para análise de impacto

---

## Comandos

| Comando | Quando usar |
|---|---|
| `graphify .` | Buildar grafo completo (primeira vez) |
| `graphify update .` | Atualizar grafo após mudanças (AST-only, sem API) |
| `graphify query "pergunta"` | Buscar contexto mínimo no grafo |
| `graphify path "A" "B"` | Descobrir relação entre dois nós |
| `graphify explain "conceito"` | Explicar um nó e seus vizinhos |
| `graphify affected "arquivo"` | Descobrir o que é impactado por uma mudança |

---

## Integração por Fase

### Fase 1 — Orientação
Antes de começar, carregue `graphify-out/GRAPH_REPORT.md` para entender a estrutura do codebase.

### Fase 2 — Arquitetura
Use `graphify query "god nodes and communities"` para identificar módulos centrais e domínios.

### Fase 5 — Verificação
Use `graphify affected "arquivo-modificado"` para verificar impacto colateral.

---

## Notas

- Graphify é um complemento, não um substituto do KOM 2.0
- Requer Python 3.10+ e `pip install graphifyy`
- O plugin `.opencode/plugins/graphify.js` alerta antes de comandos bash quando o grafo existe
- `graphify update .` é AST-only (zero custo de API)
